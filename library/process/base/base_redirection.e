note
	description: "Definition of some constants used in process launcher."
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date: 2016-10-17 10:22:28 +0000 (Mon, 17 Oct 2016) $"
	revision: "$Revision: 99303 $"

class
	BASE_REDIRECTION

feature -- Access

	no_redirection: INTEGER = 0
	to_file: INTEGER = 1
	to_stream: INTEGER = 2
	to_same_as_output: INTEGER = 3

feature -- Status report

	is_valid_redirection (v: like no_redirection): BOOLEAN
			-- Is `v' a known redirection constant?
		do
			inspect v
			when
				no_redirection,
				to_file,
				to_stream,
				to_same_as_output
			then
				Result := True
			else
			end
		end

;note
	copyright: "Copyright (c) 1984-2016, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 5949 Hollister Ave., Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
end
