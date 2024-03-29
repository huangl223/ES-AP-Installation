note
	description:
		"Eiffel Vision primitive, implementation interface"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "primitive, base, widget"
	date: "$Date: 2009-06-11 04:44:06 +0000 (Thu, 11 Jun 2009) $"
	revision: "$Revision: 79201 $"

deferred class
	EV_PRIMITIVE_I

inherit
	EV_WIDGET_I
		redefine
			interface
		end

	EV_TOOLTIPABLE_I
		redefine
			interface
		end

	EV_TAB_CONTROLABLE_I
		redefine
			interface
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_PRIMITIVE note option: stable attribute end;

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




end -- class EV_PRIMITIVE_I









