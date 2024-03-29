note

	description:

		"Equality testers"

	library: "Gobo Eiffel Kernel Library"
	copyright: "Copyright (c) 1999-2010, Eric Bezault and others"
	license: "MIT License"
	date: "$Date: 2013-05-20 23:15:17 +0000 (Mon, 20 May 2013) $"
	revision: "$Revision: 92557 $"

class KL_EQUALITY_TESTER_A [G -> detachable ANY]

inherit
	ANY -- Needed for SE 2.1b1.

	KL_EQUALITY_TESTER [detachable G]
		rename
			test as internal_test
		redefine
			internal_test
		end

	KL_IMPORTED_ANY_ROUTINES

feature -- Status report

	test (v, u: detachable G): BOOLEAN
			-- Are `v' and `u' considered equal?
			-- (Use `equal' by default.)
		do
			Result := ANY_.equal_objects (v, u)
		end

feature {NONE} -- Status report

	frozen internal_test (v, u: detachable G): BOOLEAN
			-- <Precursor>
		do
			if v ~ u then
				Result := True
			elseif v = Void then
				Result := False
			elseif u = Void then
				Result := False
			else
				Result := test (v, u)
			end
		end

end
