note
	description: "Eiffel Vision spin button. Implementation interface."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2016-09-27 15:50:48 +0000 (Tue, 27 Sep 2016) $"
	revision: "$Revision: 99192 $"

deferred class
	EV_SPIN_BUTTON_I

inherit
	EV_GAUGE_I
		redefine
			interface
		end

	EV_TEXT_FIELD_I
		rename
			change_actions as text_change_actions,
			change_actions_internal as text_change_actions_internal
		redefine
			interface
		end

feature {EV_ANY, EV_ANY_I} -- Implementatio

	interface: detachable EV_SPIN_BUTTON note option: stable attribute end;

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

end -- class EV_SPIN_BUTTON_I
