note
	description: "[
		Basic mathematical operations, single-precision.
		This class may be used as ancestor by classes needing its facilities
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2010-01-14 00:37:43 +0000 (Thu, 14 Jan 2010) $"
	revision: "$Revision: 82076 $"

class
	SINGLE_MATH

inherit
	MATH_CONST

feature -- Access

	log_2 (v: REAL_32): REAL_32
			-- Base 2 logarithm of `v'
		do
			Result := log (v) / log ({REAL_32} 2.0)
		end

	cosine (v: REAL_32): REAL_32
			-- Trigonometric cosine of radian `v' approximated
			-- in the range [-pi/4, +pi/4]
		do
			Result := {MATH}.cos (v).truncated_to_real
		end

	arc_cosine (v: REAL_32): REAL_32
			-- Trigonometric arccosine of `v'
		do
			Result := {MATH}.acos (v).truncated_to_real
		end

	sine (v: REAL_32): REAL_32
			-- Trigonometric sine of radian `v' approximated
			-- in range [-pi/4, +pi/4]
		do
			Result := {MATH}.sin (v).truncated_to_real
		end

	arc_sine (v: REAL_32): REAL_32
			-- Trigonometric arcsine of `v'
		do
			Result := {MATH}.asin (v).truncated_to_real
		end

	tangent (v: REAL_32): REAL_32
			-- Trigonometric tangent of radian `v' approximated
			-- in range [-pi/4, +pi/4]
		do
			Result := {MATH}.tan (v).truncated_to_real
		end

	arc_tangent (v: REAL_32): REAL_32
			-- Trigonometric arctangent of `v'
		do
			Result := {MATH}.atan (v).truncated_to_real
		end

	sqrt (v: REAL_32): REAL_32
			-- Square root of `v'
		do
			Result := {MATH}.sqrt (v).truncated_to_real
		end

	exp (v: REAL_32): REAL_32
			-- Exponential of `v'.
		do
			Result := {MATH}.exp (v).truncated_to_real
		end

	log (v: REAL_32): REAL_32
			-- Natural logarithm of `v'
		do
			Result := {MATH}.log (v).truncated_to_real
		end

	log10 (v: REAL_32): REAL_32
			-- Base 10 logarithm of `v'
		do
			Result := {MATH}.log_10 (v).truncated_to_real
		end

	floor (v: REAL_32): REAL_32
			-- Greatest integral value less than or equal to `v'
		do
			Result := {MATH}.floor (v).truncated_to_real
		end

	ceiling (v: REAL_32): REAL_32
			-- Least integral value greater than or equal to `v'
		do
			Result := {MATH}.ceiling (v).truncated_to_real
		end

	rabs (v: REAL_32): REAL_32
			-- Absolute of `v'
		do
			Result := {MATH}.abs_double (v).truncated_to_real
		end

note
	library:	"EiffelBase: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"



end -- class SINGLE_MATH



