﻿note
	description: "COM GUID routines"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2017-04-13 15:30:09 +0000 (Thu, 13 Apr 2017) $"
	revision: "$Revision: 100173 $"

class
	ECOM_GUID_ROUTINES

feature -- Status report

	is_valid_guid_string (s: READABLE_STRING_GENERAL): BOOLEAN
			-- Is `s' a valid GUID?
		require
			valid_string: s /= Void
		do
			Result := s.count = 38 and then
						s.item (1) = '{' and
						is_hexas (s.substring (2,9)) and
						s.item (10) = '-' and
						is_hexas (s.substring (11,14)) and
						s.item (15) = '-' and
						is_hexas (s.substring (16,19)) and
						s.item (20) = '-' and
						is_hexas (s.substring (21,24)) and
						s.item (25) = '-' and
						is_hexas (s.substring (26,37)) and
						s.item (38) = '}'
		end

feature {NONE} -- Implementation

	is_hexas (s: READABLE_STRING_GENERAL): BOOLEAN
			-- Is `s' hexadecimal?
		require
			valid_string: s /= Void
		local
			i: INTEGER
		do
			from
				i := 1
				Result := True
			until
				i > s.count or not Result
			loop
				Result := s [i].is_hexa_digit
				i := i + 1
			end
		end

note
	copyright:	"Copyright (c) 1984-2017, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
