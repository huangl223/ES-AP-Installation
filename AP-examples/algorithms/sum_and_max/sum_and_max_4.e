note
	description: "[
			Loop invariant partial_sum_and_max violated at the loop entry.
		]"

class
	SUM_AND_MAX_4

feature

	sum_and_max (a: SIMPLE_ARRAY [INTEGER]): TUPLE [sum, max: INTEGER]
			-- Calculate sum and maximum of array `a'.
		require
			a_not_void: a /= Void
			natural_numbers: across 1 |..| a.count as ai all a.sequence [ai] >= 0 end
			array_not_empty: a.count > 0
		local
			i: INTEGER
			sum, max: INTEGER
		do
			from
				i := 1; max := a[1]; sum := a[1]
			invariant
				i_in_range: 1 <= i and i <= a.count + 1
				sum_and_max_not_negative: sum >= 0 and max >= 0
				partial_sum_and_max: sum <= (i - 1) * max
				max_so_far: across 1 |..| (i - 1) as ai all max >= a.sequence [ai] end

			until
				i > a.count
			loop
				if a [i] > max then
					max := a [i]
				end
				sum := sum + a [i]
				i := i + 1
			end
			Result := [sum, max]
		ensure
			sum_in_range: Result.sum <= a.count * Result.max
			is_maximum: across 1 |..| a.count as ai all Result.max >= a.sequence [ai] end
			modify()
		end

end
