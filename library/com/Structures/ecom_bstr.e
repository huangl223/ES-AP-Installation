﻿note
	description: "Wrapper around BSTR."
	date: "$Date: 2017-05-02 04:16:21 +0000 (Tue, 02 May 2017) $"
	revision: "$Revision: 100302 $"

class
	ECOM_BSTR

inherit
	ECOM_WRAPPER

create
	make

feature -- Access

	string: detachable STRING_32
			-- Convert to string.
		do
			if item /= default_pointer then
				Result := (create {WEL_STRING}.share_from_pointer_and_count (item, count * character_32_bytes)).string
			end
		end

	count: INTEGER
			-- Character count
		do
			Result := c_sys_string_len (item)
		end

feature {NONE} -- Implementation

	memory_free
			-- Free BSTR
		do
			c_sys_free_string (item)
			item := default_pointer
		end

feature {NONE} -- Externals

	c_sys_free_string (a_item: POINTER)
			-- `SysFreeString' API
		external
			"C inline use <windows.h>, <OleAuto.h>"
		alias
			"SysFreeString((BSTR)$a_item)"
		end

	c_sys_string_len (a_item: POINTER): INTEGER
			-- `SysStringLen' API
		external
			"C inline use <windows.h>, <OleAuto.h>"
		alias
			"(EIF_INTEGER)SysStringLen((BSTR)$a_item)"
		end

note
	copyright:	"Copyright (c) 1984-2017, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
