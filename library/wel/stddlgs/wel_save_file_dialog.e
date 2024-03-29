note
	description: "Standard dialog box to save a file."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2013-05-30 20:53:24 +0000 (Thu, 30 May 2013) $"
	revision: "$Revision: 92652 $"

class
	WEL_SAVE_FILE_DIALOG

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
			selected := cwin_get_save_file_name (item)
		end

feature {NONE} -- Externals

	cwin_get_save_file_name (ptr: POINTER): BOOLEAN
			-- SDK GetSaveFileName
		external
			"C [macro <cdlg.h>] (LPOPENFILENAME): EIF_BOOLEAN"
		alias
			"GetSaveFileName"
		end


note
	copyright:	"Copyright (c) 1984-2013, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class WEL_SAVE_FILE_DIALOG

