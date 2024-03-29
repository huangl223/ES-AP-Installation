note
	description: "A command line switch file validator that checks if an integer is with a value range."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2013-05-20 23:15:17 +0000 (Mon, 20 May 2013) $"
	revision: "$Revision: 92557 $"

deferred class
	ARGUMENT_NUMERIC_RANGE_VALIDATOR [G -> {NUMERIC, COMPARABLE}]

inherit
	ARGUMENT_VALUE_VALIDATOR

feature {NONE} -- Initialization

	make (a_min: like min; a_max: like max)
			-- Initializes validator with a minimum and maximum value.
			--
			-- `a_min': Minimum, inclusive accepted value.
			-- `a_max': Maximum, inclusive accepted value.
		require
			a_min_less_than_a_max: a_min < a_max
		do
			min := a_min
			max := a_max
		ensure
			min_set: min = a_min
			max_set: max = a_max
		end

feature -- Access

	min: G
			-- Minimum accepted value.

	max: G
			-- Maximum accepted value.

feature {NONE} -- Internationalization

	e_not_within_range: IMMUTABLE_STRING_32
		once
			create Result.make_from_string_general ("'{1} is not within the range from {2} to {3}.'")
		end

	e_invalid_number: IMMUTABLE_STRING_32
		once
			create Result.make_from_string_general ("The specified value is not a valid number.")
		end

invariant
	min_less_than_max: min < max

;note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
