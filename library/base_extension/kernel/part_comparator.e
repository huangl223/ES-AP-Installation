note
	description: "Partial order comparators"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2013-05-20 23:15:17 +0000 (Mon, 20 May 2013) $"
	revision: "$Revision: 92557 $"

deferred class
	PART_COMPARATOR [G]

feature -- Status report

	less_than (u, v: G): BOOLEAN
			-- Is `u' considered less than `v'?
		require
			u_not_void: u /= Void
			v_not_void: v /= Void
		deferred
		ensure
			asymmetric: Result implies not less_than (v, u)
		end

note
	copyright: "[
		Copyright (c) 1984-2009, Eiffel Software and others
		Copyright (c) 2000, Eric Bezault and others
		]"
	license: "[
		Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)
		MIT License (see http://www.eiffel.com/licensing/mit.txt)
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
