note
	description: "Implementation of IRootStorage interface"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2008-12-29 20:27:11 +0000 (Mon, 29 Dec 2008) $"
	revision: "$Revision: 76420 $"

class
	ECOM_ROOT_STORAGE

inherit
	ECOM_QUERIABLE

create
	make_from_other,
	make_from_pointer

feature {NONE}  -- Initialization

	make_from_pointer (cpp_obj: POINTER)
			-- Make from pointer
		do
			initializer := ccom_create_c_iroot_storage(cpp_obj)
			item := ccom_item (initializer)
		end

feature -- Basic Operations

	swith_to_file (a_name: STRING)
			-- Copy current file associated with storage object 
			-- to new file `a_name'. New file is then used for storage 
			-- object and any uncommitted changes.
		require
			non_void_name: a_name /= Void
			valid_name: not a_name.is_empty
		local
			l_string: WEL_STRING
		do
			create l_string.make (a_name)
			ccom_switch_to_file (initializer, l_string.item)
		end

feature {NONE} -- Implementation

	delete_wrapper
			-- delete structure
		do
			ccom_delete_c_iroot_storage (initializer);
		end

feature {NONE} -- Externals

	ccom_create_c_iroot_storage(a_pointer: POINTER): POINTER
		external
			"C++ [new E_IRootStorage %"E_IRootStorage.h%"](IUnknown *)"
		end

	ccom_delete_c_iroot_storage (cpp_obj: POINTER)
		external
			"C++ [delete E_IRootStorage %"E_IRootStorage.h%"]()"
		end

	ccom_item (cpp_obj: POINTER): POINTER
		external
			"C++ [E_IRootStorage %"E_IRootStorage.h%"](): EIF_POINTER"
		end

	ccom_switch_to_file (cpp_obj: POINTER; name: POINTER)
		external
			"C++ [E_IRootStorage %"E_IRootStorage.h%"](EIF_POINTER)"
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




end -- class ECOM_ROOT_STORAGE

