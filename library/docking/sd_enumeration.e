note
	description: "Enumerations used by client programmers and internals."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2013-05-20 23:15:17 +0000 (Mon, 20 May 2013) $"
	revision: "$Revision: 92557 $"

class
	SD_ENUMERATION

feature -- Direction

	top: INTEGER = 1
			-- Top

	bottom: INTEGER = 2
			-- Bottom

	left: INTEGER = 3
			-- Left

	right: INTEGER = 4
			-- Right

feature {SD_SIZABLE_POPUP_WINDOW} -- Extended directions

	top_left: INTEGER = 5
			-- Top left

	top_right: INTEGER = 6
			-- Top right

	bottom_left: INTEGER = 7
			-- Bottom left

	bottom_right: INTEGER = 8
			-- Bottom right

feature -- Content Type

	tool: INTEGER = 1
			-- Tool

	editor: INTEGER = 2
			-- Editor

feature -- {SD_STATE, SD_HOT_ZONE}

	place_holder: INTEGER = 3
			-- Place holder for editor.

feature -- State

	state_void: INTEGER = 1
		-- FIXIT: not a good name?
		-- Initial state.

	docking: INTEGER = 2
		-- Docking state.

	tab: INTEGER = 3
		-- Tab state which content is in notebook container.

	auto_hide: INTEGER = 4
		-- Auto hide state which content will hide at side of main container.

feature -- Contract support

	 is_direction_valid (a_direction: INTEGER): BOOLEAN
	 		-- If `a_direction' valid?
	 	do
			inspect a_direction
			when top, bottom, left, right then
				Result := True
			else
			end
	 	end

	is_type_valid (a_type: INTEGER): BOOLEAN
			-- If `a_type' valid?
		do
			inspect a_type
			when editor, tool, place_holder then
				Result := True
			else
			end
		end

	is_state_valid (a_state: INTEGER): BOOLEAN
			-- If `a_state' valid?
		do
			inspect a_state
			when state_void, docking, tab, auto_hide then
				Result := True
			else
			end
		end

note
	library:	"SmartDocking: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2011, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"


end
