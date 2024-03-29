﻿note
	description: "A dialog box that allows the user to customize a toolbar%
				  %Call `customize' each time a toolbar must be edited"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Xavier Rousselot"
	date: "$Date: 2017-04-14 18:05:46 +0000 (Fri, 14 Apr 2017) $"
	revision: "$Revision: 100203 $"

class
	SD_TOOL_BAR_CUSTOMIZE_DIALOG

inherit
	EV_DIALOG

create
	make

feature {NONE} -- Creation

	make
			-- Creation method
		do
			create internal_shared
			create final_toolbar.make (20)

							-- Create the containers
			create pool_list.make (True)

			create current_list.make (False)
			create add_button.make_with_text (internal_shared.interface_names.add_button)
			create remove_button.make_with_text (internal_shared.interface_names.remove_button)
			create up_button.make_with_text (internal_shared.interface_names.move_button_up)
			create down_button.make_with_text (internal_shared.interface_names.move_button_down)
			create ok_button.make_with_text (internal_shared.interface_names.ok)
			create cancel_button.make_with_text (internal_shared.interface_names.cancel)

			make_with_title (internal_shared.interface_names.tool_bar_customize_title)
			set_icon_pixmap (internal_shared.icons.tool_bar_customize_dialog)

			prepare
		end

	prepare
			-- Initialize world
		local
			list_container1: EV_VERTICAL_BOX
			list_container2: EV_VERTICAL_BOX
			central_button_container: EV_VERTICAL_BOX
			right_button_container: EV_VERTICAL_BOX
			main_container: EV_VERTICAL_BOX
			square_container: EV_HORIZONTAL_BOX
			pool_label: EV_LABEL
			current_label: EV_LABEL
			l_layout_constants: EV_LAYOUT_CONSTANTS
		do
			create l_layout_constants
			create list_container1
			create list_container2
			create main_container
			create square_container
			create right_button_container
			create central_button_container

			pool_list.drop_actions.extend (agent move_to_pool_list)
			pool_list.drop_actions.set_veto_pebble_function (agent veto_pebble_function)
			pool_list.disable_multiple_selection
			pool_list.select_actions.extend (agent on_pool_select)
			pool_list.deselect_actions.extend (agent on_pool_deselect)

			current_list.drop_actions.extend (agent move_to_current_list)
			current_list.drop_actions.set_veto_pebble_function (agent veto_pebble_function)
			current_list.disable_multiple_selection
			current_list.select_actions.extend (agent on_current_select)
			current_list.deselect_actions.extend (agent on_current_deselect)

			create pool_label.make_with_text (internal_shared.interface_names.available_buttons)
			pool_label.align_text_left
			create current_label.make_with_text (internal_shared.interface_names.displayed_buttons)
			current_label.align_text_left

			add_button.select_actions.extend (agent add_to_displayed)
			l_layout_constants.set_default_size_for_button (add_button)

			add_button.disable_sensitive

			l_layout_constants.set_default_size_for_button (remove_button)
			remove_button.select_actions.extend (agent remove_from_displayed)
			remove_button.disable_sensitive

			l_layout_constants.set_default_size_for_button (up_button)
			up_button.select_actions.extend (agent move_up)
			up_button.disable_sensitive

			l_layout_constants.set_default_size_for_button (down_button)
			down_button.select_actions.extend (agent move_down)
			down_button.disable_sensitive

			l_layout_constants.set_default_size_for_button (ok_button)
			ok_button.select_actions.extend (agent generate_toolbar)
			ok_button.select_actions.extend (agent exit)

			cancel_button.select_actions.extend (agent exit)
			l_layout_constants.set_default_size_for_button (cancel_button)

			list_container1.set_padding (l_layout_constants.Small_border_size)
			list_container1.extend (pool_label)
			list_container1.disable_item_expand (pool_label)
			list_container1.extend (pool_list)

			list_container2.set_padding (l_layout_constants.Small_border_size)
			list_container2.extend (current_label)
			list_container2.disable_item_expand (current_label)
			list_container2.extend (current_list)

			central_button_container.set_padding (l_layout_constants.Small_padding_size)
			central_button_container.set_border_width (l_layout_constants.Default_border_size)
			central_button_container.extend (create {EV_CELL})
			central_button_container.extend (add_button)
			central_button_container.disable_item_expand (add_button)
			central_button_container.extend (remove_button)
			central_button_container.disable_item_expand (remove_button)
			central_button_container.extend (create {EV_CELL})

			right_button_container.set_padding (l_layout_constants.Small_padding_size)
			right_button_container.set_border_width (l_layout_constants.Default_border_size)
			right_button_container.extend (ok_button)
			right_button_container.disable_item_expand (ok_button)
			right_button_container.extend (cancel_button)
			right_button_container.disable_item_expand (cancel_button)
			right_button_container.extend (create {EV_CELL})
			right_button_container.extend (up_button)
			right_button_container.disable_item_expand (up_button)
			right_button_container.extend (down_button)
			right_button_container.disable_item_expand (down_button)

			square_container.extend (list_container1)
			square_container.extend (central_button_container)
			square_container.disable_item_expand (central_button_container)
			square_container.extend (list_container2)
			square_container.extend (right_button_container)
			square_container.disable_item_expand (right_button_container)

			main_container.set_padding (l_layout_constants.Default_padding_size)
			main_container.set_border_width (l_layout_constants.Default_border_size)
			main_container.extend (square_container)
				-- Add widgets to our window
			extend (main_container)

			set_default_cancel_button (cancel_button)
			set_default_push_button (ok_button)
		end

feature -- Initialization

	customize_toolbar (a_parent: EV_WINDOW; text_displayed: BOOLEAN; text_important: BOOLEAN; toolbar: ARRAYED_LIST [SD_TOOL_BAR_ITEM])
			-- Reload the dialog box with available buttons found in `toolbar'
			-- and set `is_text_displayed' to `text_displayed'
			-- `toolbar' is a list of separators and commands that represents both
			--  * the current aspect of the toolbar
			-- 	* the pool of controls available
		do
			is_text_displayed := text_displayed
			is_text_important := text_important

			all_items := toolbar
			fill_lists (toolbar)

			valid_data := False

			show_modal_to_window (a_parent)
		end

feature -- Result

	valid_data: BOOLEAN
			-- Is the content of `is_text_displayed' and `final_toolbar' up-to-date?
			-- (which might not be the case if the user clicked Cancel)

	is_text_displayed: BOOLEAN
			-- Should text be printed next to toolbar buttons?

	is_text_important: BOOLEAN
			-- Should only important text be displayed?

	final_toolbar: ARRAYED_LIST [SD_TOOL_BAR_ITEM]
			-- list containing the buttons to be displayed and then the ones in the pool

	veto_pebble_function (a_stone: ANY): BOOLEAN
			-- Veto pebble function
		do
			if attached {SD_CUSTOMIZABLE_LIST_ITEM} a_stone as an_item then
				if attached {SD_TOOL_BAR_SEPARATOR} an_item.data as l_separator then
					Result := True
				elseif attached an_item.data as l_tool_bar_item and attached all_items as l_all_items then
					Result := l_all_items.has (l_tool_bar_item)
				end
			end
		end

	w_height: INTEGER
			-- current height of the window
			--
			-- Useful only because Vision2 currently does not remember the size
			-- of the window after a hide/show

	w_width: INTEGER
			-- current width of the window
			--
			-- Useful only because Vision2 currently does not remember the size
			-- of the window after a hide/show

feature {NONE} -- Graphical interface

	pool_list: SD_CUSTOM_TOOLBAR_LIST -- EV_LIST
			-- list containing the whole pool of buttons (+ a separator at the beginning)

	current_list: SD_CUSTOM_TOOLBAR_LIST -- EV_LIST
			-- list containing the buttons and the separators to be displayed

	add_button: EV_BUTTON
			-- button labeled "Add"

	remove_button: EV_BUTTON
			-- button labeled "Remove"

	up_button: EV_BUTTON
			-- button labeled "Up"

	down_button: EV_BUTTON
			-- button labeled "Down"

	ok_button: EV_BUTTON
			-- button labeled "Ok"

	cancel_button: EV_BUTTON
			-- button labeled "Cancel"

	all_items: detachable ARRAYED_LIST [SD_TOOL_BAR_ITEM]
			-- All tool bar items in one SD_TOOL_BAR_CONTENT

feature {NONE} -- Button actions

	generate_toolbar
			-- Generate a "toolbar" in `final_toolbar' from the user input
			-- and set `is_text_displayed'
		local
			cur: detachable SD_CUSTOMIZABLE_LIST_ITEM
		do
			final_toolbar.wipe_out
			from
				current_list.start
			until
				current_list.after
			loop
					-- Copy the content of current_list to final_toolbar
				cur := current_list.customizable_item
				if cur /= Void then
					if attached cur.data as cmd then
						cmd.enable_displayed
						final_toolbar.extend (cmd)
					else
						final_toolbar.extend (cur.data)
					end
				end
				current_list.forth
			end -- loop

			from
				pool_list.start
				pool_list.forth -- To avoid copying the initial Separator
			until
				pool_list.after
			loop
					-- Copy the content of pool_list to final_toolbar
				cur := pool_list.customizable_item
				if cur /= Void then
					if attached cur.data as cmd then
						cmd.disable_displayed
						final_toolbar.extend (cmd)
					else
						final_toolbar.extend (cur.data)
					end
				end
				pool_list.forth
			end -- loop
			valid_data := True
		end

	exit
			-- Hide the current window
		do
			w_width := width
			w_height := height
			destroy
		end

	add_to_displayed
			-- Move the currently selected button from the pool to the displayed buttons
		local
			sel: detachable SD_CUSTOMIZABLE_LIST_ITEM
			sel2: detachable SD_CUSTOMIZABLE_LIST_ITEM
		do
			sel := pool_list.customizable_selected_item
			if sel /= Void then
				if not sel.is_separator then
					pool_list.start
					pool_list.prune (sel)
				else
					create sel.make (Current, create {SD_TOOL_BAR_SEPARATOR}.make)
					set_up_events (sel)
				end -- if
				sel2 := current_list.customizable_selected_item
				if  sel2 /= Void then
					current_list.start
					current_list.search (sel2)
					current_list.put_right (sel)
				else
					current_list.put_front (sel)
				end -- if
				sel.enable_select
			end -- if
		end

	remove_from_displayed
			-- Move the currently selected button from the pool to the displayed buttons
		local
			sel: detachable SD_CUSTOMIZABLE_LIST_ITEM
			sel2: detachable SD_CUSTOMIZABLE_LIST_ITEM
		do
			sel := current_list.customizable_selected_item
			if sel /= Void then
				current_list.start
				current_list.prune (sel)
				if not sel.is_separator then
					sel2 := pool_list.customizable_selected_item
					if  sel2 /= Void then
						pool_list.start
						pool_list.search (sel2)
						pool_list.put_right (sel)
					else
						pool_list.extend (sel)
					end -- if
					sel.enable_select
				end -- if
			end -- if
		end

	move_up
			-- Move the currently selected button one position up in `current_list'
		local
			sel: detachable SD_CUSTOMIZABLE_LIST_ITEM
		do
			moving := True
			sel := current_list.customizable_selected_item
			if sel /= Void then
				current_list.start
				current_list.search (sel)
				if not current_list.isfirst then
					current_list.remove
					current_list.back
					current_list.put_left (sel)
					sel.enable_select
				end
			end
			moving := False
		end

	move_down
			-- Move the currently selected button one position down in `current_list'
		local
			sel: detachable SD_CUSTOMIZABLE_LIST_ITEM
		do
			moving := True
			sel := current_list.customizable_selected_item
			if sel /= Void then
				current_list.start
				current_list.search (sel)
				if not current_list.islast then
					current_list.remove
					current_list.put_right (sel)
					sel.enable_select
				end
			end
			moving := False
		end

feature {NONE} -- Actions performed by agents like graying buttons

	moving: BOOLEAN
			-- Flag set when moving an item up or down to avoid graying buttons unnecessarily.

	on_pool_select
			-- Called when the user clicks the pool list.
		do
			if not add_button.is_sensitive then
				add_button.enable_sensitive
			end
		end

	on_pool_deselect
			-- Called when the user deselects an item of the pool list.
		do
			if add_button.is_sensitive then
				add_button.disable_sensitive
			end
		end

	on_current_select
			-- Called when the user clicks the current list
		do
			if not remove_button.is_sensitive then
				remove_button.enable_sensitive
				up_button.enable_sensitive
				down_button.enable_sensitive
			end
		end

	on_current_deselect
			-- Called when the user deselects an item of the current list
		do
			if (not moving)
				and then remove_button.is_sensitive
			then
				remove_button.disable_sensitive
				up_button.disable_sensitive
				down_button.disable_sensitive
			end
		end

	move_to_pool_list (an_item: SD_CUSTOMIZABLE_LIST_ITEM)
			-- Move `an_item' to pool list.
		do
			if attached an_item.parent as l_parent then
				if not an_item.is_separator then
					l_parent.start
					l_parent.prune (an_item)
					pool_list.extend (an_item)
				elseif an_item.custom_parent = Void or else attached an_item.custom_parent as l_item_custom_parent and then not l_item_custom_parent.is_a_pool_list then
					l_parent.start
					l_parent.prune (an_item)
				end
			end
		end

	move_to_current_list (an_item: SD_CUSTOMIZABLE_LIST_ITEM)
			-- Move `an_item' to current list.
		do
			if attached an_item.parent as l_parent then
				if an_item.is_separator and attached an_item.custom_parent as l_item_custom_parent and then l_item_custom_parent.is_a_pool_list then
					current_list.extend (create {SD_CUSTOMIZABLE_LIST_ITEM}.make (Current, create {SD_TOOL_BAR_SEPARATOR}.make))
					set_up_events (an_item)
				else
					l_parent.start
					l_parent.prune (an_item)
					current_list.extend (an_item)
				end
			end
		end

	mouse_move (li: SD_CUSTOMIZABLE_LIST_ITEM; xi, yi, b: INTEGER; xf, yf, p: DOUBLE; ax, ay: INTEGER)
			-- Move `li' to the other list.
			--| Assumption: `li' is selected.
		do
			if li.custom_parent = current_list then
				remove_from_displayed
			else
				add_to_displayed
			end
		end

feature {NONE} -- Internal data

	set_up_events (it: SD_CUSTOMIZABLE_LIST_ITEM)
			-- Set up the double_click actions and the drop actions of `it'.
		require
			valid_it: it /= Void
		do
			it.pointer_double_press_actions.extend (agent mouse_move (it, ?, ?, ?, ?, ?, ?, ?, ?))
			it.drop_actions.extend (agent drop2 (?, it))
		end

	drop2 (src, dst: SD_CUSTOMIZABLE_LIST_ITEM)
			-- `src' was dropped onto `dst'.
			-- Set up events for `src' if it is a newly created separator. (Eww how ugly...)
		do
			if
				(src.is_separator and attached src.custom_parent as l_src_custom_parent) and then
				l_src_custom_parent.is_a_pool_list and
				(attached dst.custom_parent as l_dst_custom_parent and then
				not l_dst_custom_parent.is_a_pool_list)
			then
					-- `dst' must have added a new separator after itself
				if attached dst.parent as l_parent then
					l_parent.start
					l_parent.search (dst)
					l_parent.forth
					if attached {SD_CUSTOMIZABLE_LIST_ITEM} l_parent.item as conv_cust then
						set_up_events (conv_cust)
					end
				else
					check False end -- Implied by list iitem displaying in dialog
				end
			end
		end

	fill_lists (a_toolbar: ARRAYED_LIST[SD_TOOL_BAR_ITEM])
			-- Fill in `pool_list' and `current_list' with the pool and the toolbar
		require
			toolbar_non_void: a_toolbar /= Void
		local
			n: SD_CUSTOMIZABLE_LIST_ITEM
		do
			pool_list.wipe_out
			current_list.wipe_out
			create n.make (Current, create {SD_TOOL_BAR_SEPARATOR}.make)
			n.pointer_double_press_actions.extend (agent mouse_move (n, ?, ?, ?, ?, ?, ?, ?, ?))
			pool_list.extend (n)
			from
				a_toolbar.start
			until
				a_toolbar.after
			loop
				create n.make (Current, a_toolbar.item)
				set_up_events (n)
				if n.is_separator then
					current_list.extend (n)
				else
					if a_toolbar.item.is_displayed then
						current_list.extend (n)
					else
						pool_list.extend (n)
					end -- if
				end -- if
				a_toolbar.forth
			end -- loop
		end

	internal_shared: SD_SHARED;
			-- All singletons.

note
	library:	"SmartDocking: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2017, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
