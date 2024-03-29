note
	description: "Summary description for {XML_STRING_8_OUTPUT_STREAM}."
	date: "$Date: 2013-05-20 23:15:17 +0000 (Mon, 20 May 2013) $"
	revision: "$Revision: 92557 $"

class
	XML_STRING_8_OUTPUT_STREAM

inherit
	XML_CHARACTER_8_OUTPUT_STREAM

create
	make, make_empty

feature {NONE} -- Initialization

	make_empty
			-- Create a blank stream.
		do
			make ({STRING_8} "")
		end

	make (a_string: like string)
			-- Create current stream for file `a_string'
		require
			a_string_attached: a_string /= Void
		do
			string := a_string
		ensure
			shared: string = a_string
		end

feature -- Status report

	string: STRING_8
			-- Target for the stream

feature -- Status report

	is_open_write: BOOLEAN =True

feature -- Basic operation

	flush
			-- Flush buffered data to disk.
		do
		end

feature -- Output

	put_character_8 (c: CHARACTER_8)
		do
			string.append_character (c)
		end

	put_string_8 (a_string: READABLE_STRING_8)
			-- Write `a_string' to output stream.
		do
			string.append (a_string)
		end

invariant
	string_attached: string /= Void

note
	copyright: "Copyright (c) 1984-2012, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
