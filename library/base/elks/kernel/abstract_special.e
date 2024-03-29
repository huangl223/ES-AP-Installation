﻿note
	description: "Ancestor of SPECIAL to perform queries on SPECIAL without knowing its actual generic type."
	library: "Free implementation of ELKS library"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date: 2017-04-15 12:05:54 +0000 (Sat, 15 Apr 2017) $"
	revision: "$Revision: 100207 $"

deferred class
	ABSTRACT_SPECIAL

inherit
	DEBUG_OUTPUT

feature -- Measurement

	count: INTEGER
			-- Count of special area.
		deferred
		ensure
			count_non_negative: Result >= 0
		end

	capacity: INTEGER
			-- Capacity of special area.
		deferred
		ensure
			count_non_negative: Result >= 0
		end

feature -- Status report

	valid_index (i: INTEGER): BOOLEAN
			-- Is `i' within the bounds of Current?
		deferred
		end

feature -- Output

	debug_output: STRING
			-- String that should be displayed in debugger to represent `Current'.
		do
			create Result.make (12)
			Result.append_string ("count=")
			Result.append_integer (count)
		end

invariant
	count_less_than_capacity: count <= capacity

note
	copyright: "Copyright (c) 1984-2017, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
