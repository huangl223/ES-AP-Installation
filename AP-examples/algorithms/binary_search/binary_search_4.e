note
    description: "[
                  Loop invariant not_in_upper_part may not be maintained.
                  ]"

class
	BINARY_SEARCH_4

feature -- Basic operations

	binary_search (a: SIMPLE_ARRAY [INTEGER]; value: INTEGER): INTEGER
			-- Index of `value' in `a' using binary search. Return 0 if not found.
			-- https://en.wikipedia.org/wiki/Binary_search_algorithm#Iterative
		require
			a_sorted: across 1 |..| a.sequence.count as i all
						across 1 |..| a.sequence.count as j all
							i <= j implies a.sequence[i] <= a.sequence[j] end end
		     a_size_limit: a.count > 0 and a.count <= 10
		     a_element_value: across 1 |..| a.count as c all 0 < a.sequence[c] and a.sequence[c] <= 10 end
		local
			low, up, middle: INTEGER
		do
			from
				low := 1
				up := a.count + 1
			invariant
				low_and_up_range: 1 <= low and low <= up and up <= a.sequence.count + 1
				result_range: Result = 0 or 1 <= Result and Result <= a.sequence.count
				not_in_lower_part: across 1 |..| (low-1) as i all a.sequence[i] < value end
				not_in_upper_part: across up |..| a.sequence.count as i all value < a.sequence[i] end
				found: Result > 0 implies a.sequence[Result] = value
			until
				low >= up or Result > 0
			loop
				middle := low + ((up - low) // 2)
				if a[middle] < value then
					low := middle + 1
				elseif a[middle] >= value then
					up := middle
				else
					Result := middle
				end
			 variant
				(a.count - Result) + (up - low)
			end
		ensure
			result_range: 0 <= Result and Result <= a.count
			present: a.sequence.has (value) = (Result > 0)
			not_present: not a.sequence.has (value) = (Result = 0)
			found_if_present: Result > 0 implies a.sequence[Result] = value
		end

end
