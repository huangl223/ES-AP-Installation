note
	description: "Reference equality testers"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2013-05-20 23:15:17 +0000 (Mon, 20 May 2013) $"
	revision: "$Revision: 92557 $"

class
	REFERENCE_EQUALITY_TESTER [G -> detachable ANY]

inherit
	EQUALITY_TESTER [G]
		redefine
			test
		end

feature -- Status report

	test (v, u: detachable G): BOOLEAN
			-- Are `v' and `u' the same reference?
		do
			Result := v = u
		end

note
	copyright: "Copyright (c) 1984-2011, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
