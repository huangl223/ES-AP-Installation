note
	description: "[
		Invertible object with an internal + operation.

		Note: The model is that of a commutative group.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2009-05-11 20:34:43 +0000 (Mon, 11 May 2009) $"
	revision: "$Revision: 78615 $"

deferred class
	GROUP_ELEMENT

feature -- Access

	zero: like Current
			-- Neutral element for "+" and "-"
		deferred
		ensure
			result_exists: Result /= Void
		end

feature -- Basic operations

	plus alias "+" (other: like Current): like Current
			-- Sum with `other' (commutative)
		require
			other_exists: other /= Void
		deferred
		ensure
			result_exists: Result /= Void
			commutative: Result.is_equal (other + Current)
		end

	minus alias "-" (other: like Current): like Current
			-- Result of subtracting `other'
		require
			other_exists: other /= Void
		deferred
		ensure
			result_exists: Result /= Void
		end

	identity alias "+": like Current
			-- Unary plus
		deferred
		ensure
			result_exists: Result /= Void
			result_definition: Result.is_equal (Current)
		end

	opposite alias "-": like Current
			-- Unary minus
		deferred
		ensure
			result_exists: Result /= Void
			result_definition: (Result + Current).is_equal (zero)
		end

invariant

	neutral_addition: is_equal (Current + zero)
	self_subtraction: zero.is_equal (Current - Current)

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




end -- class GROUP_ELEMENT



