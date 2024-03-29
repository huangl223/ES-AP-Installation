note
	description: "[
			Abstraction of a list in which you can add/modify/remove items.
			+-----------------------------+
			| `first'                     |
			|  .....                      |
			| `last'                      |
			+-----------------------------+
			+-----------------------------+
			|                             |
			+-----------------------------+
			+------+ +---------+ +--------+
			| Add  | |  Apply  | | Remove |
			+------+ +---------+ +--------+
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2015-12-17 13:34:17 +0000 (Thu, 17 Dec 2015) $"
	revision: "$Revision: 98279 $"

class
	EV_ADD_REMOVE_LIST

inherit
	EV_VERTICAL_BOX
		rename
			is_empty as vbox_is_empty,
			count as vbox_count
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Create an Add/Remove list with `list' and `text_field'.
		do

			create add_actions
			create remove_actions
			create modify_actions
			default_create
			build_widget
		end

feature -- Access

	list: detachable EV_LIST note option: stable attribute end
			-- List containing items user want to add/remove.

	text_field: detachable EV_TEXT_FIELD note option: stable attribute end
			-- Text field used to interact with `list'.

	add_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions to be performed when `Add' is pressed then released.

	remove_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions to be performed when `Delete' is pressed then released.

	modify_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions to be performed when `Apply' is pressed then released.

feature -- Status

	is_empty: BOOLEAN
			-- Is `list' empty?
		local
			l_list: like list
		do
			l_list := list
			check l_list /= Void then end
			Result := l_list.is_empty
		end

	count: INTEGER
			-- Number of items in `list'?
		local
			l_list: like list
		do
			l_list := list
			check l_list /= Void then end
			Result := l_list.count
		end

feature -- Setting

	set_is_entry_valid (f: attached like is_entry_valid)
			-- Set `is_entry_valid' with `f'.
		do
			is_entry_valid := f
		ensure
			is_entry_valid_set: is_entry_valid = f
		end

	set_display_error_message (p: attached like display_error_message)
			-- Set `display_error_message' with `p'.
		do
			display_error_message := p
		ensure
			display_error_message_set: display_error_message = p
		end

feature {NONE} -- Implementation: access

	is_entry_valid: detachable FUNCTION [STRING_32, BOOLEAN] note option: stable attribute end
			-- Check if new entry is valid before adding it.

	display_error_message: detachable PROCEDURE [STRING_32] note option: stable attribute end
			-- Display error message when entry is not valid.

	add_button, apply_button, remove_button: detachable EV_BUTTON note option: stable attribute end
			-- Add, Apply and Remove button

feature -- Cleaning

	reset
			-- Reset content of Current
		do
			if list /= Void then
				list.wipe_out
			end
			if text_field /= Void then
				text_field.remove_text
			end
			if apply_button /= Void then
				apply_button.disable_sensitive
			end
		end

feature {NONE} -- GUI building

	build_widget
			-- Build current widget.
		local
			hbox: EV_HORIZONTAL_BOX
		do
			create list

			set_border_width (5)
			set_padding (5)

			extend (list)

			build_text_field ("Entry: ")
			check text_field /= Void then end

			text_field.change_actions.extend (agent update_button_status)
			text_field.return_actions.extend (agent add_item_in)

			create hbox
			hbox.set_border_width (5)
			hbox.extend (create {EV_CELL})
			create add_button.make_with_text ("Add")
			add_button.select_actions.extend (agent add_item_in)
			add_button.set_minimum_width (80)
			hbox.extend (add_button)
			hbox.disable_item_expand (add_button)
			add_button.disable_sensitive

			hbox.extend (create {EV_CELL})
			create apply_button.make_with_text ("Apply")
			apply_button.select_actions.extend (agent modify_item_in)
			apply_button.set_minimum_width (80)
			hbox.extend (apply_button)
			hbox.disable_item_expand (apply_button)
			apply_button.disable_sensitive

			hbox.extend (create {EV_CELL})
			create remove_button.make_with_text ("Remove")
			remove_button.select_actions.extend (agent remove_item_in)
			remove_button.set_minimum_width (80)
			hbox.extend (remove_button)
			hbox.disable_item_expand (remove_button)
			remove_button.disable_sensitive
			hbox.extend (create {EV_CELL})

			extend (hbox)
			disable_item_expand (hbox)
		end

	build_text_field (t: READABLE_STRING_GENERAL)
			-- Create text field part.
		local
			hbox: EV_HORIZONTAL_BOX
			label: EV_LABEL
		do
			create text_field
			create hbox
			create label.make_with_text (t)
			hbox.extend (label)
			hbox.disable_item_expand (label)
			hbox.extend (text_field)
			extend (hbox)
			disable_item_expand (hbox)
		end

feature {NONE} -- Action

	add_item_in
			-- When user press `add' buttin, we insert content
			-- of `text_field' in `list'.
		require
			list_not_void: list /= Void
			text_not_void: text_field /= Void
		local
			list_item: EV_LIST_ITEM
			txt: STRING_32
		do
			check list /= Void then end
			check text_field /= Void then end
			txt := text_field.text
			if not txt.is_empty and (is_entry_valid = Void or else is_entry_valid.item ([txt])) then
				create list_item.make_with_text (txt)
				list_item.select_actions.extend (agent text_field.set_text (txt))
				list.extend (list_item)
				text_field.remove_text
				list.remove_selection
				text_field.set_focus
				add_actions.call (Void)
			else
				if display_error_message /= Void then
					display_error_message.call ([txt])
				end
			end
		end

	remove_item_in
			-- Remove current selected item of `list' and clean
			-- `text_field'.
		require
			list_not_void: list /= Void
			text_not_void: text_field /= Void
		local
			list_item: detachable EV_LIST_ITEM
		do
			check list /= Void then end
			check text_field /= Void then end
			list_item := list.selected_item
			if list_item /= Void  then
				list.prune (list_item)
			end
			text_field.remove_text
			text_field.set_focus
			remove_actions.call (Void)
		end

	modify_item_in
			-- Modify current selected item of `list' and clean
			-- `text_field'.
		require
			list_not_void: list /= Void
			text_not_void: text_field /= Void
		local
			list_item: detachable EV_LIST_ITEM
			txt: STRING_32
		do
			check text_field /= Void then end
			check apply_button /= Void then end
			check list /= Void then end
			txt := text_field.text
			list_item := list.selected_item
			if not txt.is_empty and then list_item /= Void then
				list_item.set_text (txt)
				list_item.select_actions.wipe_out
				list_item.select_actions.extend (agent text_field.set_text (txt))
			end
			apply_button.disable_sensitive
			text_field.set_focus
			modify_actions.call (Void)
		end

	update_button_status
			-- Enable or disable sensitivity of `Apply', `Add'
			-- and `Remove' buttons.
		require
			list_not_void: list /= Void
			text_not_void: text_field /= Void
		local
			l_text: STRING_32
			l_item: detachable EV_LIST_ITEM
		do
			check text_field /= Void then end
			check list /= Void then end
			check add_button /= Void then end
			check apply_button /= Void then end
			check remove_button /= Void then end
			l_text := text_field.text
			l_item := list.selected_item

				-- Update `Add'
			if not l_text.is_empty then
				add_button.enable_sensitive
			else
				add_button.disable_sensitive
			end

				-- Update `Apply'
			if l_item /= Void and not l_text.is_empty then
				if not l_text.is_equal (l_item.text) then
					apply_button.enable_sensitive
				else
					apply_button.disable_sensitive
				end
			else
				apply_button.disable_sensitive
			end

				-- Update `Remove'
			if not l_text.is_empty then
				remove_button.enable_sensitive
			else
				remove_button.disable_sensitive
			end
		end

invariant
	list_not_void: list /= Void
	text_field_not_void: text_field /= Void
	add_actions_not_void: add_actions /= Void
	remove_actions_not_void: remove_actions /= Void
	modify_actions_not_void: modify_actions /= Void
	add_button_not_void: add_button /= Void
	apply_button_not_void: apply_button /= Void
	remove_button_not_void: remove_button /= Void

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




end -- class EV_ADD_REMOVE_LIST




