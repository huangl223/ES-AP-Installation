note
	description: "System font."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2011-04-04 22:38:41 +0000 (Mon, 04 Apr 2011) $"
	revision: "$Revision: 86127 $"

class
	WEL_SYSTEM_FONT

obsolete
	"Access default system font via WEL_SHARED_FONTS instead (4 Apr 2011)"

inherit
	WEL_FONT
		rename
			make as font_make
		end

	WEL_GDI_STOCK

create
	make

feature {NONE} -- Implementation

	stock_id: INTEGER
			-- GDI stock object identifier
		once
			Result := System_font
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




end -- class WEL_SYSTEM_FONT

