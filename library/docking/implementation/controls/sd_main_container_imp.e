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
	SD_MAIN_CONTAINER_IMP

inherit
	EV_VERTICAL_BOX
		redefine
			is_in_default_state
		end

	SD_CONSTANTS
		undefine
			is_equal, default_create, copy
		end

-- This class is the implementation of an EV_TITLED_WINDOW generated by EiffelBuild.
-- You should not modify this code by hand, as it will be re-generated every time
-- modifications are made to the project.

feature {NONE}-- Initialization

	custom_initialize
			-- Initialize `Current'
		do
			initialize_constants

			extend (l_ev_horizontal_box_1)
			l_ev_horizontal_box_1.extend (left_top)

			l_ev_horizontal_box_1.extend (gap_area_holder)
			gap_area_holder.extend (top_bar)
			gap_area_holder.extend (gap_area_top)
			gap_area_holder.disable_item_expand (gap_area_top)
			l_ev_horizontal_box_1.extend (right_top)

			extend (l_ev_horizontal_box_2)
			l_ev_horizontal_box_2.extend (left_bar)
			l_ev_horizontal_box_2.extend (gap_area_left)
			l_ev_horizontal_box_2.disable_item_expand (gap_area_left)
			l_ev_horizontal_box_2.extend (center_area)
			l_ev_horizontal_box_2.extend (gap_area_right)
			l_ev_horizontal_box_2.disable_item_expand (gap_area_right)
			l_ev_horizontal_box_2.extend (right_bar)

			extend (l_ev_horizontal_box_3)
			l_ev_horizontal_box_3.extend (left_bottom)
			create gap_area_holder
			l_ev_horizontal_box_3.extend (gap_area_holder)
			gap_area_holder.extend (gap_area_bottom)
			gap_area_holder.disable_item_expand (gap_area_bottom)
			gap_area_holder.extend (bottom_bar)
			l_ev_horizontal_box_3.extend (right_bottom)

			l_ev_horizontal_box_1.disable_item_expand (left_top)
			l_ev_horizontal_box_1.disable_item_expand (right_top)

			l_ev_horizontal_box_2.disable_item_expand (left_bar)
			l_ev_horizontal_box_2.disable_item_expand (right_bar)
			l_ev_horizontal_box_3.disable_item_expand (left_bottom)
			l_ev_horizontal_box_3.disable_item_expand (right_bottom)

			disable_item_expand (l_ev_horizontal_box_1)
			disable_item_expand (l_ev_horizontal_box_3)

				--Connect events.
				-- Close the application when an interface close
				-- request is received on `Current'. i.e. the cross is clicked.

				-- Call `user_initialization'.
			user_initialization
		end

feature -- Access

	top_bar, left_bar, center_area, right_bar, bottom_bar: EV_CELL

feature {NONE} -- Implementation

	left_top, right_top, left_bottom, right_bottom: EV_CELL
	l_ev_horizontal_box_1, l_ev_horizontal_box_2,
	l_ev_horizontal_box_3: EV_HORIZONTAL_BOX

	gap_area_holder: EV_VERTICAL_BOX
	gap_area_top, gap_area_bottom, gap_area_left, gap_area_right: EV_BOX

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






end -- class SD_MAIN_CONTAINER_IMP
