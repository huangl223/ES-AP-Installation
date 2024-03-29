﻿note
	description: "Tables whose keys are integers in a contiguous interval"
	library: "Free implementation of ELKS library"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	names: indexable, access;
	access: index, membership;
	contents: generic;
	date: "$Date: 2017-04-21 15:08:58 +0000 (Fri, 21 Apr 2017) $"
	revision: "$Revision: 100246 $"

deferred class READABLE_INDEXABLE [G]

inherit
	ITERABLE [G]

feature -- Access

	item alias "[]" (i: INTEGER): G
			-- Entry at position `i'.
		require
			valid_index: valid_index (i)
		deferred
		end

	new_cursor: INDEXABLE_ITERATION_CURSOR [G]
			-- <Precursor>
		do
			create {READABLE_INDEXABLE_ITERATION_CURSOR [G]} Result.make (Current)
			Result.start
		end

feature -- Measurement

	lower: INTEGER
			-- Minimum index.
		deferred
		end

	upper: INTEGER
			-- Maximum index.
		deferred
		end

	index_set: INTEGER_INTERVAL
			-- Range of acceptable indexes.
		obsolete "Use `lower' and `upper' instead. [2017-05-31]"
		do
			create Result.make (lower, upper)
		ensure
			not_void: Result /= Void
			empty_if_not_in_order: (lower > upper) implies Result.is_empty
			same_lower_if_not_empty: (lower <= upper) implies Result.lower = lower
			same_upper_if_not_empty: (lower <= upper) implies Result.upper = upper
		end

feature -- Status report

	valid_index (i: INTEGER): BOOLEAN
			-- Is `i' a valid index?
		deferred
		ensure
			only_if_in_index_set: Result implies (lower <= i and i <= upper)
		end

invariant
	consistent_boundaries: lower <= upper or else lower = upper + 1

note
	copyright: "Copyright (c) 1984-2017, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
