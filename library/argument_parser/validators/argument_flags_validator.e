note
	description: "A command line switch flag validator that checks if all flags are know flags."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2018-12-18 18:07:47 +0000 (Tue, 18 Dec 2018) $"
	revision: "$Revision: 102628 $"

class
	ARGUMENT_FLAGS_VALIDATOR

inherit
	ARGUMENT_VALUE_VALIDATOR

create
	make

feature {NONE} -- Initialization

	make (a_flags: like flags; a_cs: like is_case_sensitive)
			-- Initializes validator for option flag.
			--
			-- `a_flags': The list of available, valid flags.
			-- `is_case_sensitive': True to indicate if the flags are case sensitive; False otherwise.
		require
			a_flags_attached: a_flags /= Void
			not_a_flags_is_empty: not a_flags.is_empty
		do
			flags := a_flags
			is_case_sensitive := a_cs
		ensure
			flags_set: flags ~ a_flags
			is_case_sensitive_set: is_case_sensitive = a_cs
		end

feature -- Access

	flags: LINEAR [CHARACTER]
			-- Available valid flag options.

feature -- Status report

	is_case_sensitive: BOOLEAN
			-- Indicates if flags are case sensitive.

feature {NONE} -- Validation

	validate_value (a_value: READABLE_STRING_8)
			-- <Precursor>
		local
			l_cs: BOOLEAN
			l_count: INTEGER
			l_valid: BOOLEAN
			l_invalid_flags: STRING
			l_flags: like flags
			c: CHARACTER
			i: INTEGER
		do
			create l_invalid_flags.make (a_value.count)
			l_cs := is_case_sensitive
			l_flags := flags
			l_count := a_value.count
			from i := 1 until i > l_count loop
				c := a_value.item (i)
				if l_cs or not c.is_alpha then
					l_valid := l_flags.has (c)
				else
					l_valid := l_flags.has (c.as_lower) or l_flags.has (c.as_upper)
				end
				if not l_valid then
					l_invalid_flags.append_character (c)
				end
				i := i + 1
			end
			if not l_invalid_flags.is_empty then
				invalidate_option ((create {STRING_FORMATTER}).format (e_invalid_flag, [l_invalid_flags]))
			end
		end

feature {NONE} -- Internationalization

	e_invalid_flag: STRING = "Flags '{1}' are not valid flags for this option."

invariant
	flags_attached: flags/= Void
	not_flags_is_empty: not flags.is_empty
	flags_contain_printable_character: flags.for_all (
		agent (ia_char: CHARACTER): BOOLEAN
			do Result := ia_char.is_printable end)

note
	copyright: "Copyright (c) 1984-2018, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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
