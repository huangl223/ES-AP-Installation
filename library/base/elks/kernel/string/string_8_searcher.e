﻿note
	description: "[
		Helper to perform efficient search of a string in another one.
		Note: The algorithm used is the one described in Communications of the ACM,
			volume 33, number 8, August 1990, by Daniel M. Sunday. The fuzzy
			version was presented by Peter R. Sibbald in Communications of the
			ACM, volume 35, number 4, April 1992 (Technical Correspondance).
		]"
	library: "Free implementation of ELKS library"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date: 2017-03-28 12:36:24 +0000 (Tue, 28 Mar 2017) $"
	revision: "$Revision: 100064 $"

frozen class
	STRING_8_SEARCHER

inherit
	STRING_SEARCHER

create
	make

feature -- Access

	string_type: READABLE_STRING_8
			-- Type of strings `Current' manipulate to perform searches.
		do
			Result := ""
		end

	max_code_point_value: INTEGER = 255
			-- <Precursor>
			-- For STRING_8, it is limited to the number of characters in the extended ASCII character set.

feature -- Search

	substring_index_with_deltas (a_string: like string_type; a_pattern: READABLE_STRING_GENERAL; start_pos, end_pos: INTEGER): INTEGER
			-- Position of first occurrence of `a_pattern' at or after `start_pos' in `a_string'.
			-- 0 if there are no matches.
		local
			i, j, l_end_pos: INTEGER
			l_pattern_count: INTEGER
			l_matched: BOOLEAN
			l_deltas: like deltas
			l_area: SPECIAL [CHARACTER_8]
			l_area_lower: INTEGER
		do
			if a_string = a_pattern then
				if start_pos = 1 then
					Result := 1
				end
			else
				l_pattern_count := a_pattern.count
				check l_pattern_count_positive: l_pattern_count > 0 end
				from
					l_area := a_string.area
					l_area_lower := a_string.area_lower
					i := start_pos + l_area_lower
					l_deltas := deltas
					l_end_pos := end_pos + 1 + l_area_lower
				until
					i + l_pattern_count > l_end_pos
				loop
					from
						j := 0
						l_matched := True
					until
						j = l_pattern_count
					loop
						if l_area.item (i + j - 1).natural_32_code /= a_pattern.code (j + 1) then
								-- Mismatch, so we stop
							j := l_pattern_count - 1	-- Jump out of loop
							l_matched := False
						end
						j := j + 1
					end

					if l_matched then
							-- We got the substring
						Result := i - l_area_lower
						i := l_end_pos	-- Jump out of loop
					else
							-- Pattern was not found, shift to next location
						if i + l_pattern_count <= end_pos then
							i := i + l_deltas.item (l_area.item (i + l_pattern_count - 1).code)
						else
							i := i + 1
						end
					end
				end
			end
		end

	fuzzy_index (a_string: like string_type; a_pattern: READABLE_STRING_GENERAL; start_pos, end_pos, fuzzy: INTEGER): INTEGER
			-- Position of first occurrence of `a_pattern' at or after `start_pos' in
			-- `a_string' with 0..`fuzzy' mismatches between `a_string' and `a_pattern'.
			-- 0 if there are no fuzzy matches.
		local
			i, j, l_min_offset, l_end_pos: INTEGER
			l_pattern_count, l_nb_mismatched: INTEGER
			l_matched: BOOLEAN
			l_char_code: INTEGER
			l_deltas_array: like deltas_array
			l_area: SPECIAL [CHARACTER_8]
			l_area_lower: INTEGER
		do
			if fuzzy = a_pattern.count then
					-- More mismatches than the pattern length.
				Result := start_pos
			else
				if fuzzy = 0 then
					Result := substring_index (a_string, a_pattern, start_pos, end_pos)
				else
					initialize_fuzzy_deltas (a_pattern, fuzzy)
					l_deltas_array := deltas_array
					if l_deltas_array /= Void then
						from
							l_pattern_count := a_pattern.count
							l_area := a_string.area
							l_area_lower := a_string.area_lower
							i := start_pos + l_area_lower
							l_end_pos := end_pos + 1 + l_area_lower
						until
							i + l_pattern_count > l_end_pos
						loop
							from
								j := 0
								l_nb_mismatched := 0
								l_matched := True
							until
								j = l_pattern_count
							loop
								if l_area.item (i + j - 1).natural_32_code /= a_pattern.code (j + 1) then
									l_nb_mismatched := l_nb_mismatched + 1;
									if l_nb_mismatched > fuzzy then
											-- Too many mismatched, so we stop
										j := l_pattern_count - 1	-- Jump out of loop
										l_matched := False
									end
								end
								j := j + 1
							end

							if l_matched then
									-- We got the substring
								Result := i - l_area_lower
								i := l_end_pos	-- Jump out of loop
							else
								if i + l_pattern_count <= end_pos then
										-- Pattern was not found, compute shift to next location
									from
										j := 0
										l_min_offset := l_pattern_count + 1
									until
										j > fuzzy
									loop
										l_char_code := l_area.item (i + l_pattern_count - j - 1).code
										l_min_offset := l_min_offset.min (l_deltas_array.item (j).item (l_char_code))
										j := j + 1
									end
									i := i + l_min_offset
								else
									i := i + 1
								end
							end
						end
					end
					deltas_array := Void
				end
			end
		end

note
	copyright: "Copyright (c) 1984-2017, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
