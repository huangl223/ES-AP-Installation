note
	description: "Action sequence for a pointer motion during a pick and drop."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2017-05-03 15:56:14 +0000 (Wed, 03 May 2017) $"
	revision: "$Revision: 100317 $"

class
	EV_PND_MOTION_ACTION_SEQUENCE

inherit
	EV_ACTION_SEQUENCE [TUPLE [x: INTEGER; y: INTEGER; pick_and_dropable: detachable EV_ABSTRACT_PICK_AND_DROPABLE]]

create
	default_create

create {EV_PND_MOTION_ACTION_SEQUENCE}
	make_filled

feature -- Access

	force_extend (action: PROCEDURE)
			-- Extend without type checking.
		obsolete
			"Use `extend' instead and provide the right type of agent. [2017-05-31]"
		do
			extend (agent wrapper (?, ?, ?, action))
		end

	wrapper (an_x, a_y: INTEGER; a_pick_and_dropable: detachable EV_ABSTRACT_PICK_AND_DROPABLE; action: PROCEDURE)
			-- Use this to circumvent tuple type checking. (at your own risk!)
			-- Calls `action' passing all other arguments.
		obsolete
			"Call `action' directly instead. [2017-05-31]"
		do
			action.call ([an_x, a_y, a_pick_and_dropable])
		end


feature {NONE} -- Implementation

	new_filled_list (n: INTEGER): like Current
			-- New list with `n' elements.
		do
			create Result.make_filled (n)
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




end -- class EV_PND_MOTION_ACTION_SEQUENCE










