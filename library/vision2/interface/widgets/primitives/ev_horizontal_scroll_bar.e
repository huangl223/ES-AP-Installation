note
	description:
		"[
			Interactive horizontal scrolling widget.
		]"
	legal: "See notice at end of class."
	appearance:
		"[
			+-+---------+-+
			|<| |#|     |>|
			+-+---------+-+
		]"
	status: "See notice at end of class."
	keywords: "horizontal, scroll, bar, gauge"
	date: "$Date: 2009-06-04 00:11:49 +0000 (Thu, 04 Jun 2009) $"
	revision: "$Revision: 79073 $"

class
	EV_HORIZONTAL_SCROLL_BAR

inherit
	EV_SCROLL_BAR
		redefine
			implementation
		end

create
	default_create,
	make_with_value_range

feature {EV_ANY, EV_ANY_I} -- Implementation

	implementation: EV_HORIZONTAL_SCROLL_BAR_I
			-- Responsible for interaction with native graphics toolkit.

feature {NONE} -- Implementation

	create_implementation
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_HORIZONTAL_SCROLL_BAR_IMP} implementation.make
		end

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




end -- class EV_HORIZONTAL_SCROLL_BAR







