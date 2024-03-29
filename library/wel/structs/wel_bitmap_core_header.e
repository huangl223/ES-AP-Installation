note
	description: "Contains information about the dimensions and color %
		%format of a device-independent bitmap (DIB)."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2008-12-29 20:27:11 +0000 (Mon, 29 Dec 2008) $"
	revision: "$Revision: 76420 $"

class
	WEL_BITMAP_CORE_HEADER

inherit
	WEL_STRUCTURE
		rename
			make as structure_make
		end
create
	make,
	make_by_pointer

feature {NONE} -- Initialization

	make (a_width, a_height, a_planes, a_bit_count: INTEGER)
		do
			structure_make
			cwel_bitmapcoreheader_set_size (item, structure_size)
			set_width (a_width)
			set_height (a_height)
			set_planes (a_planes)
			set_bit_count (a_bit_count)
		ensure
			width_set: width = a_width
			height_set: height = a_height
			planes_set: planes = a_planes
			bit_count_set: bit_count = a_bit_count
		end

feature -- Access

	width: INTEGER
		do
			Result := cwel_bitmapcoreheader_get_width (item)
		end

	height: INTEGER
		do
			Result := cwel_bitmapcoreheader_get_height (item)
		end

	planes: INTEGER
		do
			Result := cwel_bitmapcoreheader_get_planes (item)
		end

	bit_count: INTEGER
		do
			Result := cwel_bitmapcoreheader_get_bitcount (item)
		end

feature -- Element change

	set_width (a_width: INTEGER)
		do
			cwel_bitmapcoreheader_set_width (item, a_width)
		ensure
			width_set: width = a_width
		end

	set_height (a_height: INTEGER)
		do
			cwel_bitmapcoreheader_set_height (item, a_height)
		ensure
			height_set: height = a_height
		end

	set_planes (a_planes: INTEGER)
		do
			cwel_bitmapcoreheader_set_planes (item, a_planes)
		ensure
			planes_set: planes = a_planes
		end

	set_bit_count (a_bit_count: INTEGER)
		do
			cwel_bitmapcoreheader_set_bitcount (item, a_bit_count)
		ensure
			bit_count_set: bit_count = a_bit_count
		end

feature -- Measurement

	structure_size: INTEGER
			-- Size to allocate (in bytes)
		once
			Result := c_size_of_bitmapcoreheader
		end

feature {NONE} -- Externals

	c_size_of_bitmapcoreheader: INTEGER
		external
			"C [macro <bmpcoreh.h>]"
		alias
			"sizeof (BITMAPCOREHEADER)"
		end

	cwel_bitmapcoreheader_set_size (ptr: POINTER; value: INTEGER)
		external
			"C [macro <bmpcoreh.h>]"
		end

	cwel_bitmapcoreheader_set_width (ptr: POINTER; value: INTEGER)
		external
			"C [macro <bmpcoreh.h>]"
		end

	cwel_bitmapcoreheader_set_height (ptr: POINTER; value: INTEGER)
		external
			"C [macro <bmpcoreh.h>]"
		end

	cwel_bitmapcoreheader_set_planes (ptr: POINTER; value: INTEGER)
		external
			"C [macro <bmpcoreh.h>]"
		end

	cwel_bitmapcoreheader_set_bitcount (ptr: POINTER; value: INTEGER)
		external
			"C [macro <bmpcoreh.h>]"
		end

	cwel_bitmapcoreheader_get_width (ptr: POINTER): INTEGER
		external
			"C [macro <bmpcoreh.h>]"
		end

	cwel_bitmapcoreheader_get_height (ptr: POINTER): INTEGER
		external
			"C [macro <bmpcoreh.h>]"
		end

	cwel_bitmapcoreheader_get_planes (ptr: POINTER): INTEGER
		external
			"C [macro <bmpcoreh.h>]"
		end

	cwel_bitmapcoreheader_get_bitcount (ptr: POINTER): INTEGER
		external
			"C [macro <bmpcoreh.h>]"
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
