note
	description: "Objects that store config data about inner container which is SD_MULTI_DOCK_AREA."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2011-01-13 23:53:42 +0000 (Thu, 13 Jan 2011) $"
	revision: "$Revision: 85350 $"

class
	SD_INNER_CONTAINER_DATA


feature -- Tab and Docking data.

	titles: detachable ARRAYED_LIST [READABLE_STRING_GENERAL]
			-- All titles. If it's a docking zone, there is only one title.

	add_title (a_title: READABLE_STRING_GENERAL)
			-- Add `a_title'.
		require
			a_title_not_void: a_title /= Void
		local
			l_titles: like titles
		do
			l_titles := titles
			if l_titles = Void then
				create l_titles.make (1)
				titles := l_titles
			end
			l_titles.extend (a_title)
		ensure
			added: attached titles as le_titles implies le_titles.has (a_title)
		end

	set_titles (a_titles: like titles)
			-- Set `titles' with `a_titles'
		do
			titles := a_titles
		ensure
			set: titles = a_titles
		end

	selected_tab_index: INTEGER
			-- If have multi contents (tab zone), remember the one is seleted.

	set_selected_tab_index (a_int: INTEGER)
			-- Set `selected_tab_index'
		do
			selected_tab_index := a_int
		ensure
			set: selected_tab_index = a_int
		end

	split_proportion: REAL
			-- If current is a split area, this is spliter position's proportion. -1 if current spliter not full.

	set_split_proportion (a_value: like split_proportion)
			-- Set `split_position'.
		do
			split_proportion := a_value
		ensure
			set: split_proportion = a_value
		end

	children_left: detachable SD_INNER_CONTAINER_DATA
			-- `Current' data's left children.

	set_children_left (a_data: like children_left)
			-- Set `children_left'.
		require
			a_data_not_void: a_data /= Void
		do
			children_left := a_data
		ensure
			set: children_left = a_data
		end

	children_right: detachable SD_INNER_CONTAINER_DATA
			-- `Current' data's right children.

	set_children_right (a_data: like children_right)
			-- Set `children_right'.
		require
			a_data_not_void: a_data /= Void
		do
			children_right := a_data
		ensure
			set: children_right = a_data
		end

	parent: detachable like Current
			-- `Current' parent data.

	set_parent (a_parent: like Current)
			-- Set `parent'.
		require
			a_parent_not_void: a_parent /= Void
		do
			parent := a_parent
		ensure
			set: parent = a_parent
		end

	is_split_area: BOOLEAN
			-- If it is a EV_SPLIT_AREA? Otherwise it's a SD_ZONE or SD_FLOATING_ZONE.

	set_is_split_area (a_value: BOOLEAN)
			-- Set `is_split_area'.
		do
			is_split_area := a_value
		ensure
			set: is_split_area = a_value
		end

	is_horizontal_split_area: BOOLEAN
			---If Current is a spliter, if Current is SD_HORIZONTAL_SPLIT_AREA?

	set_is_horizontal_split_area (a_value: BOOLEAN)
			-- Set `is_horizontal_split_area'.
		do
			is_horizontal_split_area := a_value
		ensure
			set: is_horizontal_split_area = a_value
		end

feature -- Minimized data

	is_minimized: BOOLEAN
			-- If is SD_UPPER_ZONE, if it is minized?
			-- This value maybe used by SD_MIDDLE_CONTAINER or SD_UPPER_ZONE.	

	set_is_minimized (a_bool: BOOLEAN)
			-- Set `is_minimized'
		do
			is_minimized := a_bool
		ensure
			set: is_minimized = a_bool
		end

feature -- Floating data.

	set_screen_x (a_screen_x: INTEGER)
			-- Set `screen_x'.
		do
			screen_x := a_screen_x
		ensure
			set: screen_x = a_screen_x
		end

	set_screen_y (a_screen_y: INTEGER)
			-- Set `screen_y'.
		do
			screen_y := a_screen_y
		ensure
			set: screen_y = a_screen_y
		end

	screen_x, screen_y: INTEGER
			-- When Current is SD_FLOATING_ZONE data, screen x y position of SD_FLOATING_ZONE.

	set_width (a_width: INTEGER)
			-- Set `width'.
		do
			width := a_width
		ensure
			set: width = a_width
		end

	set_height (a_height: INTEGER)
			-- Set `height'.
		do
			height := a_height
		ensure
			set: height = a_height
		end

	width, height: INTEGER
			-- When Current is SD_FLOATING_ZONE data, width height of SD_FLOATING_ZONE.	

feature -- Common properties

	state: detachable STRING_32
			-- One generator type name of SD_STATE and it's descendents.

	set_state (a_class_name: READABLE_STRING_GENERAL)
			-- Set `state'.
		do
			state := a_class_name.as_string_32
		ensure
			set: (a_class_name /= Void and attached state as l_state) implies l_state.same_string_general (a_class_name)
		end

	direction: INTEGER
			-- Direction of state. One enumeration from SD_DOCKING_MANAGER.

	set_direction (a_direction: INTEGER)
			-- Set `direction'.
		require
			vaild: (create {SD_ENUMERATION}).is_direction_valid (a_direction)
		do
			direction := a_direction
		ensure
			set: direction = a_direction
		end

	is_visible: BOOLEAN
			-- If it's widget is visible?

	set_visible (a_visible: like is_visible)
			-- Set `a_visible'
		do
			is_visible := a_visible
		ensure
			set: is_visible = a_visible
		end

note
	library:	"SmartDocking: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2010, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"






end
