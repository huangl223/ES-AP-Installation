note
	description: "[
		Bridged test interface.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2014-01-17 19:50:59 +0000 (Fri, 17 Jan 2014) $"
	revision: "$Revision: 94051 $"

class
	BRIDGE_TEST_INTERFACE

inherit
	BRIDGE [BRIDGE_TEST_INTERFACE_I]

	BRIDGE_TEST_INTERFACE_I

feature -- Access

	name: READABLE_STRING_8
			-- <Precursor>
		do
			Result := bridge.name
		end

feature {NONE} -- Factory

	new_bridge: BRIDGE_TEST_INTERFACE_IMPL
			-- <Precursor>
		do
			create Result
		end

feature -- Constants

	windows_name: STRING = "Windows"
	unix_name: STRING = "*nix"

;note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
