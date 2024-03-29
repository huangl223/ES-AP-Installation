﻿note
	description:
		"[
			Drop down menu containing EV_MENU_ITEMs
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "menu, bar, drop down, popup"
	date: "$Date: 2018-12-18 11:03:05 +0000 (Tue, 18 Dec 2018) $"
	revision: "$Revision: 102624 $"

class
	EV_MENU

inherit
	EV_MENU_ITEM
		undefine
			is_equal
		redefine
			implementation,
			create_implementation,
			is_in_default_state,
			parent
		end

	EV_MENU_ITEM_LIST
		undefine
			initialize,
			default_identifier_name
		redefine
			implementation,
			is_in_default_state
		end

create
	default_create,
	make_with_text,
	make_with_text_and_action

feature -- Status report

	parent: detachable EV_MENU_ITEM_LIST
			-- Menu item list containing `Current'.
		do
			Result := implementation.parent
		end

feature -- Standard operations

	show
			-- Pop up on the current pointer position.
		require
			not_destroyed: not is_destroyed
			not_parented: parent = Void
		do
			implementation.show
		end

	show_at (a_widget: detachable EV_WIDGET; a_x, a_y: INTEGER)
			-- Pop up on `a_x', `a_y' relative to the top-left corner
			-- of `a_widget' or relative to the screen if `a_widget' is Void.
		require
			not_destroyed: not is_destroyed
			not_parented: parent = Void
			widget_not_destroyed: a_widget /= Void implies not a_widget.is_destroyed
			widget_displayed: a_widget /= Void implies a_widget.is_displayed
		do
			implementation.show_at (a_widget, a_x, a_y)
		end

feature {NONE} -- Contract support

	is_in_default_state: BOOLEAN
			-- Is `Current' in its default state?
		do
			Result := Precursor {EV_MENU_ITEM} and Precursor {EV_MENU_ITEM_LIST}
		end

	one_selected_radio_item_per_separator: BOOLEAN
			-- Is there at most one selected radio item between
			-- consecutive separators?
		do
			Result := implementation.one_radio_item_selected_per_separator
		ensure
			index_not_changed: index = old index
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	implementation: EV_MENU_I
			-- Responsible for interaction with native graphics toolkit.

feature {NONE} -- Implementation

	create_implementation
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_MENU_IMP} implementation.make
		end

invariant
	one_selected_radio_item_per_separator: is_usable implies one_selected_radio_item_per_separator

note
	copyright: "Copyright (c) 1984-2018, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
