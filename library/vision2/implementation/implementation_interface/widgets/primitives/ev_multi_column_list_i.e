note
	description:
		"Eiffel Vision multi column list. Implementation interface."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2013-05-30 21:33:11 +0000 (Thu, 30 May 2013) $"
	revision: "$Revision: 92653 $"

deferred class
	EV_MULTI_COLUMN_LIST_I

inherit
	EV_PRIMITIVE_I
		redefine
			interface
		end

	EV_ITEM_LIST_I [EV_MULTI_COLUMN_LIST_ROW]
		redefine
			interface
		end

	EV_ITEM_PIXMAP_SCALER_I
		redefine
			interface
		end

	EV_MULTI_COLUMN_LIST_ACTION_SEQUENCES_I

feature {EV_ANY} -- Initialization

	make
		do
				-- Set default width & height for the pixmaps
			initialize_pixmaps

			create column_titles.make
			create column_widths.make
			create column_alignments.make
		end

feature -- Access

	column_count: INTEGER
			-- Column count.
		deferred
		end

	selected_item: detachable EV_MULTI_COLUMN_LIST_ROW
			-- Currently selected item.
			-- Topmost selected item if multiple items are selected.
			-- (For multiple selections see `selected_items')
		deferred
		end

	selected_items: DYNAMIC_LIST [EV_MULTI_COLUMN_LIST_ROW]
			-- Currently selected items.
		deferred
		end

	row_height: INTEGER
			-- Height in pixels of each row.
		deferred
		end

feature -- Status report

	multiple_selection_enabled: BOOLEAN
			-- Can more that one item be selected?
		deferred
		end

	title_shown: BOOLEAN
			-- Is a row displaying column titles shown?
		deferred
		end

	column_title (a_column: INTEGER): STRING_32
			-- Title of `a_column'.
		require
			a_column_positive: a_column > 0
		local
			l_result: detachable STRING_32
		do
			if a_column <= column_titles.count then
				l_result := column_titles @ a_column
				check l_result /= Void then end
				Result := l_result.twin
			else
				create Result.make_empty
			end
		ensure
			column_title_not_void: Result /= Void
		end

	column_width (a_column: INTEGER): INTEGER
			-- Width of `a_column' in pixels.
		require
			a_column_positive: a_column > 0
		do
			if a_column <= column_widths.count then
				Result := column_widths @ a_column
			else
				Result := Default_column_width
			end
		end

	column_alignment (a_column: INTEGER): EV_TEXT_ALIGNMENT
			-- `Result' is alignment of column `a_column'.
		require
			a_column_positive: a_column > 0
		local
			an_assignment_code: INTEGER
		do
			if a_column <= column_alignments.count then
				create Result
				an_assignment_code := column_alignments.i_th (a_column)
				if an_assignment_code = Result.left_alignment then
					Result.set_left_alignment
				elseif an_assignment_code = Result.center_alignment then
					Result.set_center_alignment
				else
					Result.set_right_alignment
				end
			else
				create Result.make_with_left_alignment
			end
		end

feature {EV_ANY, EV_ANY_I} -- Status setting

	ensure_item_visible (an_item: EV_MULTI_COLUMN_LIST_ROW)
			-- Ensure `an_item' is visible in `Current'.
		deferred
		end

	select_item (an_index: INTEGER)
			-- Select item at `an_index'.
		require
			an_index_within_range: an_index > 0 and an_index <= count
		deferred
		ensure
			item_selected:
				selected_items.has (attached_interface.i_th (an_index))
		end

	deselect_item (an_index: INTEGER)
			-- Deselect item at `an_index'.
		require
			an_index_within_range: an_index > 0 and an_index <= count
		deferred
		ensure
			item_deselected: not selected_items.has (i_th (an_index))
		end

	clear_selection
			-- Make `selected_items' empty.
		deferred
		ensure
			selected_items_empty: selected_items.is_empty
		end

	enable_multiple_selection
			-- Allow more than one item to be selected.
		deferred
		ensure
			multiple_selection_enabled: multiple_selection_enabled
		end

	disable_multiple_selection
			-- Allow only one item to be selected.
		deferred
		ensure
			not_multiple_selection_enabled: not multiple_selection_enabled
		end

	show_title_row
			-- Show row displaying column titles.
		deferred
		ensure
			title_shown: title_shown
		end

	hide_title_row
			-- Hide the row of the titles.
		deferred
		end

	align_text_left (a_column: INTEGER)
			-- Display text of `a_column' left aligned.
			-- First column is always left aligned.
		require
			a_column_within_range: a_column > 1 and a_column <= column_count
		local
			an_alignment: EV_TEXT_ALIGNMENT
		do
			create an_alignment.make_with_left_alignment
			set_column_alignment (an_alignment, a_column)
		end

	align_text_center (a_column: INTEGER)
			-- Display text of `a_column' centered.
			-- First column is always left aligned.
		require
			a_column_within_range: a_column > 1 and a_column <= column_count
		local
			an_alignment: EV_TEXT_ALIGNMENT
		do
			create an_alignment.make_with_center_alignment
			set_column_alignment (an_alignment, a_column)
		end


	align_text_right (a_column: INTEGER)
			-- Display text of `a_column' right aligned.
			-- First column is always left aligned.
		require
			a_column_within_range: a_column > 1 and a_column <= column_count
		local
			an_alignment: EV_TEXT_ALIGNMENT
		do
			create an_alignment.make_with_right_alignment
			set_column_alignment (an_alignment, a_column)
		end

feature {EV_ANY, EV_ANY_I}-- Element change

	set_column_title (a_title: READABLE_STRING_GENERAL; a_column: INTEGER)
			-- Assign `a_title' to the `column_title'(`a_column').
		require
			a_column_positive: a_column > 0
			a_title_not_void: a_title /= Void
		do
			if a_column <= column_titles.count then
				column_titles.go_i_th (a_column)
				column_titles.replace (a_title.as_string_32.twin)
			else
				from
				until
					column_titles.count = a_column - 1
				loop
					column_titles.extend (Void)
				end
				column_titles.extend (a_title.as_string_32.twin)
			end
			column_title_changed (a_title, a_column)
			if column_titles.count > column_count then
				expand_column_count_to (column_titles.count)
			end
		ensure
			a_title_assigned: column_title (a_column).same_string_general (a_title)
		end

	set_column_titles (titles: ARRAY [READABLE_STRING_GENERAL])
			-- Assign `titles' to titles of columns in order.
		require
			titles_not_void: titles /= Void
		local
			i: INTEGER
			old_count: INTEGER
		do
			if titles.count > column_count then
				expand_column_count_to (titles.count)
			end
			from
				i := 1
				old_count := column_titles.count
				column_titles.wipe_out
			until
				i > titles.count
			loop
				column_title_changed (titles @ (i + titles.lower - 1), i)
				column_titles.extend ((titles @ (i + titles.lower - 1)).as_string_32.twin)
				i := i + 1
				old_count := old_count - 1
			end
			from
			until
				old_count <= 0
			loop
				column_title_changed ("", i)
				i := i + 1
				old_count := old_count - 1
			end

		end

	set_column_width (a_width: INTEGER; a_column: INTEGER)
			-- Assign `a_width' `column_width'(`a_column').
		require
			a_column_within_range: a_column > 0 and a_column <= column_count
			a_width_positive: a_width >= 0
		do
			update_column_width (a_width, a_column)
			column_width_changed (a_width, a_column)
		ensure
			a_width_assigned: a_width = column_width (a_column)
		end

	resize_column_to_content (a_column: INTEGER)
			-- Resize column `a_column' to width of its widest text.
		require
			a_column_within_range: a_column > 0 and a_column <= column_count
		deferred
		end

	set_column_widths (widths: ARRAY [INTEGER])
			-- Assign `widths' to column widths in order.
		require
			widths_not_void: widths /= Void
		local
			i: INTEGER
			old_count: INTEGER
		do
			from
				i := 1
				old_count := column_widths.count
				column_widths.wipe_out
			until
				i > widths.count
			loop
				column_widths.extend (widths @ (i + widths.lower - 1))
				column_width_changed (widths @ (i + widths.lower - 1), i)
				i := i + 1
				old_count := old_count - 1
			end
			from
			until
				old_count < 1
			loop
				column_width_changed (Default_column_width, i)
				i := i + 1
				old_count := old_count - 1
			end
		end

	set_column_alignments (alignments: LINKED_LIST [EV_TEXT_ALIGNMENT])
			-- Assign `alignments' to column text alignments in order.
		require
			alignments_not_void: alignments /= Void
		do

				-- Firstly add the first column as left aligned as the first column is
				-- always left aligned in a multi column list.
			if column_alignments.is_empty then
				column_alignments.extend ({EV_TEXT_ALIGNMENT}.left_alignment)
			end

			from
					-- Note that we go to the second position if it exists
					-- as we have already added the first item as left aligned.
					-- We restrict this to `count + 1' if the list is empty which is
					-- the final permissable cursor position, not 2.
				alignments.go_i_th ((2).min (alignments.count + 1))
			until
					-- If `alignments' contains more elements than the
					-- list columns, we ignore those elements.
				alignments.off or alignments.index > column_count
			loop
				column_alignment_changed (alignments.item, alignments.index)
				if alignments.index > column_alignments.count then
					column_alignments.extend (alignments.item.alignment_code)
				else
					column_alignments.go_i_th (alignments.index)
					column_alignments.replace (alignments.item.alignment_code)
				end
				alignments.forth
			end
		end

	set_column_alignment (an_alignment: EV_TEXT_ALIGNMENT; a_column: INTEGER)
			-- Assign text alignment to `an_alignment' for
			-- column `a_column'.
		require
			an_alignment_not_void: an_alignment /= Void
			a_column_within_range: a_column > 1 and a_column <= column_count
		do
			if a_column <= column_alignments.count then
				column_alignments.go_i_th (a_column)
				column_alignments.replace (an_alignment.alignment_code)
			else
				from
				until
					column_alignments.count = a_column - 1
				loop
					column_alignments.extend (an_alignment.left_alignment)
				end
				column_alignments.extend (an_alignment.alignment_code)
			end
			column_alignment_changed (an_alignment, a_column)
		end

feature {EV_ANY_I} -- Implementation

	expand_column_count_to (a_columns: INTEGER)
			-- Expand the number of columns in the list to `a_columns'.
		require
			expandable: a_columns > column_count
		deferred
		end

	update_column_width (a_width: INTEGER; a_column: INTEGER)
			-- Assign `a_width' `column_width'(`a_column').
		require
			a_column_within_range: a_column > 0 and a_column <= column_count
			a_width_positive: a_width >= 0
		do
			if a_column <= column_widths.count then
				column_widths.go_i_th (a_column)
				column_widths.replace (a_width)
			else
				from
				until
					column_widths.count = a_column - 1
				loop
					column_widths.extend (Default_column_width)
				end
				column_widths.extend (a_width)
			end
		ensure
			a_width_assigned: a_width = column_width (a_column)
		end

	set_text_on_position (a_column, a_row: INTEGER; a_text: READABLE_STRING_GENERAL)
			-- Set the label of the cell with coordinates `a_column',
			-- `a_row' with `a_text'.
		require
			a_column_positive: a_column > 0
			a_row_positive: a_row > 0
			a_column_not_greater_than_column_count: a_column <= column_count
			a_row_not_greater_than_count: a_row <= count
			a_text_not_void: a_text /= Void
		deferred
		end

	set_row_pixmap (a_row: INTEGER; a_pixmap: EV_PIXMAP)
			-- Set row `a_row' pixmap to `a_pixmap'.
		require
			a_row_positive: a_row > 0
			a_row_not_greater_than_count: a_row <= count
			a_pixmap_not_void: a_pixmap /= Void
		deferred
		end

	remove_row_pixmap (a_row: INTEGER)
			-- Remove any pixmap associated with row `a_row'.
		require
			a_row_positive: a_row > 0
			a_row_not_greater_than_count: a_row <= count
		do
			-- Do nothing by default
		end

	column_title_changed (a_title: READABLE_STRING_GENERAL; a_column: INTEGER)
			-- Replace title of `a_column' with `a_title' if column present.
			-- If `a_title' is Void, remove it.
			-- Called when a title has been altered.
		require
			a_column_positive: a_column > 0
		deferred
		end

	column_width_changed (a_width, a_column: INTEGER)
			-- Replace width of `a_column' with `a_width' if column present.
			-- Called when a column width has been changed.
		require
			a_column_positive: a_column > 0
			a_width_positive: a_width >= 0
		deferred
		end

	column_alignment_changed (an_alignment: EV_TEXT_ALIGNMENT; a_column: INTEGER)
			-- Set alignment of `a_column' to
			-- corresponding `alignment_code'.
			-- Called when an alignment has been changed.
		require
			a_column_positive: a_column > 0
			an_alignment_not_void: an_alignment /= Void
		deferred
		end

feature {EV_MULTI_COLUMN_LIST_ROW_IMP, EV_ITEM_LIST_IMP} -- Implementation

	ev_children: ARRAYED_LIST [EV_MULTI_COLUMN_LIST_ROW_IMP]
			-- We have to store the children because
			-- neither gtk nor windows does it.


feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_MULTI_COLUMN_LIST note option: stable attribute end

feature {EV_ANY_I} -- Implementation

	column_titles: LINKED_LIST [detachable STRING_32]
			-- All column titles set using `set_column_titles' and
			-- `set_column_title'. We store it to give the user the
			-- option to specify more titles than the current
			-- number of colums.

	column_widths: LINKED_LIST [INTEGER]
			-- All column widths set using `set_column_widths' and
			-- `set_column_width'.

	column_alignments: LINKED_LIST [INTEGER]
			--  All column alignment codes set using
			-- `set_column_alignments'
			--  and `set_column_alignment'.

	Default_column_width: INTEGER = 80

invariant
	ev_children_not_void: ev_children /= Void

note
	copyright:	"Copyright (c) 1984-2013, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class EV_MULTI_COLUMN_LIST_I










