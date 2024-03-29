note
	description: "[
			Supplies the identifiers and application-supplied data for two 
			items in a sorted, owner-drawn list box or combo box. 
			Whenever an application adds a new item to an owner-drawn 
			list box or combo box created with the CBS_SORT or LBS_SORT 
			style, the system sends the owner a Wm_compareitem message. 
			The `lparam' parameter of the message contains a long pointer 
			to a COMPAREITEMSTRUCT structure. Upon receiving the message, 
			the owner compares the two items and returns a value indicating 
			which item sorts before the other.
			]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2012-03-28 23:32:32 +0000 (Wed, 28 Mar 2012) $"
	revision: "$Revision: 88477 $"

class
	WEL_COMPARE_ITEM_STRUCT

inherit
	WEL_STRUCTURE

	WEL_WINDOWS_ROUTINES
		undefine
			copy, is_equal
		end

create
	make_by_pointer

feature -- Access

	ctl_type: INTEGER
			-- Control type.
			-- See class WEL_ODT_CONSTANTS.
			-- Specifies ODT_LISTBOX or ODT_COMBOBOX.
		do
			Result := cwel_compareitemstruct_get_ctltype (item)
		end

	ctl_id: INTEGER
			-- Specifies the identifier of the list box or combo box.
		do
			Result := cwel_compareitemstruct_get_ctlid (item)
		end

	window_item: detachable WEL_CONTROL
			-- Identifies the control.
		do
			if attached {like window_item} window_of_item (cwel_compareitemstruct_get_hwnditem (item)) as l_control then
				Result := l_control
			end
		end

	item_id_1: INTEGER
			-- Specifies the index of the first item in
			-- the list box or combo box being compared.
			-- This member will be -1 if the item has not
			-- been inserted or when searching for a potential
			-- item in the list box or combo box.
		do
			Result := cwel_compareitemstruct_get_itemid1 (item)
		end

	item_data_1: POINTER
			-- Specifies application-supplied data for the
			-- first item being compared. (This value was
			-- passed as the lParam parameter of the message
			-- that added the item to the list box or combo box.)
		do
			Result := cwel_compareitemstruct_get_itemdata1 (item)
		end

	item_id_2: INTEGER
			-- Specifies the index of the second item in the
			-- list box or combo box being compared.
		do
			Result := cwel_compareitemstruct_get_itemid2 (item)
		end

	item_data_2: POINTER
			-- Specifies application-supplied data for the
			-- second item being compared. This value was
			-- passed as the lParam parameter of the message
			-- that added the item to the list box or combo box.
			-- This member will be -1 if the item has not been
			-- inserted or when searching for a potential item
			-- in the list box or combo box.
		do
			Result := cwel_compareitemstruct_get_itemdata2 (item)
		end

	locale_id: INTEGER
			-- Specifies the locale identifier. To create a
			-- locale identifier, use the MAKELCID macro.
		do
			Result := cwel_compareitemstruct_get_dwlocaleid (item)
		end

feature -- Measurement

	structure_size: INTEGER
			-- Size to allocate (in bytes)
		once
			Result := c_size_of_compareitemstruct
		end

feature {NONE} -- Externals

	c_size_of_compareitemstruct: INTEGER
		external
			"C [macro <wel_compare_item.h>]"
		alias
			"sizeof (COMPAREITEMSTRUCT)"
		end

	cwel_compareitemstruct_get_ctltype (ptr: POINTER): INTEGER
		external
			"C macro signature (COMPAREITEMSTRUCT *): EIF_INTEGER use <wel_compare_item.h>"
		end

	cwel_compareitemstruct_get_ctlid (ptr: POINTER): INTEGER
		external
			"C macro signature (COMPAREITEMSTRUCT *): EIF_INTEGER use <wel_compare_item.h>"
		end

	cwel_compareitemstruct_get_hwnditem (ptr: POINTER): POINTER
		external
			"C macro signature (COMPAREITEMSTRUCT *): EIF_POINTER use <wel_compare_item.h>"
		end

	cwel_compareitemstruct_get_itemid1 (ptr: POINTER): INTEGER
		external
			"C macro signature (COMPAREITEMSTRUCT *): EIF_INTEGER use <wel_compare_item.h>"
		end

	cwel_compareitemstruct_get_itemdata1 (ptr: POINTER): POINTER
		external
			"C macro signature (COMPAREITEMSTRUCT *): EIF_POINTER use <wel_compare_item.h>"
		end

	cwel_compareitemstruct_get_itemid2 (ptr: POINTER): INTEGER
		external
			"C macro signature (COMPAREITEMSTRUCT *): EIF_INTEGER use <wel_compare_item.h>"
		end

	cwel_compareitemstruct_get_itemdata2 (ptr: POINTER): POINTER
		external
			"C macro signature (COMPAREITEMSTRUCT *): EIF_POINTER use <wel_compare_item.h>"
		end

	cwel_compareitemstruct_get_dwlocaleid (ptr: POINTER): INTEGER
		external
			"C macro signature (COMPAREITEMSTRUCT *): EIF_INTEGER use <wel_compare_item.h>"
		end

note
	copyright:	"Copyright (c) 1984-2012, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
