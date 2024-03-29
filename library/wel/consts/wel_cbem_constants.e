note
	description: "ComboBoxEx Message (CBEM) constants."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2013-11-20 01:13:35 +0000 (Wed, 20 Nov 2013) $"
	revision: "$Revision: 93464 $"

class
	WEL_CBEM_CONSTANTS

obsolete
	"Use WEL_COMBO_BOX_CONSTANTS instead."

feature -- Access

	Cbem_insertitem: INTEGER = 1035
			-- Inserts a new item in a ComboBoxEx.
			--
			-- Declared in Windows as CBEM_INSERTITEM

	Cbem_setimagelist: INTEGER = 1026
			-- Sets an image list for a ComboBoxEx control.
			--
			-- Declared in Windows as CBEM_SETIMAGELIST

	Cbem_getimagelist: INTEGER = 1027
			-- Retrieves the handle to an image list assigned
			-- to a ComboBoxEx control.
			--
			-- Declared in Windows as CBEM_GETIMAGELIST

	Cbem_getitem: INTEGER = 1037
			-- Retrieves item information for a given ComboBoxEx item.
			--
			-- Declared in Windows as CBEM_GETITEM

	Cbem_setitem: INTEGER = 1036
			-- Sets the attributes for an item in a ComboBoxEx control.
			--
			-- Declared in Windows as CBEM_SETITEM

	Cbem_deleteitem: INTEGER = 324
			-- Removes an item from a ComboBoxEx control.
			--
			-- Declared in Windows as CBEM_DELETEITEM

	Cbem_getcombocontrol: INTEGER = 1030
			-- Retrieves the handle to the child combo box control.
			--
			-- Declared in Windows as CBEM_GETCOMBOCONTROL

	Cbem_geteditcontrol: INTEGER = 1031
			-- Retrieves the handke to the edit control portion of
			-- a ComboBoxEc control.
			--
			-- Declared in Windows as CBEM_GETEDITCONTROL

	Cbem_setexstyle: INTEGER = 1032
			-- Sets extended styles within a ComboBoxEx control.
			--
			-- Declared in Windows as CBEM_SETEXSTYLE

	Cbem_getexstyle: INTEGER = 1033
			-- Retrieves the extended styles of a ComboBoxEx control.
			--
			-- Declared in Windows as CBEM_GETEXSTYLE

	Cbem_haseditchanged: INTEGER = 1034;
			-- Determines if the user has changed the contents of the
			-- ComboBoxEx edit control by typing.
			--
			-- Declared in Windows as CBEM_HASEDITCHANGED

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




end -- class WEL_CBEM_CONSTANTS

