note
	description:
		"Eiffel Vision timeout. Mswindows implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2017-03-27 17:23:22 +0000 (Mon, 27 Mar 2017) $"
	revision: "$Revision: 100056 $"

class
	EV_TIMEOUT_IMP

inherit
	EV_TIMEOUT_I
		export
			{EV_INTERNAL_TIMEOUT_IMP}
				is_destroyed
		end

	IDENTIFIED
		rename
			object_id as id
		undefine
			copy, is_equal
		end

create
	make

feature -- Initialization

	old_make (an_interface: attached like interface)
			-- Create timer.
		do
			assign_interface (an_interface)
		end

	make
		do
			Internal_timeout.add_timeout (Current)
			set_is_initialized (True)
		end

feature -- Access

	interval: INTEGER
			-- Time between calls to `interface.actions' in milliseconds.

feature -- Status setting

	set_interval (an_interval: INTEGER)
			-- Assign `an_interval' in milliseconds to `interval'.
		do
			interval := an_interval
			Internal_timeout.change_interval (id, interval)
		end

feature -- Implementation

	destroy
			-- Destroy actual object.
		do
			internal_timeout.remove_timeout (id)
			set_is_destroyed (True)
		end

feature {NONE} -- Implementation

	Internal_timeout: EV_INTERNAL_TIMEOUT_IMP
			-- Window that launch the timeout commands.
		once
			create Result.make_top ("EiffelVision timeout window")
		end

note
	copyright:	"Copyright (c) 1984-2017, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class EV_TIMEOUT_IMP








