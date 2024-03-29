note
	description:
		"Eiffel Vision multi column list. Mswindows implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2017-03-27 17:23:22 +0000 (Mon, 27 Mar 2017) $"
	revision: "$Revision: 100056 $"

class
	EV_MULTI_COLUMN_LIST_IMP

	--| Note that we need to handle {WEL_SYSTEM_PARAMETERS_INFO}.has_drag_full_windows
	--| As the resize actions are fired from different events depending on the state
	--| of this flag.

inherit
	EV_MULTI_COLUMN_LIST_I
		redefine
			interface,
			make,
			remove_row_pixmap,
			wipe_out
		end

	EV_PRIMITIVE_IMP
		undefine
			on_right_button_down,
			on_left_button_down,
			on_middle_button_down,
			on_left_button_up,
			on_left_button_double_click,
			on_middle_button_double_click,
			on_right_button_double_click,
			pnd_press,
			escape_pnd,
			set_background_color,
			set_foreground_color
		redefine
			on_mouse_move,
			on_key_down,
			interface,
			set_default_minimum_size,
			make,
			on_size,
			enable_sensitive, disable_sensitive,
			background_color_internal,
			destroy
		end

	EV_ITEM_LIST_IMP [EV_MULTI_COLUMN_LIST_ROW, EV_MULTI_COLUMN_LIST_ROW_IMP]
		redefine
			interface,
			make,
			wipe_out
		end

	EV_PICK_AND_DROPABLE_ITEM_HOLDER_IMP
		redefine
			interface
		end

	WEL_LIST_VIEW
		rename
			make as wel_make,
			parent as wel_parent,
			set_parent as wel_set_parent,
			destroy as wel_destroy,
			shown as is_displayed,
			font as wel_font,
			set_font as wel_set_font,
			selected_items as wel_selected_items,
			selected_item as wel_selected_item,
			get_item as wel_get_item,
			insert_item as wel_insert_item,
			set_column_width as wel_set_column_width,
			get_column_width as wel_get_column_width,
			set_column_title as wel_set_column_title,
			set_background_color as wel_set_background_color,
			column_count as wel_column_count,
			item as wel_item,
			move as wel_move,
			enabled as is_sensitive,
			width as wel_width,
			height as wel_height,
			x as x_position,
			y as y_position,
			resize as wel_resize,
			move_and_resize as wel_move_and_resize,
			count as wel_count,
			has_capture as wel_has_capture
		undefine
			set_width,
			set_height,
			on_left_button_down,
			on_middle_button_down,
			on_right_button_down,
			on_left_button_up,
			on_middle_button_up,
			on_right_button_up,
			on_left_button_double_click,
			on_middle_button_double_click,
			on_right_button_double_click,
			on_mouse_move,
			on_mouse_wheel,
			on_set_focus,
			on_desactivate,
			on_kill_focus,
			on_key_down,
			on_key_up,
			on_char,
			on_set_cursor,
			show,
			hide,
			x_position,
			y_position,
			on_sys_key_down,
			on_sys_key_up,
			default_process_message,
			on_getdlgcode,
			on_wm_dropfiles
		redefine
			on_lvn_columnclick,
			on_lvn_itemchanged,
			on_size,
			on_erase_background,
			default_style,
			process_message,
			on_notify,
			default_ex_style
		end

	WEL_COLOR_CONSTANTS
		export {NONE}
			all
		end

create
	make

feature -- Initialization

	old_make (an_interface: attached like interface)
			-- Make with `an_interface'.
		do
			assign_interface (an_interface)
		end

	make
			-- Initialize `Current'.
		local
			wel_column: WEL_LIST_VIEW_COLUMN
		do
			create ev_children.make (0)
			create internal_selected_items.make (2)

				-- Create the WEL LISTVIEW.
			wel_make (default_parent, 0, 0, 0, 0, 0)
			Precursor {EV_ITEM_LIST_IMP}
			Precursor {EV_MULTI_COLUMN_LIST_I}
			Precursor {EV_PRIMITIVE_IMP}

				-- Create the last column
			create wel_column.make
			wel_column.set_width (Lvscw_autosize_useheader)
			wel_column.set_text ("")
			insert_column (wel_column, 0)

				-- Compute the default height of a row			
			wel_insert_item (create {WEL_LIST_VIEW_ITEM}.make)
			wel_insert_item (create {WEL_LIST_VIEW_ITEM}.make)
			default_row_height := get_item_position (1).y - get_item_position (0).y
			reset_content

				-- Set the height of a row to the default height
			row_height := default_row_height

				-- Set the WEL extended view style
			if comctl32_version >= version_470 then
				set_extended_view_style (get_extended_view_style +
					Lvs_ex_fullrowselect + lvs_ex_infotip)
			end
		end

feature -- Access

	selected_item: detachable EV_MULTI_COLUMN_LIST_ROW
			-- Currently selected item.
			-- Topmost selected item if multiple items are selected.
			-- (For multiple selections see `selected_items').
			--
			-- Void if there is no selection.
		local
			local_selected_index: INTEGER
		do
			local_selected_index := wel_selected_item
			if local_selected_index >= 0 then
				Result := (ev_children @ (local_selected_index + 1)).interface
			end
		end

	selected_items: DYNAMIC_LIST [EV_MULTI_COLUMN_LIST_ROW]
			-- Currently selected items.
		do
			if not internal_selected_items_uptodate then
				internal_selected_items := retrieve_selected_items
				internal_selected_items_uptodate := True
			end
			Result := internal_selected_items.twin
		ensure then
			valid_result: Result.is_equal(retrieve_selected_items)
		end

	row_height: INTEGER
			-- Height in pixels of each row.

feature -- Status report

	multiple_selection_enabled: BOOLEAN
			-- Can more that one item be selected?

	title_shown: BOOLEAN
			-- Is a row displaying column titles shown?
		do
			Result := not flag_set (style, Lvs_nocolumnheader)
		end

feature -- Status setting

	ensure_item_visible (an_item: EV_MULTI_COLUMN_LIST_ROW)
			-- Ensure `an_item' is visible in `Current'.
		local
			item_imp: detachable EV_MULTI_COLUMN_LIST_ROW_IMP
		do
			item_imp ?= an_item.implementation
			check
				item_imp_not_void: item_imp /= Void then
			end
			ensure_visible (internal_get_index (item_imp) - 1)
		end

	select_item (an_index: INTEGER)
			-- Select item at `an_index'.
		do
			(ev_children @ an_index).enable_select
		end

	deselect_item (an_index: INTEGER)
			-- Deselect item at `an_index'.
		do
			(ev_children @ an_index).disable_select
		end

	clear_selection
			-- Make `selected_items' empty.
			-- Unselect any selected items.
		local
			c: like selected_items
		do
			c := selected_items
			from
				c.start
			until
				c.after
			loop
				c.item.disable_select
				c.forth
			end
		end

	enable_multiple_selection
			-- Allow more than one item to be selected.
		do
			if not multiple_selection_enabled then
				if has_headers then
					set_style (default_style - Lvs_singlesel)
				else
					set_style (default_style - Lvs_singlesel +
						Lvs_nocolumnheader)
				end
				multiple_selection_enabled := True

					-- The scroll bars become hidden, but by calling `update_item'
					-- it forces `Current' to redisplay them if necessary.
				if count > 0 then
					update_item (count - 1)
				end
			end
		end

	disable_multiple_selection
			-- Allow only one item to be selected.
		local
			old_selected_item: detachable EV_MULTI_COLUMN_LIST_ROW
		do
			if multiple_selection_enabled then
					-- Unselect all selected and remember the top
					-- most selected item.
				old_selected_item := selected_item
				clear_selection

					-- Set the new style
				if has_headers then
					set_style (default_style)
				else
					set_style (default_style + Lvs_nocolumnheader)
				end
				multiple_selection_enabled := False

					-- Reselect the top most item
				if old_selected_item /= Void then
					old_selected_item.enable_select
				end
					-- The scroll bars become hidden, but by calling `update_item'
					-- it forces `Current' to redisplay them if necessary.
				if count > 0 then
					update_item (count - 1)
				end
			end
		end

	enable_sensitive
			-- Make object sensitive to user input.
		do
			Precursor {EV_PRIMITIVE_IMP}
			invalidate
			update
		end

	disable_sensitive
			-- Make object desensitive to user input.
		do
			Precursor {EV_PRIMITIVE_IMP}
			invalidate
			update
		end

	show_title_row
			-- Show row displaying column titles.
		do
			if not has_headers then
				if multiple_selection_enabled then
					set_style (default_style - Lvs_singlesel)
				else
					set_style (default_style)
				end
			end
		end

	hide_title_row
			-- Hide row displaying column titles.
		do
			if has_headers then
				if multiple_selection_enabled then
					set_style (default_style + Lvs_nocolumnheader - Lvs_singlesel)
				else
					set_style (default_style +
						Lvs_nocolumnheader)
				end
			end
		end

	column_alignment_changed (an_alignment: EV_TEXT_ALIGNMENT;
		a_column: INTEGER)
			-- Set alignment of `a_column' to corresponding `alignment_code'.
		do
			if an_alignment.is_left_aligned then
				set_column_format (a_column - 1, Lvcfmt_left)
			elseif an_alignment.is_center_aligned then
				set_column_format (a_column - 1, Lvcfmt_center)
			else
				set_column_format (a_column - 1, Lvcfmt_right)
			end
			invalidate
		end

	set_background_color (color: EV_COLOR)
			-- Make `color' the new `background_color'
		local
			l_background_color_imp: like background_color_imp
		do
			l_background_color_imp ?= color.implementation
			check l_background_color_imp /= Void then end
			background_color_imp := l_background_color_imp
			set_text_background_color (l_background_color_imp)
			wel_set_background_color (l_background_color_imp)
			if is_displayed then
				-- If the widget is not hidden then invalidate.
				invalidate
			end
		end

	set_foreground_color (color: EV_COLOR)
			-- Make `color' the new `foreground_color'
		local
			l_foreground_color_imp: like foreground_color_imp
		do
			l_foreground_color_imp ?= color.implementation
			check l_foreground_color_imp /= Void then end
			foreground_color_imp := l_foreground_color_imp
			set_text_foreground_color (l_foreground_color_imp)
			if is_displayed then
				-- If the widget is not hidden then invalidate.
				invalidate
			end
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	column_count: INTEGER
		do
			Result := wel_column_count
		end

feature {NONE} -- Implementation

	set_text_on_position (a_x, a_y: INTEGER; a_text: READABLE_STRING_GENERAL)
			-- Set the label of the cell with coordinates `a_x', `a_y'
			-- with `txt'.
		do
			set_cell_text (a_x - 1, a_y - 1, a_text)
		end

	expand_column_count_to (a_columns: INTEGER)
			-- Set `columns' to `a_columns'.
		do
			resize_first_column
			from
			until
				wel_column_count = a_columns
			loop
				add_column
			end
		end

	resize_first_column
			-- Resize first column of `Current'.
			--| As the first column is always inserted, we need to resize
			--| the first column when there is a column in `Current'
			--| at the vision level.
		local
			col_width: INTEGER
		do
			if wel_column_count = 1 then
				if column_widths.count >= wel_column_count then
					col_width := column_widths @ (wel_column_count)
				else
					col_width := Default_column_width
				end
				wel_set_column_width (col_width, 0)
			end
		end

	add_column
			-- Append new column to `Current' at end of columns.
		local
			wel_column: WEL_LIST_VIEW_COLUMN
			col_width: INTEGER
			col_text: detachable STRING_32
			col_index: INTEGER
		do
			if column_widths.count >= wel_column_count + 1 then
				col_width := column_widths @ (wel_column_count + 1)
			else
				col_width := Default_column_width
			end

			if column_titles.count >= wel_column_count + 1 then
				col_text := column_titles @ (wel_column_count + 1)
			end

			col_index := wel_column_count

			create wel_column.make
			wel_column.set_width (col_width)
			if col_text /= Void then
				wel_column.set_text (col_text)
			else
				wel_column.set_text ("")
			end
			insert_column (wel_column, col_index)
		end

	column_title_changed (a_title: READABLE_STRING_GENERAL; a_column: INTEGER)
			-- Replace title of `a_column' with `a_title' if column present.
			-- If `a_title' is Void, remove it.
		do
			if a_column <= column_count then
				if a_title = Void then
					wel_set_column_title ("", a_column - 1)
				else
					wel_set_column_title (a_title, a_column - 1)
				end
			end
		end

	column_width_changed (a_width, a_column: INTEGER)
			-- Replace width of `a_column' with `a_width' if column present.
		local
			system_info: WEL_SYSTEM_PARAMETERS_INFO
		do
				-- Do nothing if the new value is equal to the
				-- existing width.
			if wel_get_column_width (a_column - 1) /= a_width then
				if a_column <= column_count then
					wel_set_column_width (a_width, a_column - 1)
				end
				create system_info
					-- We have to handle `show window contents while dragging',
					-- so only fire the resize actions if this is the case.
				if system_info.has_drag_full_windows then
					if column_resized_actions_internal /= Void then--and then initial_width /= a_width then
						column_resized_actions_internal.call ([a_column])
					end
				end
			end
		end

	resize_column_to_content (a_column: INTEGER)
			-- Resize column `a_column' to width of its widest text.
		local
			system_info: WEL_SYSTEM_PARAMETERS_INFO
		do
			wel_set_column_width (lvscw_autosize, a_column - 1)
			update_column_width (wel_get_column_width (a_column - 1), a_column)
			create system_info
				-- Only fire the resized actions when
				-- `show window contents while dragging' is enabled,
				-- because of the different events that are generated by
				-- Windows.
			if system_info.has_drag_full_windows then
				if column_resized_actions_internal /= Void then
					column_resized_actions_internal.call ([a_column])
				end
			end
		end

feature -- Access

	find_item_at_position (x_pos, y_pos: INTEGER): detachable EV_MULTI_COLUMN_LIST_ROW_IMP
			-- Find the item at the given position`x_pos', 1y_pos'
			-- relative to `Current'.
		local
			pt: WEL_POINT
			info: WEL_LV_HITTESTINFO
		do
			create pt.make (x_pos, y_pos)
			create info.make_with_point (pt)
			{WEL_API}.send_message (wel_item, Lvm_hittest, to_wparam (0), info.item)
			if flag_set (info.flags, Lvht_onitemlabel)
			or flag_set (info.flags, Lvht_onitemicon)
			then
				Result := ev_children @ (info.iitem + 1)
			end
		end

feature -- Status report

	has_headers: BOOLEAN
			-- True if there is a header line to give titles
			-- to columns.
		do
			Result := not flag_set (style, Lvs_nocolumnheader)
		end

feature -- Element change

	clear_items
			-- Clear all rows of `Current'.
		local
			c: like ev_children
		do
			c := ev_children
			from
				c.start
			until
				c.after
			loop
				c.item.attached_interface.destroy
				c.forth
			end
			reset_content
			c.wipe_out
		end

feature {EV_MULTI_COLUMN_LIST_ROW_I} -- Implementation

	insert_item (item_imp: EV_MULTI_COLUMN_LIST_ROW_IMP; an_index: INTEGER)
			-- Insert `item_imp' at `an_index' row.
		local
			list: ARRAYED_LIST [STRING_32]
			litem: WEL_LIST_VIEW_ITEM
			first_string: STRING_32
		do
			list := item_imp.attached_interface

				-- Add the new columns if some are needed
			if list.count > wel_column_count then
					--| If `item_imp' as more columns than `Current' then we
					--| resize `Current'.
				expand_column_count_to (list.count)
			elseif wel_column_count = 1 then
					--| If we are the first_column then we resize the first column
					--| as there is always a column in `Current'.
				resize_first_column
			end

				-- Put the items in the listview.
			from
				list.start
				if list.after then
					create first_string.make_empty
				else
					first_string := list.item
					list.forth
				end
				create litem.make_with_attributes (
					Lvif_text, an_index - 1, 0, 0, first_string)
				wel_insert_item (litem)
			until
				list.after
			loop
				create litem.make_with_attributes (
					Lvif_text, an_index - 1, list.index - 1, 0, list.item)
				{WEL_API}.send_message (wel_item, Lvm_setitem, to_wparam (0), litem.item)
				list.forth
			end
				-- Now update image.
			if attached item_imp.pixmap as l_pixmap then
				set_row_pixmap (an_index, l_pixmap)
			end
			invalidate
		end

	move_item (item_imp: EV_MULTI_COLUMN_LIST_ROW_IMP; an_index: INTEGER)
			-- Move `item_imp' to position `an_index'.
		local
			bool: BOOLEAN
		do
			bool := item_imp.is_selected
			remove_item (item_imp)
			insert_item (item_imp, an_index)
			if bool then
				item_imp.enable_select
			end
		end

	remove_item (item_imp: EV_MULTI_COLUMN_LIST_ROW_IMP)
			-- Remove `item_imp' from `Current'.
		local
			an_index: INTEGER
		do
				-- First, we remove the child from the graphical component
			an_index := ev_children.index_of (item_imp, 1) - 1
			delete_item (an_index)
				-- Update the column widths in case this removal caused the
				-- scroll bar to be hidden.
		end

	set_item_text (row: EV_MULTI_COLUMN_LIST_ROW_IMP; an_item: READABLE_STRING_GENERAL; item_index: INTEGER)
			-- Assign `an_item' text to row `row' at position `item_index'.
		require
			row_not_void: row /= Void
		local
			litem: WEL_LIST_VIEW_ITEM
			l_image_list: like image_list
			l_internal_pixmap: detachable EV_PIXMAP
		do
			create litem.make_with_attributes (
				Lvif_text, internal_get_index (row) - 1, item_index - 1, 0, an_item)
					-- Add image to the item if one is set.
				if item_index = 1 and then row.internal_pixmap /= Void then
					l_image_list := image_list
					check l_image_list /= Void then end
					l_internal_pixmap := row.internal_pixmap
					check l_internal_pixmap /= Void then end
					l_image_list.add_pixmap (l_internal_pixmap)
					litem.set_image (l_image_list.last_position)
				end
			{WEL_API}.send_message (wel_item, Lvm_setitem, to_wparam (0), litem.item)
		end

	on_item_added_at (row: EV_MULTI_COLUMN_LIST_ROW_IMP; an_item: READABLE_STRING_GENERAL; item_index: INTEGER)
			-- `an_item' has been added to index `item_index' in row `row.
		local
			current_index: INTEGER
		do
			if item_index > column_count then
				expand_column_count_to (item_index)
			end

			set_item_text (row, an_item, item_index)

			from
				current_index := item_index + 1
			until
				current_index > row.attached_interface.count
			loop
				set_item_text (row, row.attached_interface.i_th (current_index), current_index)
				current_index := current_index + 1
			end
		end

	on_item_removed_at (row: EV_MULTI_COLUMN_LIST_ROW_IMP; an_item: READABLE_STRING_GENERAL; item_index: INTEGER)
			-- `an_item' has been removed from index `item_index' in row `row'.
		local
			current_index: INTEGER
		do
			from
				current_index := item_index
			until
				current_index > row.attached_interface.count
			loop
				set_item_text (row, row.attached_interface.i_th (current_index), current_index)
				current_index := current_index + 1
			end
			set_item_text (row, "", row.attached_interface.count + 1)
		end

	internal_get_index (item_imp: EV_MULTI_COLUMN_LIST_ROW_IMP): INTEGER
			-- Return the index of `item_imp' in `Current'.
		do
			Result := ev_children.index_of (item_imp, 1)
		end

	internal_is_selected (item_imp: EV_MULTI_COLUMN_LIST_ROW_IMP): BOOLEAN
			-- Is `item_imp' selected in `Current'?
		local
			i: INTEGER
		do
			i := ev_children.index_of (item_imp, 1) - 1
			i := get_item_state (i, Lvis_selected)
			Result := flag_set (i, Lvis_selected)
		end

	internal_select (item_imp: EV_MULTI_COLUMN_LIST_ROW_IMP)
			-- Select `item_imp' in `Current'.
		local
			i: INTEGER
			litem: WEL_LIST_VIEW_ITEM
		do
			i := ev_children.index_of (item_imp, 1) - 1
			create litem.make_with_attributes (Lvif_state, i, 0, 0, "")
			litem.set_state (Lvis_selected + Lvis_focused)
			litem.set_statemask (Lvis_selected + Lvis_focused)
			{WEL_API}.send_message (wel_item, Lvm_setitemstate, to_wparam (i), litem.item)
		end

	internal_deselect (item_imp: EV_MULTI_COLUMN_LIST_ROW_IMP)
			-- Deselect `item_imp' in `Current'.
		local
			i: INTEGER
			litem: WEL_LIST_VIEW_ITEM
		do
			i := ev_children.index_of (item_imp, 1) - 1
			create litem.make_with_attributes (Lvif_state, i, 0, 0, "")
			litem.set_state (0)
			litem.set_statemask (Lvis_selected + Lvis_focused)
			{WEL_API}.send_message (wel_item, Lvm_setitemstate, to_wparam (i), litem.item)
		end

	set_default_minimum_size
			-- Called after creation. Set the current size and
			-- notify the parent.
		local
			l_font: WEL_FONT
		do
			l_font := (create {WEL_SHARED_FONTS}).gui_font
			ev_set_minimum_size (
				l_font.width.abs * 20 + 7, -- 20 characters wide
				l_font.height.abs	* 5 + 7	 -- 5 characters tall
				, False)
		end

feature {NONE} -- Implementation, Pixmap handling

	setup_image_list
			-- Create the image list and associate it
			-- to `Current' if not already associated.
		do
				-- Create image list with all images 16 by 16 pixels
			create image_list.make_with_size (pixmaps_width , pixmaps_height)

				-- Assign `pixmaps_height' to `row height' if necessary.
			if default_row_height < pixmaps_height then
				row_height := pixmaps_height
			end

				-- Associate the image list with the multicolumn list.
			set_small_image_list(image_list)
		ensure
			image_list_not_void: image_list /= Void
		end

	remove_image_list
			-- Destroy the image list and remove it
			-- from `Current'.
		require
			image_list_not_void: image_list /= Void
		do
				-- Destroy the image list.
			if attached image_list as l_image_list then
				l_image_list.destroy
			end
			image_list := Void

				-- Remove the image list from the multicolumn list.
			set_small_image_list(Void)
				-- We restore the height of each row to the original setting.
			row_height := default_row_height
		ensure
			image_list_is_void: image_list = Void
		end

	pixmaps_size_changed
			-- The size of the displayed pixmaps has just
			-- changed.
		local
			pixmap: detachable EV_PIXMAP
			cur: CURSOR
		do
				-- We only do the job if there are some images.
			if image_list /= Void then

					-- Rebuild the image list.
				remove_image_list
				setup_image_list

					-- Save cursor position
				cur := ev_children.cursor

					-- ReInsert the image of each
					-- row in the image list.
				from
					ev_children.start
				until
					ev_children.after
				loop
					pixmap := ev_children.item.internal_pixmap
					if pixmap /= Void then
						set_row_pixmap (
							ev_children.index,
							pixmap
							)
					end
					ev_children.forth
				end
					-- Restore saved position
				ev_children.go_to (cur)
			end
		end

feature {EV_MULTI_COLUMN_LIST_ROW_IMP} -- Implementation, Pixmap handling

	set_row_pixmap (a_row: INTEGER; a_pixmap: EV_PIXMAP)
			-- Set row `a_row' pixmap to `a_pixmap'.
		local
			image_index		: INTEGER
			wel_row			: WEL_LIST_VIEW_ITEM
			l_image_list	: like image_list
		do
				-- Create the imagelist and associate it
				-- to the control if it's not already done.
			if image_list = Void then
				setup_image_list
			end
			l_image_list := image_list
			check l_image_list /= Void then end

			l_image_list.add_pixmap (a_pixmap)
			image_index := l_image_list.last_position

				-- Retrieve the first item of the row
			wel_row := wel_get_item (a_row - 1, 0)

				-- Add image to the item
			wel_row.set_image (image_index)

				-- Reflect the change in Windows.
			replace_item (wel_row)

				-- Update the display
			invalidate
		end

	remove_row_pixmap (a_row: INTEGER)
			-- Remove any associated pixmap with row `a_row'.
		local
			wel_row: WEL_LIST_VIEW_ITEM
		do
				-- Create the imagelist and associate it
				-- to the control if it's not already done.
			if image_list /= Void then
					-- Retrieve the first item of the row
				wel_row := wel_get_item (a_row - 1, 0)

					-- Remove image from the cell
				wel_row.set_image (0)

					-- Reflect the change in Windows.
				replace_item (wel_row)

					-- Update the display
				invalidate
			end
		end

	wipe_out
			-- Remove all items.
			-- Redefined for speed optimization.
		local
			child_imp: EV_MULTI_COLUMN_LIST_ROW_IMP
		do
			from
				ev_children.start
			until
				ev_children.is_empty
			loop
				child_imp := ev_children.item
				child_imp.on_orphaned
				if remove_item_actions_internal /= Void and then remove_item_actions_internal.count > 0 then
					remove_item_actions_internal.call ([child_imp.attached_interface])
				end
				child_imp.set_parent_imp (Void)
				if internal_selected_items.has (child_imp.attached_interface) then
					if child_imp.deselect_actions_internal /= Void then
						child_imp.deselect_actions.call (Void)
					end
					if deselect_actions_internal /= Void then
						deselect_actions.call ([child_imp.attached_interface])
					end
					internal_selected_items.prune (child_imp.attached_interface)
				end
				ev_children.remove
			end
			reset_content
			index := 0
		end

feature {NONE} -- Selection implementation

	internal_selected_items_uptodate: BOOLEAN
			-- Is `internal_selected_items' sorted?

	internal_selected_items: ARRAYED_LIST [EV_MULTI_COLUMN_LIST_ROW]
			-- Cached version of all selected items.

	retrieve_selected_items: ARRAYED_LIST [EV_MULTI_COLUMN_LIST_ROW]
			-- Current selected items (non cached version)
		local
			i: INTEGER
			imp: EV_MULTI_COLUMN_LIST_ROW_IMP
			c: like ev_children
			wel_sel_items: like wel_selected_items
		do
			create Result.make (selected_count)
			c := ev_children
			wel_sel_items := wel_selected_items
			from
				i := 0
			until
				i = selected_count
			loop
				imp := (c @ (wel_sel_items @ i + 1))
				Result.extend (imp.attached_interface)
				i := i + 1
			end
		ensure
			Result_not_void: Result /= Void
		end

feature {NONE} -- WEL Implementation

	internal_propagate_pointer_press
		(event_id, x_pos, y_pos, button: INTEGER)
			-- Propagate `event_id' and `button' to item at position
			-- `x_pos', `y_pos'. Called on pointer press.
		local
			pre_drop_mcl_row, post_drop_mcl_row: detachable EV_MULTI_COLUMN_LIST_ROW_IMP
			item_press_actions_called: BOOLEAN
			pt: WEL_POINT
		do
			--| If a pick and drop is being executed, the drop actions
			--| are called before the pointer_button_press_actions are
			--| called on an item. It is possible to remove this item, and
			--| also possible to replace this item, so we must only call these
			--| actions if there is still an item where we clicked, and it is
			--| the same item that was clicked on before we called the drop
			--| actions.

				-- Retrieve the item that has been clicked on.
			pre_drop_mcl_row := find_item_at_position (x_pos, y_pos)
			pt := client_to_screen (x_pos, y_pos)

			if pre_drop_mcl_row /= Void and not is_dnd_in_transport and not
				is_pnd_in_transport and not item_is_in_pnd then
				if pre_drop_mcl_row.pointer_button_press_actions_internal
					/= Void then
					pre_drop_mcl_row.attached_interface.pointer_button_press_actions.call
					([x_pos, y_pos - relative_y (pre_drop_mcl_row), button,
					0.0, 0.0, 0.0, pt.x, pt.y])
				end
					-- We record that the press actions have been called.
				item_press_actions_called := True
			end
				--| The pre_drop_it.parent /= Void is to check that the item that
				--| was originally clicked on, has not been removed during the press actions.
				--| If the parent is now void then it has, and there is no need to continue
				--| with `pnd_press'.
			if pre_drop_mcl_row /= Void and then
				pre_drop_mcl_row.is_transport_enabled and then not
				parent_is_pnd_source and then pre_drop_mcl_row.parent /= Void
			then
				pre_drop_mcl_row.pnd_press (x_pos, y_pos, button, pt.x, pt.y)
				if pre_drop_mcl_row.motion_action = ev_pnd_execute then
					disable_default_processing
				end
			elseif attached pnd_item_source as l_pnd_item_source then
				l_pnd_item_source.pnd_press (x_pos, y_pos, button, pt.x, pt.y)
			end

			if item_is_pnd_source_at_entry = item_is_pnd_source then
				pnd_press (x_pos, y_pos, button, pt.x, pt.y)
				if motion_action = ev_pnd_execute then
					disable_default_processing
				end
			end

			if not press_actions_called and call_press_event then
				attached_interface.pointer_button_press_actions.call
					([x_pos, y_pos, button, 0.0, 0.0, 0.0, pt.x, pt.y])
			end

				-- Retrieve the current item where the button press
				-- was received.
			post_drop_mcl_row := find_item_at_position (x_pos, y_pos)

			if not item_press_actions_called then
				-- If there is an item where the button press was received,
				-- and it has not changed from the start of this procedure
				-- then call `pointer_button_press_actions'.
				if post_drop_mcl_row /= Void and
					pre_drop_mcl_row = post_drop_mcl_row and call_press_event then
					post_drop_mcl_row.attached_interface.pointer_button_press_actions.
						call ([x_pos, y_pos - relative_y (post_drop_mcl_row),
						button, 0.0, 0.0, 0.0, pt.x, pt.y])
				end
			end
				-- Reset `call_press_event'.
			keep_press_event
		end

	internal_propagate_pointer_double_press
		(event_id, x_pos, y_pos, button: INTEGER)
			-- Propagate `event_id' and `button' to item at position
			-- `x_pos', `y_pos'. Called on pointer press.
		local
			mcl_row: detachable EV_MULTI_COLUMN_LIST_ROW_IMP
			pt: WEL_POINT
		do
			mcl_row := find_item_at_position (x_pos, y_pos)
			pt := client_to_screen (x_pos, y_pos)
			if mcl_row /= Void then
				mcl_row.attached_interface.pointer_double_press_actions.call ([x_pos,
					y_pos - relative_y (mcl_row), button, 0.0, 0.0, 0.0,
					pt.x, pt.y])
			end
		end

	relative_y (a_row: EV_MULTI_COLUMN_LIST_ROW_IMP): INTEGER
			-- `Result' is relative y_position of `a_row' to `Current'.
		local
			point: WEL_POINT
		do
			point := get_item_position (a_row.index - 1)
			Result := point.y
		end

	process_message (hwnd: POINTER; msg: INTEGER; wparam, lparam: POINTER): POINTER
			-- Call the routine `on_*' corresponding to the
			-- message `msg'.
		do
			inspect msg
			when Wm_vscroll then
				on_wm_vscroll
			else
				Result := Precursor {WEL_LIST_VIEW} (hwnd, msg, wparam, lparam)
			end
		end

	on_notify (a_control_id: INTEGER; info: WEL_NMHDR)
		local
			system_info: WEL_SYSTEM_PARAMETERS_INFO
		do
			Precursor {WEL_LIST_VIEW} (a_control_id, info)
			create system_info
				-- Because of a difference in behviour when
				-- `show window contents when dragging' is turned
				-- on, we need to connect the `resize_actions'
				-- to a different windows message. This will ensure that
				-- the message is only fired when the resize completes and
				-- not during the resize
			if system_info.has_drag_full_windows then
				if info.code = Hdn_endtrackw then
					column_width_update_and_fire_actions (info)
				end
			else
				if info.code = Hdn_itemchangedw then
					column_width_update_and_fire_actions (info)
				end
			end
		end

	column_width_update_and_fire_actions (info: WEL_NMHDR)
			-- Call `update_column_width' and fire
			-- `column_resized_actions_internal', based on information
			-- in `info'.
		local
			header: WEL_NM_HEADER
		do
				--Retrieve the header that has changed.
			create header.make_by_nmhdr (info)
				--Update the column widths accordingly.
			update_column_width (wel_get_column_width (header.iitem),header.iitem + 1)
				-- Call resize actions.
			if column_resized_actions_internal /= Void then
				column_resized_actions_internal.call ([header.iitem + 1])
			end
		end


	on_wm_vscroll
		do
			smart_resize := False
		end

	smart_resize: BOOLEAN
		-- Can we re-draw the background ourselves?
		--| If `True' the background is re-drawn manually during
		--| on_erase_background.
		--| If `False' windows re-draws the background for us.

	on_erase_background (paint_dc: WEL_PAINT_DC; invalid_rect: WEL_RECT)
			-- Wm_erasebkgnd message.
			--| If `smart_resize' then disable the default windows processing
			--| as this causes flickering when showing `Current' while
			--| re-sizing. We then draw all areas of `Current' that are not
			--| automatically re-drawn, to avoid the flickering.
		local
			counter: INTEGER
			rect1, rect2: WEL_RECT
			brush: WEL_BRUSH
			pixmap_line_length: INTEGER
			bkg_color: WEL_COLOR_REF
		do
			if smart_resize then
				if is_sensitive then
					bkg_color := get_background_color
				else
					create bkg_color.make_system (Color_btnface)
				end
				create brush.make_solid (bkg_color)

					-- Fill in bottom of `paint_dc' if not filled by children.
				if top_index + visible_count + 1 > ev_children.count then
					if ev_children.is_empty then
						create rect2.make (0, 0, client_rect.right,
						client_rect.bottom)
					else
						rect1 := get_item_rect (ev_children.count - 1)
						create rect2.make (0, rect1.bottom, client_rect.right,
							client_rect.bottom)
					end
					paint_dc.fill_rect (rect2, brush)
				end


					-- Fill in left side of `paint_dc'.
				create rect2.make (client_rect.left, client_rect.top,
					client_rect.left + 2, client_rect.bottom)
				paint_dc.fill_rect (rect2, brush)

					-- Fill area of `paint_dc' just above `top_index' item.
				rect1 := get_item_rect (top_index)
				create rect2.make (client_rect.left, rect1.top,
					client_rect.right, rect1.top - 2)
				paint_dc.fill_rect (rect2, brush)

					-- Fill in right side of `paint_dc'
				create rect2.make (rect1.right, client_rect.top,
					client_rect.right, client_rect.bottom)
				paint_dc.fill_rect (rect2, brush)


					-- Fill in areas of `paint_dc' around images contained.
				if image_list /= Void then
					from
						counter:= top_index
					until
						counter = top_index + visible_count or
						counter > top_index + ev_children.count - 1
					loop
						rect1 := get_item_rect (counter)
						if pixmaps_width < column_width (1) then
							pixmap_line_length := pixmaps_width + 2
						else
							pixmap_line_length := column_width (1)
						end
						create rect2.make (rect1.left, rect1.top +
							pixmaps_height, pixmap_line_length, rect1.bottom)
						paint_dc.fill_rect (rect2, brush)
						counter := counter + 1
					end
				end

					-- Clean GDI objects
				brush.delete

				disable_default_processing
				set_message_return_value (to_lresult (1))
			end
		end

	background_color_internal: EV_COLOR
			-- Color used for the background of `Current'.
			-- This has been redefined as the background color of
			-- text components is white, or `Color_read_write' by default.
		do
			if attached background_color_imp as l_background_color_imp then
				Result := l_background_color_imp.attached_interface
			else
				Result := (create {EV_STOCK_COLORS}).Color_read_write
			end
		end

	default_style: INTEGER
			-- Style of `Current'.
		do
			Result := Ws_child + Ws_visible + Ws_group
				+ Ws_tabstop + Ws_border + Ws_clipchildren
				+ Lvs_report + Lvs_showselalways + Lvs_singlesel
				+ Ws_clipsiblings + Lvs_shareimagelists
		end

	default_ex_style: INTEGER
		do
			Result := Lvs_ex_infotip
		end

	on_lvn_columnclick (info: WEL_NM_LIST_VIEW)
			-- A column was tapped.
		do
			attached_interface.column_title_click_actions.call ([info.isubitem + 1])
			disable_default_processing
		end

	on_lvn_itemchanged (info: WEL_NM_LIST_VIEW)
			-- An item has changed.
			--| For example, one of the items has been selected or deselected.
		local
			item_imp: detachable EV_MULTI_COLUMN_LIST_ROW_IMP
		do
			if info.uchanged = Lvif_state and info.isubitem = 0 then
				if flag_set(info.unewstate, Lvis_selected) and
						not flag_set(info.uoldstate, Lvis_selected)
				then
						-- Item is being selected
					internal_selected_items_uptodate := False
					item_imp := ev_children @ (info.iitem + 1)
					check item_imp /= Void end
					if item_imp.select_actions_internal /= Void then
						item_imp.select_actions.call (Void)
					end
					if select_actions_internal /= Void then
						select_actions.call ([item_imp.attached_interface])
					end

				elseif flag_set(info.uoldstate, Lvis_selected) and
					not flag_set(info.unewstate, Lvis_selected)
				then
						-- Item is being deselected
					internal_selected_items_uptodate := False
					item_imp := ev_children @ (info.iitem + 1)
					check item_imp /= Void end
					if item_imp.deselect_actions_internal /= Void then
						item_imp.deselect_actions.call (Void)
					end
					if deselect_actions_internal /= Void then
						deselect_actions.call ([item_imp.attached_interface])
					end
				end
			end
		end

	on_key_down (virtual_key, key_data: INTEGER)
			-- A key has been pressed.
		do
			process_navigation_key (virtual_key)
			Precursor {EV_PRIMITIVE_IMP} (virtual_key, key_data)
		end

	on_size (size_type, a_width, a_height: INTEGER)
			-- `Current' is being resized.
		do
			smart_resize:= True
			Precursor {WEL_LIST_VIEW} (size_type, a_width, a_height)
			Precursor {EV_PRIMITIVE_IMP} (size_type, a_width, a_height)
		end

	on_mouse_move (keys, x_pos, y_pos: INTEGER)
			-- Mouse moved on `Current'.
		local
			mcl_row: detachable EV_MULTI_COLUMN_LIST_ROW_IMP
			pt: WEL_POINT
		do
			mcl_row := find_item_at_position (x_pos, y_pos)
			pt := client_to_screen (x_pos, y_pos)
			if mcl_row /= Void then
				mcl_row.attached_interface.pointer_motion_actions.call ([x_pos,
					y_pos - relative_y (mcl_row), 0.0, 0.0, 0.0, pt.x, pt.y])
			end
			if attached pnd_item_source as l_pnd_item_source then
				l_pnd_item_source.pnd_motion (x_pos, y_pos, pt.x, pt.y)
			end
			Precursor {EV_PRIMITIVE_IMP} (keys, x_pos, y_pos)
		end

	default_row_height: INTEGER
			-- Default height of each row

	destroy
			-- Destroy `Current'.
		do
			wipe_out
			Precursor {EV_PRIMITIVE_IMP}
		end

feature {EV_MULTI_COLUMN_LIST_ROW_IMP}

	image_list: detachable EV_IMAGE_LIST_IMP
			-- Image list to store all images required by items.

feature {EV_ANY, EV_ANY_I} -- Interface

	interface: detachable EV_MULTI_COLUMN_LIST note option: stable attribute end;

note
	copyright:	"Copyright (c) 1984-2017, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class EV_MULTI_COLUMN_LIST_IMP











