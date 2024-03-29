note
	description: "Up-Down control style (UDS) constants."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2008-12-29 20:27:11 +0000 (Mon, 29 Dec 2008) $"
	revision: "$Revision: 76420 $"

class
	WEL_UDS_CONSTANTS

feature -- Access

	Uds_alignleft: INTEGER = 8
			-- Positions the up-down control next to the left edge
			-- of the buddy window. The buddy window is moved to the
			-- right and its width decreased to accommodate the
			-- width of the up-down control.
			--
			-- Declared in Windows as UDS_ALIGNLEFT

	Uds_alignright: INTEGER = 4
			-- Positions the up-down control next to the right edge
			-- of the buddy window. The width of the buddy window is
			-- decreased to accommodate the width of the up-down
			-- control.
			--
			-- Declared in Windows as UDS_ALIGNRIGHT

	Uds_arrowkeys: INTEGER = 32
			-- Causes the up-down control to increment and
			-- decrement the position when the UP ARROW and DOWN
			-- ARROW keys are pressed.
			--
			-- Declared in Windows as UDS_ARROWKEYS

	Uds_autobuddy: INTEGER = 16
			-- Automatically selects the previous window in the
			-- Z order as the up-down control's buddy window.
			--
			-- Declared in Windows as UDS_AUTOBUDDY

	Uds_horz: INTEGER = 64
			-- Causes the up-down control's arrows to point left
			-- and right instead of up and down.
			--
			-- Declared in Windows as UDS_HORZ

	Uds_hottrack: INTEGER = 256
			-- Causes the control to exhibit "hot tracking" behavior. That 
			-- is, it highlights the UP ARROW and DOWN ARROW on the control 
			-- as the pointer passes over them. This style requires 
			-- Microsoft Windows 98 or Windows 2000. If the system is 
			-- running Windows 95 or Windows NT 4.0, the flag is ignored. 
			-- To check whether hot tracking is enabled, call 
			-- SystemParametersInfo. 
			--
			-- Declared in Windows as UDS_HOTTRACK

	Uds_nothousands: INTEGER = 128
			-- Does not insert a thousands separator between every
			-- three decimal digits.
			--
			-- Declared in Windows as UDS_NOTHOUSANDS

	Uds_setbuddyint: INTEGER = 2
			-- Causes the up-down control to set the text of the
			-- buddy window (using the WM_SETTEXT message) when the
			-- position changes. The text consists of the position
			-- formatted as a decimal or hexadecimal string.
			--
			-- Declared in Windows as UDS_SETBUDDYINT

	Uds_wrap: INTEGER = 1;
			-- Causes the position to "wrap" if it is incremented
			-- or decremented beyond the ending or beginning of the
			-- range.
			--
			-- Declared in Windows as UDS_WRAP

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




end -- class WEL_UDS_CONSTANTS

