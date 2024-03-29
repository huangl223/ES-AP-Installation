note
	description: "Toolbar notification (RBN) constants."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2008-12-29 20:27:11 +0000 (Mon, 29 Dec 2008) $"
	revision: "$Revision: 76420 $"

class
	WEL_TBN_CONSTANTS

feature -- Access

	Tbn_getbuttoninfo: INTEGER = -680
			-- Declared in Windows as TBN_GETBUTTONINFO

	Tbn_begindrag: INTEGER = -701
			-- Declared in Windows as TBN_BEGINDRAG

	Tbn_enddrag: INTEGER = -702
			-- Declared in Windows as TBN_ENDDRAG

	Tbn_beginadjust: INTEGER = -703
			-- Declared in Windows as TBN_BEGINADJUST

	Tbn_endadjust: INTEGER = -704
			-- Declared in Windows as TBN_ENDADJUST

	Tbn_reset: INTEGER = -705
			-- Declared in Windows as TBN_RESET

	Tbn_queryinsert: INTEGER = -706
			-- Declared in Windows as TBN_QUERYINSERT

	Tbn_querydelete: INTEGER = -707
			-- Declared in Windows as TBN_QUERYDELETE

	Tbn_toolbarchange: INTEGER = -708
			-- Declared in Windows as TBN_TOOLBARCHANGE

	Tbn_custhelp: INTEGER = -709
			-- Declared in Windows as TBN_CUSTHELP

	Tbn_dropdown: INTEGER = -710;
			-- Declared in Windows as TBN_DROPDOWN

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




end -- class WEL_TBN_CONSTANTS

