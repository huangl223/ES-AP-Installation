note
	description: "[
					Objects that represent an EV_TITLED_WINDOW.%
					%The original version of this class was generated by EiffelBuild.
																							]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2013-01-29 00:13:15 +0000 (Tue, 29 Jan 2013) $"
	revision: "$Revision: 91051 $"

deferred class
	SD_TOOL_BAR_CONTAINER_IMP

inherit
	EV_VERTICAL_BOX
		redefine
			initialize, is_in_default_state
		end

-- This class is the implementation of an EV_TITLED_WINDOW generated by EiffelBuild.
-- You should not modify this code by hand, as it will be re-generated every time
-- modifications are made to the project.

feature {NONE}-- Initialization

	initialize
			-- Initialize `Current'
		do
			Precursor {EV_VERTICAL_BOX}

				-- Build_widget_structure
			extend (top)
			extend (l_ev_horizontal_box_1)
			l_ev_horizontal_box_1.extend (left)
			l_ev_horizontal_box_1.extend (center)
			l_ev_horizontal_box_1.extend (right)
			extend (bottom)

			l_ev_horizontal_box_1.disable_item_expand (left)
			l_ev_horizontal_box_1.disable_item_expand (right)
			disable_item_expand (top)
			disable_item_expand (bottom)

				--Connect events
				-- Close the application when an interface close
				-- request is received on `Current'. i.e. the cross is clicked.

				-- Call `user_initialization'.
			user_initialization
		end

feature -- Access

	center: EV_CELL
	left, right: EV_HORIZONTAL_BOX
	top, bottom: EV_VERTICAL_BOX

feature {NONE} -- Implementation

	l_ev_horizontal_box_1: EV_HORIZONTAL_BOX

feature {NONE} -- Implementation

	is_in_default_state: BOOLEAN
			-- Is `Current' in its default state?
		do
			-- Re-implement if you wish to enable checking
			-- for `Current'.
			Result := True
		end

	user_initialization
			-- Feature for custom initialization, called at end of `initialize'
		deferred
		end

note
	library:	"SmartDocking: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"






end -- class SD_TOOL_BAR_CONTAINER_IMP
