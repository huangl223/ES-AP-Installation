note
	description: "Temporal intervals"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2009-05-11 20:34:43 +0000 (Mon, 11 May 2009) $"
	revision: "$Revision: 78615 $"

deferred class DURATION inherit

	PART_COMPARABLE

	GROUP_ELEMENT
		undefine
			is_equal
		end

feature -- Status report

	is_positive: BOOLEAN
			-- Is duration positive?
		deferred
		end

	is_negative: BOOLEAN
			-- Is duration negative?
		do
			Result := not is_positive and not is_zero
		end

	is_zero: BOOLEAN
			-- Is duration zero?
		do
			Result := equal (Current, zero)
		end

feature -- Element change

	identity alias "+": like Current
			-- Unary plus
		do
			Result := deep_twin
		end

	minus alias "-" (other: like Current): like Current
			-- Difference with `other'
		do
			Result := Current + -other
		end

invariant

	sign_correctness: is_positive xor is_negative xor is_zero

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 5949 Hollister Ave., Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class DURATION


