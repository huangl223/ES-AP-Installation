note
	description: "Choose color (CC) dialog constants."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2008-12-29 20:27:11 +0000 (Mon, 29 Dec 2008) $"
	revision: "$Revision: 76420 $"

class
	WEL_CHOOSE_COLOR_CONSTANTS

feature -- Access

	Cc_rgbinit: INTEGER
		external
			"C [macro %"cdlg.h%"]"
		alias
			"CC_RGBINIT"
		end

	Cc_fullopen: INTEGER
		external
			"C [macro %"cdlg.h%"]"
		alias
			"CC_FULLOPEN"
		end

	Cc_preventfullopen: INTEGER
		external
			"C [macro %"cdlg.h%"]"
		alias
			"CC_PREVENTFULLOPEN"
		end

	Cc_showhelp: INTEGER
		external
			"C [macro %"cdlg.h%"]"
		alias
			"CC_SHOWHELP"
		end

	Cc_enablehook: INTEGER
		external
			"C [macro %"cdlg.h%"]"
		alias
			"CC_ENABLEHOOK"
		end

	Cc_enabletemplate: INTEGER
		external
			"C [macro %"cdlg.h%"]"
		alias
			"CC_ENABLETEMPLATE"
		end

	Cc_enabletemplatehandle: INTEGER
		external
			"C [macro %"cdlg.h%"]"
		alias
			"CC_ENABLETEMPLATEHANDLE"
		end

	Cc_solidcolor: INTEGER
		external
			"C [macro %"cdlg.h%"]"
		alias
			"CC_SOLIDCOLOR"
		end

	Cc_anycolor: INTEGER
		external
			"C [macro %"cdlg.h%"]"
		alias
			"CC_ANYCOLOR"
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




end -- class WEL_CHOOSE_COLOR_CONSTANTS

