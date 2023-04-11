note
	description: "Mapping between Objective C basic data type to Eiffel type."
	date: "$Date: 2013-05-20 23:15:17 +0000 (Mon, 20 May 2013) $"
	revision: "$Revision: 92557 $"

class
	NS_OBJECT_BASIC_TYPE

feature -- Basic types

	ns_uinteger: NATURAL_64
			-- Type of `NSUInteger' for Current compilation
		do
		end

	ns_integer: INTEGER_64
			-- Type of `NSInteger' for Current compilation
		do
		end

	ns_time_interval: REAL_64
			-- Type of `NsTimeInterval' for Current compilation
		do
		end

	cg_float: REAL_64
			-- Type of `CGFloat' for Current compilation
		do
		end

feature -- Conversion

	to_ns_integer (a_int: INTEGER): like ns_integer
			-- Convert `a_int' to the expected data type of `ns_integer'.
		do
			Result := a_int
		end

	to_ns_uinteger (a_int: INTEGER): like ns_uinteger
			-- Convert `a_int' to the expected data type of `ns_uinteger'.
		require
			a_int_valid: a_int >= 0
		do
			Result := a_int.to_natural_64
		end

end
