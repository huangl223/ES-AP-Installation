note
	description: "Contains information about the menu of a MDI application."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2008-12-29 20:27:11 +0000 (Mon, 29 Dec 2008) $"
	revision: "$Revision: 76420 $"

class
	WEL_CLIENT_CREATE_STRUCT

inherit
	WEL_STRUCTURE
		rename
			make as structure_make
		end

create
	make

feature {NONE} -- Initialization

	make (a_window_menu: WEL_MENU; a_first_child: INTEGER)
			-- Make a client structure with `a_window_menu' and
			-- `a_first_child'.
		require
			a_window_menu_not_void: a_window_menu /= Void
			a_window_menu_exists: a_window_menu.exists
		do
			structure_make
			set_window_menu (a_window_menu)
			set_first_child (a_first_child)
		ensure
			window_menu_set: window_menu.item = a_window_menu.item
			first_child_set: first_child = a_first_child
		end

feature -- Access

	window_menu: WEL_MENU
			-- MDI application's window menu
		do
			create Result.make_by_pointer (cwel_client_cs_get_window_menu (item))
		ensure
			result_not_void: Result /= Void
		end

	first_child: INTEGER
			-- Child window identifier of the first MDI child
			-- window created.
		do
			Result := cwel_client_cs_get_first_child (item)
		end

feature -- Element change

	set_window_menu (a_window_menu: WEL_MENU)
			-- Set `window_menu' with `a_window_menu'.
		require
			a_window_menu_not_void: a_window_menu /= Void
			a_window_menu_exists: a_window_menu.exists
		do
			cwel_client_cs_set_window_menu (item, a_window_menu.item)
		ensure
			window_menu_set: window_menu.item = a_window_menu.item
		end

	set_first_child (a_first_child: INTEGER)
			-- Set `first_child' with `a_first_child'.
		do
			cwel_client_cs_set_first_child (item, a_first_child)
		ensure
			first_child_set: first_child = a_first_child
		end

feature -- Measurement

	structure_size: INTEGER
			-- Size to allocate (in bytes)
		once
			Result := c_size_of_client_cs
		end

feature {NONE} -- Externals

	c_size_of_client_cs: INTEGER
		external
			"C [macro <clientcs.h>]"
		alias
			"sizeof (CLIENTCREATESTRUCT)"
		end

	cwel_client_cs_set_window_menu (ptr: POINTER; value: POINTER)
		external
			"C [macro <clientcs.h>]"
		end

	cwel_client_cs_set_first_child (ptr: POINTER; value: INTEGER)
		external
			"C [macro <clientcs.h>]"
		end

	cwel_client_cs_get_window_menu (ptr: POINTER): POINTER
		external
			"C [macro <clientcs.h>] (CLIENTCREATESTRUCT*): EIF_POINTER"
		end

	cwel_client_cs_get_first_child (ptr: POINTER): INTEGER
		external
			"C [macro <clientcs.h>]"
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

end
