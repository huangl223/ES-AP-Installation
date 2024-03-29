note
	description:
		"[
			Multiple widget container. Each widget is displayed on an individual
			page. A tab is displayed for each page allow its selection. Only the
			selected page is visible.
		]"
	legal: "See notice at end of class."
	appearance:
		"[
			  _______  _______  _______
			_/ tab_1 \/_tab_2_\/_tab_3_\______
			|                                |
			|         selected_item          |
			|                                |
			----------------------------------
		]"
	status: "See notice at end of class."
	keywords: "notebook, tab, page"
	date: "$Date: 2016-09-27 15:50:48 +0000 (Tue, 27 Sep 2016) $"
	revision: "$Revision: 99192 $"

class
	EV_NOTEBOOK

inherit

	EV_WIDGET_LIST
		redefine
			implementation,
			is_in_default_state
		end

	EV_NOTEBOOK_ACTION_SEQUENCES

	EV_FONTABLE
		undefine
			is_equal
		redefine
			implementation,
			is_in_default_state
		end

	EV_ITEM_PIXMAP_SCALER
		undefine
			is_equal
		redefine
			implementation,
			is_in_default_state
		end

create
	default_create

feature -- Access

	item_text (an_item: EV_WIDGET): STRING_32
			-- Label of `an_item'.
		require
			not_destroyed: not is_destroyed
			has_an_item: has (an_item)
		do
			Result := implementation.item_text (an_item)
		ensure
			bridge_ok: Result.is_equal (implementation.item_text (an_item))
			not_void: Result /= Void
			cloned: Result /= implementation.item_text (an_item)
		end

	item_tab (an_item: EV_WIDGET): EV_NOTEBOOK_TAB
			-- Tab associated with `an_item'.
		require
			not_destroyed: not is_destroyed
			has_an_item: has (an_item)
		do
			Result := implementation.item_tab (an_item)
		ensure
			result_not_void: Result /= Void
		end

feature {EV_BUILDER} -- Access

	pixmap_paths: HASH_TABLE [PATH, INTEGER]
			-- All pixmap paths for pixmaps of tabs.
		once
			create Result.make (4)
		end

feature -- Status report

	selected_item: detachable EV_WIDGET
			-- Page displayed topmost.
		require
			not_destroyed: not is_destroyed
			item_is_selected: not is_empty
		do
			Result := implementation.selected_item
		ensure
			bridge_ok: Result = implementation.selected_item
		end

	selected_item_index: INTEGER
			-- Index of `selected_item'.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.selected_item_index
		ensure
			bridge_ok: Result = implementation.selected_item_index
		end

	tab_position: INTEGER
			-- Position of tabs.
			-- One of `Tab_left', `Tab_right', `Tab_top' or `Tab_bottom'.
			-- Default: `Tab_top'
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.tab_position
		ensure
			bridge_ok: Result = implementation.tab_position
		end

	pointed_tab_index: INTEGER
			-- index of tab currently under mouse pointer, or 0 if none.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.pointed_tab_index
		ensure
			result_valid: Result >= 0 and Result <= count
		end

	tab_index_at_screen_position (a_x, a_y: INTEGER): INTEGER
			-- Index of tab currently at screen position (a_x, a_y), or 0 if none.
		do
			Result := implementation.tab_index_at_screen_position (a_x, a_y)
		ensure
			result_valid: Result >= 0 and Result <= count
		end

feature -- Status setting

	position_tabs_top
			-- Display tabs at top of `Current'.
		require
			not_destroyed: not is_destroyed
		do
			implementation.set_tab_position (Tab_top)
		ensure
			tab_position_set: tab_position = Tab_top
		end

	position_tabs_bottom
			-- Display tabs at bottom of `Current'.
		require
			not_destroyed: not is_destroyed
		do
			implementation.set_tab_position (Tab_bottom)
		ensure
			tab_position_set: tab_position = Tab_bottom
		end

	position_tabs_left
			-- Display tabs at left of `Current'.
		require
			not_destroyed: not is_destroyed
		do
			implementation.set_tab_position (Tab_left)
		ensure
			tab_position_set: tab_position = Tab_left
		end

	position_tabs_right
			-- Display tabs at right of `Current'.
		require
			not_destroyed: not is_destroyed
		do
			implementation.set_tab_position (Tab_right)
		ensure
			tab_position_set: tab_position = Tab_right
		end

	set_tab_position (a_tab_position: INTEGER)
			-- Display tabs at `a_tab_position'.
		require
			not_destroyed: not is_destroyed
			a_position_within_range:
				a_tab_position = Tab_left or a_tab_position = Tab_right or
				a_tab_position = Tab_bottom or a_tab_position = Tab_top
		do
			implementation.set_tab_position (a_tab_position)
		ensure
			tab_position_set: tab_position = a_tab_position
		end

	select_item (an_item: EV_WIDGET)
			-- Display `an_item' above all others.
		require
			not_destroyed: not is_destroyed
			has_an_item: has (an_item)
		do
			implementation.select_item (an_item)
		ensure
			item_selected: selected_item = an_item
		end

feature -- Constants

	Tab_left: INTEGER = 1
			-- Value used to position tab at left.

	Tab_right: INTEGER = 2
			-- Value used to position tab at right.

	Tab_top: INTEGER = 3
			-- Value used to position tab at top.

	Tab_bottom: INTEGER = 4
			-- Value used to position tab at bottom.

feature -- Element change

	set_item_text (an_item: EV_WIDGET; a_text: READABLE_STRING_GENERAL)
			-- Assign `a_text' to label of `an_item'.
		require
			not_destroyed: not is_destroyed
			has_an_item: has (an_item)
			a_text_not_void: a_text /= Void
		do
			implementation.set_item_text (an_item, a_text)
		ensure
			item_text_assigned: item_text (an_item).same_string_general (a_text)
			cloned: item_text (an_item) /= a_text
		end

feature {NONE} -- Contract support

	is_in_default_state: BOOLEAN
			-- Is `Current' in its default state?
		do
			Result := Precursor {EV_WIDGET_LIST} and tab_position = Tab_top
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	implementation: EV_NOTEBOOK_I
			-- Responsible for interaction with native graphics toolkit.

feature {NONE} -- Implementation

	create_implementation
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_NOTEBOOK_IMP} implementation.make
		end

invariant
	tab_position_within_range: is_usable implies
		tab_position = Tab_left or tab_position = Tab_right or
		tab_position = Tab_bottom or tab_position = Tab_top
	selected_item_not_void: is_usable and not is_empty implies selected_item /= Void
	selected_item_index_within_range:
		is_usable and not is_empty implies
		(selected_item_index >= 1 and
		selected_item_index <= count)
	selected_item_index_zero_when_empty:
		is_usable and is_empty implies selected_item_index = 0
	selected_item_is_i_th_of_selected_item_index:
		is_usable and not is_empty implies selected_item = i_th (selected_item_index)
	selected_item_index_is_index_of_selected_item:
		is_usable and not is_empty implies attached selected_item as l_selected_item and then selected_item_index = index_of (l_selected_item, 1)

note
	copyright:	"Copyright (c) 1984-2014, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class EV_NOTEBOOK










