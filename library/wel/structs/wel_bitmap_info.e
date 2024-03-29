note
	description: "Defines the dimensions and color information for a %
		%Windows device-independent bitmap (DIB)."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2017-04-10 08:03:05 +0000 (Mon, 10 Apr 2017) $"
	revision: "$Revision: 100121 $"

class
	WEL_BITMAP_INFO

inherit
	WEL_STRUCTURE
		rename
			make as structure_make
		end

	WEL_DIB_COLORS_CONSTANTS
		export
			{NONE} all
			{ANY} valid_dib_colors_constant
		undefine
			copy, is_equal
		end

create
	make,
	make_by_dc,
	make_by_pointer

feature {NONE} -- Initialization

	make (a_bitmap_info_header: WEL_BITMAP_INFO_HEADER; a_rgb_quad_count: INTEGER)
			-- Make a BITMAPINFO structure
			-- with `a_bitmap_info_header'
		require
			a_bitmap_info_header_not_void: a_bitmap_info_header /= Void
			a_bitmap_info_header_exists: a_bitmap_info_header.exists
			positive_rgb_quad_count: a_rgb_quad_count >= 0
		do
			rgb_quad_count := a_rgb_quad_count
			structure_make
			set_bitmap_info_header (a_bitmap_info_header)
		end

	make_by_dc (dc: WEL_DC; bitmap: WEL_BITMAP; usage: INTEGER)
			-- Make a bitmap info structure using `dc' and
			-- `bitmap'.
			-- See class WEL_DIB_COLORS_CONSTANTS for `usage'
			-- values.
		require
			dc_not_void: dc /= Void
			dc_exists: dc.exists
			bitmap_not_void: bitmap /= Void
			bitmap_exists: bitmap.exists
			valid_usage: valid_dib_colors_constant (usage)
		local
			bih: WEL_BITMAP_INFO_HEADER
		do
			rgb_quad_count := 0
			structure_make
			create bih.make
			set_bitmap_info_header (bih)
			cwin_get_di_bits (dc.item, bitmap.item, 0, 0, default_pointer, item, usage)

			rgb_quad_count := header.color_count
			if rgb_quad_count > 0 then
					-- If we use the color table, we need to reallocate it.
				item := item.memory_realloc (structure_size)
				if item = default_pointer then
					(create {EXCEPTIONS}).raise ("No more memory")
				end
			end
		end

feature -- Access

	header: WEL_BITMAP_INFO_HEADER
			-- Information about the dimensions and color
			-- format of a DIB
		require
			exists: exists
		do
			create Result.make_by_pointer (cwel_bitmap_info_get_header (item))
		ensure
			result_not_void: Result /= Void
		end

	rgb_quad_count: INTEGER
			-- Number of colors

	rgb_quad (index: INTEGER): WEL_RGB_QUAD
			-- Bitmap color at zero-based `index'
		require
			exists: exists
			index_small_enough: index < rgb_quad_count
			index_large_enough: index >= 0
		do
			create Result.make_by_pointer (cwel_bitmap_info_get_rgb_quad (item, index))
		ensure
			result_not_void: Result /= Void
		end

	rgb_quad_natural (index: INTEGER): NATURAL_32
			-- Bitmap color at zero-based `index'
		require
			exists: exists
			index_small_enough: index < rgb_quad_count
			index_large_enough: index >= 0
		do
			Result := cwel_bitmap_info_get_rgb_quad_natural (item, index)
		end

feature -- Element change

	set_bitmap_info_header (a_header: WEL_BITMAP_INFO_HEADER)
			-- Set `header' with `a_header'.
		require
			exists: exists
			a_header_not_void: a_header /= Void
			a_header_exists: a_header.exists
		do
			cwel_bitmap_info_set_header (item, a_header.item)
		end

	set_rgb_quad (index: INTEGER; a_rgb_quad: WEL_RGB_QUAD)
			-- Set `rgb_quad' with `a_rgb_quad' at
			-- zero-based `index'.
		require
			index_small_enough: index < rgb_quad_count
			index_large_enough: index >= 0
			a_rgb_quad_not_void: a_rgb_quad /= Void
			a_rgb_quad_exists: a_rgb_quad.exists
		do
			cwel_bitmap_info_set_rgb_quad_rgb_red (item, index, a_rgb_quad.red)
			cwel_bitmap_info_set_rgb_quad_rgb_green (item, index, a_rgb_quad.green)
			cwel_bitmap_info_set_rgb_quad_rgb_blue (item, index, a_rgb_quad.blue)
			cwel_bitmap_info_set_rgb_quad_rgb_reserved (item, index, a_rgb_quad.reserved)
		end

feature -- Measurement

	structure_size: INTEGER
			-- Size to allocate (in bytes)
		do
				-- It has to be `- 1' because in the size of `BITMAP_INFO' it already
				-- contains one entry for a RGBQUAD.
			Result := c_size_of_bitmap_info + ((rgb_quad_count - 1) * c_size_of_rgb_quad)
		end

feature -- Obsolete

	bitmap_info_header: WEL_BITMAP_INFO_HEADER obsolete "Use `header' [2017-05-31]"
		require
			exists: exists
		do
			Result := header
		end

feature {NONE} -- Externals

	c_size_of_bitmap_info: INTEGER
		external
			"C [macro <bmpinfo.h>]"
		alias
			"sizeof (BITMAPINFO)"
		end

	c_size_of_rgb_quad: INTEGER
		external
			"C [macro <bmpinfo.h>]"
		alias
			"sizeof (RGBQUAD)"
		end

	cwel_bitmap_info_set_rgb_quad_rgb_red (ptr: POINTER; index,
			value: INTEGER)
		external
			"C [macro <bmpinfo.h>]"
		end

	cwel_bitmap_info_set_header (ptr: POINTER; value: POINTER)
		external
			"C [macro <bmpinfo.h>]"
		end

	cwel_bitmap_info_set_rgb_quad_rgb_green (ptr: POINTER; index,
			value: INTEGER)
		external
			"C [macro <bmpinfo.h>]"
		end

	cwel_bitmap_info_set_rgb_quad_rgb_blue (ptr: POINTER; index,
			value: INTEGER)
		external
			"C [macro <bmpinfo.h>]"
		end

	cwel_bitmap_info_set_rgb_quad_rgb_reserved (ptr: POINTER; index,
			value: INTEGER)
		external
			"C [macro <bmpinfo.h>]"
		end

	cwel_bitmap_info_get_header (ptr: POINTER): POINTER
		external
			"C [macro <bmpinfo.h>] (BITMAPINFO*): EIF_POINTER"
		end

	cwel_bitmap_info_get_rgb_quad (ptr: POINTER; i: INTEGER): POINTER
		external
			"C [macro <bmpinfo.h>]"
		end

	cwel_bitmap_info_get_rgb_quad_natural (ptr: POINTER; i: INTEGER): NATURAL_32
		external
			"C inline use <bmpinfo.h>"
		alias
			"{
				union {
					RGBQUAD rgb;
					EIF_NATURAL_32 n32;
				} xconvert;
				xconvert.rgb = ((BITMAPINFO*) $ptr)->bmiColors[$i];
				return xconvert.n32;
			}"
		end

	cwin_get_di_bits (hdc, hbmp: POINTER; start_scan, scan_lines: INTEGER;
			bits, bi: POINTER; usage: INTEGER)
			-- SDK GetDIBits
		external
			"C [macro <wel.h>] (HDC, HBITMAP, UINT, UINT, %
				%VOID *, BITMAPINFO *, UINT)"
		alias
			"GetDIBits"
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

end
