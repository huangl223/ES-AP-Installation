
note
	description: "EiffelVision accelerator. GTK+ implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2017-03-27 17:23:22 +0000 (Mon, 27 Mar 2017) $"
	revision: "$Revision: 100056 $"

class
	EV_ACCELERATOR_IMP

inherit
	EV_ACCELERATOR_I
		redefine
			interface
		end

create
	make

feature -- Initialization

	old_make (an_interface: attached like interface)
			-- Connect interface.
		do
			assign_interface (an_interface)
		end

	make
			-- Setup `Current'
		do
			create key
			set_is_initialized (True)
		end

feature -- Access

	key: EV_KEY
			-- Representation of the character that must be entered
			-- by the user. See class EV_KEY_CODE

	shift_required: BOOLEAN
			-- Must the shift key be pressed?

	alt_required: BOOLEAN
			-- Must the alt key be pressed?

	control_required: BOOLEAN
			-- Must the control key be pressed?

feature -- Element change

	set_key (a_key: EV_KEY)
			-- Set `a_key' as new key that has to be pressed.
		do
			key := a_key.twin
		end

	enable_shift_required
			-- "Shift" must be pressed for the key combination.
		do
			shift_required := True
		end

	disable_shift_required
			-- "Shift" is not part of the key combination.
		do
			shift_required := False
		end

	enable_alt_required
			-- "Alt" must be pressed for the key combination.
		do
			alt_required := True
		end

	disable_alt_required
			-- "Alt" is not part of the key combination.
		do
			alt_required := False
		end

	enable_control_required
			-- "Control" must be pressed for the key combination.
		do
			control_required := True
		end

	disable_control_required
			-- "Control" is not part of the key combination.
		do
			control_required := False
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_ACCELERATOR note option: stable attribute end;
		-- Interface object of `Current'

feature {NONE} -- Implementation

	destroy
			-- Free resources of `Current'
		do
			set_is_destroyed (True)
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

end -- class EV_ACCELERATOR_IMP
