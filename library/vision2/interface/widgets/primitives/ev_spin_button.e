﻿note
	description:
		"[
			Displays `value' and two buttons that allow it to be adjusted up and
			down within `range'.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "gauge, edit, text, number, up, down"
	date: "$Date: 2018-12-18 11:03:05 +0000 (Tue, 18 Dec 2018) $"
	revision: "$Revision: 102624 $"

class
	EV_SPIN_BUTTON

inherit
	EV_GAUGE
		redefine
			implementation,
			is_in_default_state
		end

	EV_TEXT_FIELD
		rename
			change_actions as text_change_actions
		redefine
			create_implementation,
			implementation,
			is_in_default_state
		end

create
	default_create,
	make_with_value_range,
	make_with_text

feature {NONE} -- Contract support

	is_in_default_state: BOOLEAN
			-- Is `Current' in its default state.
		do
			Result := Precursor {EV_GAUGE} and then text.same_string_general ("0")
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	implementation: EV_SPIN_BUTTON_I
			-- Responsible for interaction with native graphics toolkit.

feature {NONE} -- Implementation

	create_implementation
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_SPIN_BUTTON_IMP} implementation.make
		end

note
	copyright: "Copyright (c) 1984-2018, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
