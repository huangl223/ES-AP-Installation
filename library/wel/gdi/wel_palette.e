note
	description: "Logical color palette."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2009-01-25 02:01:47 +0000 (Sun, 25 Jan 2009) $"
	revision: "$Revision: 76831 $"

class
	WEL_PALETTE

inherit
	WEL_GDI_ANY

create
	make,
	make_by_pointer

feature {NONE} -- Initialization

	make (a_log_palette: WEL_LOG_PALETTE)
			-- Create a palette associated to `a_log_palette'
		require
			a_log_palette_not_void: a_log_palette /= Void
			a_log_palette_exists: a_log_palette.exists
		do
			item := cwin_create_palette (a_log_palette.item)
			gdi_make
		end

feature -- Access

	palette_index (i: INTEGER): WEL_COLOR_REF
			-- Color number `i' of the palette
		require
			exists: exists
		do
			create Result.make_by_color (cwin_palette_index (i))
		ensure
			result_not_void: Result /= Void
		end

feature {NONE} -- Externals

	cwin_create_palette (a_palette: POINTER): POINTER
			-- SDK CreatePalette
		external
			"C [macro <windows.h>] (LOGPALETTE *): EIF_POINTER"
		alias
			"CreatePalette"
		end

	cwin_palette_index (i: INTEGER): INTEGER
			-- SDK PALETTEINDEX
		external
			"C [macro <windows.h>] (WORD): COLORREF"
		alias
			"PALETTEINDEX"
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




end -- class WEL_PALETTE

