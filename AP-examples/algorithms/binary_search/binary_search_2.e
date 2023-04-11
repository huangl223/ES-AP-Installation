note
    description: "[
                   Loop invariant not_in_lower_part may not be maintained.
                  ]"

class
	BINARY_SEARCH_2

feature -- Binary search

	binary_search(a: V_ARRAY [INTEGER]; value: INTEGER): INTEGER
			-- Index of `value' in `a' using binary search. Return 0 if not found.
			-- https://en.wikipedia.org/wiki/Binary_search_algorithm#Iterative
		note
			status: impure
		require
			no_overflow: a.count < {INTEGER}.max_value
			a_sorted: across 1 |..| a.count as i all
						across 1 |..| a.count as j all
							i <= j implies a.sequence[i] <= a.sequence[j] end end
			a_size_limit: a.count > 0 and a.count <= 10
			a_valid_bound: a.lower < a.upper and a.lower = 1

		local
			low, up, middle: INTEGER
		do
			from
				low := a.lower
				up := a.upper + 1
				Result := a.lower - 1
			invariant
				low_and_up_range: a.lower <= low and low <= up and up <= a.upper + 1
				valid_bound: a.lower < a.upper
				result_range: Result = a.lower - 1 or a.lower <= Result and Result <= a.upper
				not_in_lower_part: across 1 |..| (low - a.lower) as i all a.sequence[i] < value end
				not_in_upper_part: across (up - a.lower + 1) |..| a.sequence.count as i all value < a.sequence[i] end
				found: (Result >= a.lower and Result <= a.upper) implies (a.sequence[Result - a.lower + 1] = value)
			until
				low >= up or Result >= a.lower
			loop
				middle := low + ((up - low) // 2)
				if a[middle] <= value then
					low := middle + 1
				elseif a[middle] > value then
					up := middle
				else
					Result := middle
				end
			 variant
				(a.upper - Result) + (up - low)
			end
		ensure
			present: a.sequence.has (value) = (Result >= a.lower and Result <= a.upper)
			not_present: not a.sequence.has (value) = (Result = a.lower - 1)
			found_if_present: (Result >= a.lower and Result <= a.upper) implies (a.sequence[Result - a.lower + 1] = value)
		end

end
