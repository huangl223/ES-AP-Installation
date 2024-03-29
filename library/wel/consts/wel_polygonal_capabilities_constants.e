note
	description: "Polygonal capabilities (PC) constants."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2008-12-29 20:27:11 +0000 (Mon, 29 Dec 2008) $"
	revision: "$Revision: 76420 $"

class
	WEL_POLYGONAL_CAPABILITIES_CONSTANTS

feature -- Access

	Pc_none: INTEGER
			-- Supports no polygons
		external
			"C [macro %"wel.h%"]"
		alias
			"PC_NONE"
		end

	Pc_polygon: INTEGER
			-- Supports alternate fill polygons
		external
			"C [macro %"wel.h%"]"
		alias
			"PC_POLYGON"
		end

	Pc_rectangle: INTEGER
			-- Supports rectangles
		external
			"C [macro %"wel.h%"]"
		alias
			"PC_RECTANGLE"
		end

	Pc_windpolygon: INTEGER
			-- Supports winding number fill polygons
		external
			"C [macro %"wel.h%"]"
		alias
			"PC_WINDPOLYGON"
		end

	Pc_scanline: INTEGER
			-- Supports scan lines
		external
			"C [macro %"wel.h%"]"
		alias
			"PC_SCANLINE"
		end

	Pc_wide: INTEGER
			-- Supports wide borders
		external
			"C [macro %"wel.h%"]"
		alias
			"PC_WIDE"
		end

	Pc_styled: INTEGER
			-- Supports styled borders
		external
			"C [macro %"wel.h%"]"
		alias
			"PC_STYLED"
		end

	Pc_widestyled: INTEGER
			-- Supports wide, styled borders
		external
			"C [macro %"wel.h%"]"
		alias
			"PC_WIDESTYLED"
		end

	Pc_interiors: INTEGER
			-- Supports interiors
		external
			"C [macro %"wel.h%"]"
		alias
			"PC_INTERIORS"
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




end -- class WEL_POLYGONAL_CAPABILITIES_CONSTANTS

