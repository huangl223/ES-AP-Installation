﻿note
	description: "Automation interface."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2017-04-13 17:28:51 +0000 (Thu, 13 Apr 2017) $"
	revision: "$Revision: 100180 $"

class
	ECOM_AUTOMATION_INTERFACE

inherit
	ECOM_QUERIABLE

create
	make_from_pointer,
	make_from_other

feature {NONE} -- Initialization

	make_from_pointer (other_pointer: POINTER)
			-- Create interface from other interface pointer
		do
			initializer := create_wrapper (other_pointer)
			item := ccom_item (initializer)
		end

feature {NONE} -- Implementation

	create_wrapper (a_pointer: POINTER): POINTER
			-- Create C++ wrapper
		do
			Result := ccom_create_wrapper (a_pointer)
		end

	delete_wrapper
			-- Delete C++ wrapper
		do
			ccom_delete_wrapper (initializer)
		end

feature {NONE} -- External

	ccom_create_wrapper (a_interface_ptr: POINTER): POINTER
		external
			"C++ [new E_automation_interface %"E_automation_interface.h%"](IDispatch *)"
		end

	ccom_delete_wrapper (cpp_obj: POINTER)
		external
			"C++  [delete E_automation_interface %"E_automation_interface.h%"]()"
		end

	ccom_item (cpp_obj: POINTER): POINTER
		external
			"C++ [E_automation_interface %"E_automation_interface.h%"]():EIF_POINTER"
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
