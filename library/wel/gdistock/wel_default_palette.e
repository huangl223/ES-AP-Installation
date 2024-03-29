note
	description: "Default color palette. This palette consists of the %
		%static colors in the system palette."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2008-12-29 20:27:11 +0000 (Mon, 29 Dec 2008) $"
	revision: "$Revision: 76420 $"

class
	WEL_DEFAULT_PALETTE

inherit
	WEL_PALETTE
		rename
			make as palette_make
		end

	WEL_GDI_STOCK

create
	make

feature {NONE} -- Implementation

	stock_id: INTEGER
			-- GDI stock object identifier
		once
			Result := Default_palette
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




end -- class WEL_DEFAULT_PALETTE

