note
	description: "Contains information about a list view keydown%
				% notification message."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2009-01-25 02:01:47 +0000 (Sun, 25 Jan 2009) $"
	revision: "$Revision: 76831 $"

class
	WEL_LV_KEYDOWN

inherit
	WEL_STRUCTURE

create
	make,
	make_by_nmhdr,
	make_by_pointer

feature {NONE} -- Initialization

	make_by_nmhdr (a_nmhdr: WEL_NMHDR)
			-- Make the structure with `a_nmhdr'.
		require
			a_nmhdr_not_void: a_nmhdr /= Void
			a_nmhdr_exists: a_nmhdr.exists
		do
			make_by_pointer (a_nmhdr.item)
		end

feature -- Access

	hdr: WEL_NMHDR
			-- Information about the Wm_notify message.
		require
			exists: exists
		do
			create Result.make_by_pointer (cwel_lv_keydown_get_hdr (item))
		ensure
			result_not_void: Result /= Void
		end

	virtual_key: INTEGER
			-- Virtual key number.
		require
			exists: exists
		do
			Result := cwel_lv_keydown_get_wvkey (item)
		end

feature -- Measurement

	structure_size: INTEGER
			-- Size to allocate (in bytes)
		once
			Result := c_size_of_lv_keydown
		end

feature {NONE} -- Externals

	c_size_of_lv_keydown: INTEGER
		external
			"C [macro %"lvkeydown.h%"]"
		alias
			"sizeof (LV_KEYDOWN)"
		end

	cwel_lv_keydown_get_hdr (ptr: POINTER): POINTER
		external
			"C [macro %"lvkeydown.h%"] (LV_KEYDOWN*): EIF_POINTER"
		end

	cwel_lv_keydown_get_wvkey (ptr: POINTER): INTEGER
		external
			"C [macro %"lvkeydown.h%"] (LV_KEYDOWN *): EIF_INTEGER"
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
