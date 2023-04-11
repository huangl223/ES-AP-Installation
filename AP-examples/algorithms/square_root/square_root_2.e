note
    description: "[
                  Postcondition valid_result may be violated.
                  ]"

class
	SQUARE_ROOT_2

feature
	square_root (n: INTEGER): TUPLE [x: INTEGER; y: INTEGER]
			-- `x' and `y' are two approximate square roots of `n'
		require
			valid_n: n >= 0
		local
			x1, x2, mid: INTEGER
		do
			from
				x1 := 0
				x2 := n
			-- invariant
				-- valid_result: (x1 = x2 and x1 * x1 = n) or (x1 < x2 and x1 * x1 < n and x2 * x2 >= n)
			until
				x2 - x1 <= 1 or x1 = x2
			loop
				mid := (x1 + x2) // 2 -- integer division
				if mid * mid = n then
					x1 := mid
					x2 := mid
				else
					if mid * mid < n then
						x1 := mid
					else
						x2 := mid
					end
				end
			variant
				v1: x2 - x1
			end
			Result := [x1, x2]
		ensure
			valid_result: (Result.x = Result.y and Result.x * Result.x = n)
				or (Result.x + 1 = Result.y and Result.x * Result.x < n and Result.y * Result.y >= n)
		end

end
