﻿note
	description: "[
		The Cocoa implementation of the dynamic API loader {DYNAMIC_API_I}.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2019-08-16 17:46:32 +0000 (Fri, 16 Aug 2019) $"
	revision: "$Revision: 103418 $"

class
	DYNAMIC_API_LOADER

inherit
	DYNAMIC_API_LOADER_I

feature -- Status report

	is_dynamic_library_supported: BOOLEAN
			-- <Precursor>
		do
			Result := False
		end

feature -- Query

	api_pointer (a_hnd: POINTER; a_api_name: READABLE_STRING_8): POINTER
			-- <Precursor>
		do
			-- fixme: not implemented
		end

feature -- Basic operations

	load_library (a_name: READABLE_STRING_GENERAL; a_version: detachable READABLE_STRING_GENERAL): POINTER
			-- <Precursor>
		local
			l_fn: PATH
		do
			create l_fn.make_from_string (a_name)
			if attached a_version then
				l_fn := l_fn.appended_with_extension (a_version)
			end
			Result := load_library_from_path (l_fn.appended_with_extension (once "dylib").name)
		end

	load_library_from_path (a_path: READABLE_STRING_GENERAL): POINTER
			-- <Precursor>
		do
			-- fixme: not implemented
		end

	unload_library (a_hnd: POINTER)
			-- <Precursor>
		do
			-- fixme: not implemented
		end

note
	copyright:	"Copyright (c) 1984-2019, Eiffel Software and others"
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
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
