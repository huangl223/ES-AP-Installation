note
	description: "Standard dialog box to open a file."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2008-12-29 20:27:11 +0000 (Mon, 29 Dec 2008) $"
	revision: "$Revision: 76420 $"

class
	WEL_OPEN_FILE_DIALOG

inherit
	WEL_FILE_DIALOG

create
	make

feature -- Basic operations

	activate (a_parent: WEL_COMPOSITE_WINDOW)
			-- Activate the dialog box (modal mode) with
			-- `a_parent' as owner.
		do
			set_parent (a_parent)
			selected := cwin_get_open_file_name (item)
		end

feature {NONE} -- Externals

	cwin_get_open_file_name (ptr: POINTER): BOOLEAN
			-- SDK GetOpenFileName
		external
			"C [macro <cdlg.h>] (LPOPENFILENAME): EIF_BOOLEAN"
		alias
			"GetOpenFileName"
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




end -- class WEL_OPEN_FILE_NAME

