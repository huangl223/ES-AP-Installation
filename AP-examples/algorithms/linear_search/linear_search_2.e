note
	description: "Linear search in integer arrays."

class
	LINEAR_SEARCH_2

feature -- Basic operations

	linear_search (a: SIMPLE_ARRAY [INTEGER]; value: INTEGER): INTEGER
			-- Index of `value' in `a' using linear search starting from end of array.
		require
			array_size: 2 <= a.count and a.count <= 10
		do
			from
				Result := 1
			invariant
				result_in_bound: 1 <= Result and Result <= a.count + 1
				not_present_so_far: across 1 |..| (Result - 1) as i all a.sequence [i] /= value end
			until
				Result = a.count or else a [Result] = value
			loop
				Result := Result + 1
			variant
				a.count - Result + 1
			end
		ensure
			result_in_bound: 1 <= Result and Result <= a.count + 1
			present: a.sequence.has (value) = (Result <= a.count)
			found_if_present: (Result <= a.count) implies a.sequence [Result] = value
			first_from_front: across 1 |..| (Result - 1) as i all a.sequence [i] /= value end
		end

end
