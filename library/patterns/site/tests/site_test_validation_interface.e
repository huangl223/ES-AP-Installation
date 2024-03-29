note
	description: "[

		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2011-11-22 05:25:20 +0000 (Tue, 22 Nov 2011) $"
	revision: "$Revision: 87934 $"

class
	SITE_TEST_VALIDATION_INTERFACE

inherit
	SITE_TEST_INTERFACE_BASIC
		redefine
			is_valid_site
		end

feature -- Status report

	is_valid_site (a_site: detachable SITE_TEST_OBJECT): BOOLEAN
			-- <Precursor>
		do
			if Precursor (a_site) and then attached {SITE_TEST_VALIDATION_OBJECT} a_site as l_site then
				Result := l_site.is_valid_object
			end
		ensure then
			is_valid_object: Result implies attached {SITE_TEST_VALIDATION_OBJECT} a_site as l_site
		end

;note
	copyright:	"Copyright (c) 1984-2011, Eiffel Software"
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
