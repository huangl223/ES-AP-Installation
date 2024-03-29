note
	description:
		"Abstraction for objects that may be selected."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "select, selected, selectable"
	date: "$Date: 2013-05-20 23:15:17 +0000 (Mon, 20 May 2013) $"
	revision: "$Revision: 92557 $"

deferred class
	EV_SELECTABLE

inherit
	EV_ANY
		redefine
			implementation
		end

feature -- Status report

	is_selected: BOOLEAN
			-- Is selected?
		require
			not_destroyed: not is_destroyed
		do
			if is_selectable then
				Result := implementation.is_selected
			end
		ensure
			bridge_ok: is_selectable implies Result = implementation.is_selected
		end

	is_selectable: BOOLEAN
			-- May `enable_select' be called?
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.is_selectable
		end

feature -- Status setting

	enable_select
			-- Make `is_selected' True.
		require
			not_destroyed: not is_destroyed
			is_selectable: is_selectable
		do
			implementation.enable_select
		ensure
			is_selected: action_sequence_call_counter = old action_sequence_call_counter implies is_selected
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	implementation: EV_SELECTABLE_I;
			-- Responsible for interaction with native graphics toolkit.

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_SELECTABLE

