note
	description: "[
					String used to read 2 byte Unicode strings from database.
					Note that we use UTF-8 in the client to send Unicode to the database.
					So we don't use this to send string, we use C_STRING instead.
					]"
	date: "$Date: 2015-02-03 22:14:33 +0000 (Tue, 03 Feb 2015) $"
	revision: "$Revision: 96577 $"

class
	SYBASE_SQL_STRING

inherit
	SQL_ABSTRACT_STRING

create
	make,
	make_empty,
	make_by_pointer,
	make_by_pointer_and_count,
	make_shared_from_pointer,
	make_shared_from_pointer_and_count,
	own_from_pointer,
	own_from_pointer_and_count

feature -- Measurement

	character_size: INTEGER = 2
			-- Size of a character

feature {NONE} -- Implementation

	c_strlen (ptr: POINTER): INTEGER
			-- Number of characters.
		external
			"C inline use %"sybase.h%""
		alias
			"return TXTLEN($ptr);"
		end

end
