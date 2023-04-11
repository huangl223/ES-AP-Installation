note
	description: "Summary description for {P_INTERNAL}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	P_INTERNAL

inherit
	INTERNAL

feature

	set_integer_32_field_ (name: STRING_32; object: ANY; value: INTEGER_32)
			-- Set integer value of an object field
		local
			i: INTEGER
		do
			from
				i := 1
			until
				field_name (i, object).same_string (name.to_string_8) or else i > field_count (object)
			loop
				i := i + 1
			end

			if i <= field_count (object) then
				set_integer_32_field (i, object, value)
			end
		ensure
			instance_free: class
		end

	set_integer_field_ (name: STRING_32; object: ANY; value: INTEGER)
			-- Set integer value of an object field
		local
			i: INTEGER
		do
			from
				i := 1
			until
				field_name (i, object).same_string (name.to_string_8) or else i > field_count (object)
			loop
				i := i + 1
			end

			if i <= field_count (object) then
				set_integer_field (i, object, value)
			end
		ensure
			instance_free: class
		end

	set_boolean_field_ (name: STRING_32; object: ANY; value: BOOLEAN)
			-- Set boolean value of an object field
		local
			i: INTEGER
		do
			from
				i := 1
			until
				field_name (i, object).same_string (name.to_string_8) or else i > field_count (object)
			loop
				i := i + 1
			end

			if i <= field_count (object) then
				set_boolean_field (i, object, value)
			end
		ensure
			instance_free: class
		end

end
