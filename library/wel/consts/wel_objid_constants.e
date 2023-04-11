note
	description: "ObjectID (OBJID) constants."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2013-05-20 23:15:17 +0000 (Mon, 20 May 2013) $"
	revision: "$Revision: 92557 $"

class
	WEL_OBJID_CONSTANTS

feature -- Access

	objid_client: INTEGER = 0xFFFFFFFC
			-- To get something associated with a window. What you get
			-- depends on the API that takes this as argument.

	objid_menu: INTEGER = 0xFFFFFFFD
			-- Get menu associated to a window.

	objid_sysmenu: INTEGER = 0xFFFFFFFF;
			-- Get system menu associated to a window.

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

end
