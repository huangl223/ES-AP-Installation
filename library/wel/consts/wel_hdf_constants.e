﻿note
	description: "Format flags for feature format of class WEL_HD_ITEM."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2017-12-25 09:53:13 +0000 (Mon, 25 Dec 2017) $"
	revision: "$Revision: 101206 $"

class
	WEL_HDF_CONSTANTS

feature -- Access

	frozen Hdf_center: INTEGER
			-- Centers the contents of the item.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"HDF_CENTER"
		ensure
			is_class: class
		end

	frozen Hdf_left: INTEGER
			-- Left aligns the contents of the item.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"HDF_LEFT"
		ensure
			is_class: class
		end

	frozen Hdf_right: INTEGER
			-- Right aligns the contents of the item.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"HDF_RIGHT"
		ensure
			is_class: class
		end

	frozen Hdf_justify_mask: INTEGER
			-- You can use this mask to isolate the text justification
			-- portion of the fmt member.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"HDF_JUSTIFYMASK"
		ensure
			is_class: class
		end

	frozen Hdf_owner_draw: INTEGER
			-- The owner window of the header control draws the item.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"HDF_OWNERDRAW"
		ensure
			is_class: class
		end

	frozen Hdf_bitmap: INTEGER
			-- The item displays a bitmap.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"HDF_BITMAP"
		ensure
			is_class: class
		end

	frozen Hdf_string: INTEGER
			-- The item displays a string.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"HDF_STRING"
		ensure
			is_class: class
		end

	frozen Hdf_image: INTEGER
			-- The item displays an image from an image list.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"HDF_IMAGE"
		ensure
			is_class: class
		end

	frozen Hdf_rtl_reading: INTEGER
			-- In addition, on Hebrew or Arabic systems you can specify this flag
			-- to display text using right-to-left reading order.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"HDF_RTLREADING"
		ensure
			is_class: class
		end

note
	copyright:	"Copyright (c) 1984-2017, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
