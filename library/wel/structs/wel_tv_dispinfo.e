note
	description: "The TV_DISPINFO structure retrieves and sets%
				% information about a tree-view item."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2009-01-25 02:01:47 +0000 (Sun, 25 Jan 2009) $"
	revision: "$Revision: 76831 $"

class
	WEL_TV_DISPINFO

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
			create Result.make_by_pointer (cwel_tv_dispinfo_get_hdr (item))
		ensure
			result_not_void: Result /= Void
		end

	tree_item: WEL_TREE_VIEW_ITEM
			-- Virtual key number.
		require
			exists: exists
		do
			create Result.make_by_pointer (cwel_tv_dispinfo_get_item (item))
		ensure
			result_not_void: Result /= Void
		end

feature -- Measurement

	structure_size: INTEGER
			-- Size to allocate (in bytes)
		once
			Result := c_size_of_tv_dispinfo
		end

feature {NONE} -- Externals

	c_size_of_tv_dispinfo: INTEGER
		external
			"C [macro <tvdispinfo.h>]"
		alias
			"sizeof (TV_DISPINFO)"
		end

	cwel_tv_dispinfo_get_hdr (ptr: POINTER): POINTER
		external
			"C [macro <tvdispinfo.h>] (TV_DISPINFO*): EIF_POINTER"
		end

	cwel_tv_dispinfo_get_item (ptr: POINTER): POINTER
		external
			"C [macro <tvdispinfo.h>] (TV_DISPINFO*): EIF_POINTER"
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
