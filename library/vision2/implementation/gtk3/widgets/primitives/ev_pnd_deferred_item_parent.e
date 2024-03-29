note
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date: 2016-09-27 16:37:27 +0000 (Tue, 27 Sep 2016) $"
	revision: "$Revision: 99194 $"

deferred class
	EV_PND_DEFERRED_ITEM_PARENT

feature {EV_ANY_I} -- Implementation

	item_from_coords (a_x, a_y: INTEGER): detachable EV_PND_DEFERRED_ITEM
			-- Retrieve the Current row from (`a_x', `a_y') coordinate
		deferred
		end

feature {EV_GTK_DEPENDENT_INTERMEDIARY_ROUTINES} -- Implementation

	on_mouse_button_event (
			a_type: INTEGER
			a_x, a_y, a_button: INTEGER;
			a_x_tilt, a_y_tilt, a_pressure: DOUBLE;
			a_screen_x, a_screen_y: INTEGER)

			-- Initialize a pick and drop transport.
		deferred
		end

feature {EV_GTK_DEPENDENT_INTERMEDIARY_ROUTINES} -- Event handling

	call_selection_action_sequences
			-- Call appropriate selection action sequences
		do
			-- By default do nothing, redefined in descendants.
		end

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




end -- class EV_PND_DEFERRED_ITEM_PARENT





