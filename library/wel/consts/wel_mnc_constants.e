note
	description: "Window constants for WM_MENUCHAR message."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2008-12-29 20:27:11 +0000 (Mon, 29 Dec 2008) $"
	revision: "$Revision: 76420 $"

class
	WEL_MNC_CONSTANTS

feature -- Access

	Mnc_ignore: INTEGER = 0
			-- Informs the system that it should discard the character the user
			-- pressed and create a short beep on the system speaker. 
			--
			-- Declared in Windows as MNC_IGNORE

	Mnc_close: INTEGER = 1
			-- Informs the system that it should close the active menu.
			--
			-- Declared in Windows as MNC_CLOSE

	Mnc_execute: INTEGER = 2
			-- Informs the system that it should choose the item specified in
			-- the low-order word of the return value. The owner window
			-- receives a WM_COMMAND message. 
			--
			-- Declared in Windows as MNC_EXECUTE

	Mnc_select: INTEGER = 3;
			-- Informs the system that it should select the item specified in
			-- the low-order word of the return value.  
			--
			-- Declared in Windows as MNC_SELECT
	
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




end -- class WEL_MNC_CONSTANTS

