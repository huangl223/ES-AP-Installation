note
	description: "Contains information about a combo-box-ex%
			% Cben_endedit notification message."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2009-01-25 02:01:47 +0000 (Sun, 25 Jan 2009) $"
	revision: "$Revision: 76831 $"

class
	WEL_NM_COMBO_BOX_EX_ENDEDIT

inherit
	WEL_STRUCTURE

create
	make,
	make_by_nmhdr,
	make_by_pointer

feature -- Initialization

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
			create Result.make_by_pointer (cwel_nm_cbeendedit_get_hdr (item))
		ensure
			result_not_void: Result /= Void
		end

	has_changed: BOOLEAN
			-- Value indicating whether the contents of the control's
			-- edit box have changed.
		require
			exists: exists
		do
			Result := cwel_nm_cbeendedit_get_fchanged (item) /= 0
		end

	selected_item: INTEGER
			-- Zero-based index of the item that will be selected
			-- after completing the edit operation.
		require
			exists: exists
		do
			Result := cwel_nm_cbeendedit_get_inewselection (item)
		end

	text: STRING_32
			-- Text from within the control's edit box.
		do
				-- Fixme: this routine is useless without a `set_text' counterpart.
			create Result.make_empty
		end

	why: INTEGER
			-- Value that specifies the action that generated then
			-- Cben_endedit notification message.
			-- Can be any of the Cbenf_* constants.
			-- See class WEL_CBEN_CONSTANTS for values.
		require
			exists: exists
		do
			Result := cwel_nm_cbeendedit_get_iwhy (item)
		end

feature -- Measurement

	structure_size: INTEGER
			-- Size to allocate (in bytes)
		once
			Result := c_size_of_nm_cbeendedit
		end

feature {NONE} -- Externals

	c_size_of_nm_cbeendedit: INTEGER
		external
			"C [macro %"nmcbeendedit.h%"]"
		alias
			"sizeof (NMCBEENDEDIT)"
		end

	cwel_nm_cbeendedit_get_hdr (ptr: POINTER): POINTER
		external
			"C [macro %"nmcbeendedit.h%"] (NMCBEENDEDIT*): EIF_POINTER"
		end

	cwel_nm_cbeendedit_get_fchanged (ptr: POINTER): INTEGER
		external
			"C [macro %"nmcbeendedit.h%"]"
		end

	cwel_nm_cbeendedit_get_inewselection (ptr: POINTER): INTEGER
		external
			"C [macro %"nmcbeendedit.h%"]"
		end

	cwel_nm_cbeendedit_get_tchar (ptr: POINTER): POINTER
		external
			"C [macro %"nmcbeendedit.h%"] (NMCBEENDEDIT*): EIF_POINTER"
		end

	cwel_nm_cbeendedit_get_iwhy (ptr: POINTER): INTEGER
		external
			"C [macro %"nmcbeendedit.h%"]"
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
