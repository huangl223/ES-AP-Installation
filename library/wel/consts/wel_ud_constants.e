note
	description: "Up-down control (UD) constants."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2008-12-29 20:27:11 +0000 (Mon, 29 Dec 2008) $"
	revision: "$Revision: 76420 $"

class
	WEL_UD_CONSTANTS

feature -- Access

	Ud_maxval: INTEGER = 32767
			-- Maximum value allowed in an up-down control.
			--
			-- Declared in Windows as UD_MAXVAL

	Ud_minval: INTEGER = -32767;
			-- Minimum value allowed in an up-down control.
			--
			-- Declared in Windows as UD_MINVAL

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




end -- class WEL_UD_CONSTANTS

