note
	description: "[
			Case-insensitive string equality testers
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2013-05-20 23:15:17 +0000 (Mon, 20 May 2013) $"
	revision: "$Revision: 92557 $"

class
	KL_CASE_INSENSITIVE_STRING_EQUALITY_TESTER_A [G -> READABLE_STRING_GENERAL]

inherit
	KL_STRING_EQUALITY_TESTER_A [G]
		redefine
			is_case_sensitive,
			test
		end

feature -- Status report

	is_case_sensitive: BOOLEAN assign set_is_case_sensitive
			-- <Precursor>

feature -- Status setting

	set_is_case_sensitive (a_cs: like is_case_sensitive)
			-- Sets case sensitivity checking status.
			--
			-- `a_cs': True to use case-sensitive comparison; False otherwise.
		do
			is_case_sensitive := a_cs
		ensure
			is_case_sensitive_set: is_case_sensitive = a_cs
		end

feature -- Query

	test (v, u: attached G): BOOLEAN
			-- <Precursor>
		do
			if is_case_sensitive then
				Result := Precursor (v, u)
			else
				Result := v.is_case_insensitive_equal (u)
			end
		end

;note
	copyright:	"Copyright (c) 1984-2012, Eiffel Software and others"
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
