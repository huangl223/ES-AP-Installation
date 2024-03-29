note
	description: "[
		Ancestor of all developer exceptions
		]"
	library: "Free implementation of ELKS library"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date: 2012-12-27 02:57:50 +0000 (Thu, 27 Dec 2012) $"
	revision: "$Revision: 92096 $"

class
	DEVELOPER_EXCEPTION

inherit
	EXCEPTION
		redefine
			code,
			tag
		end

feature -- Access

	frozen code: INTEGER
			-- Exception code
		do
			Result := {EXCEP_CONST}.developer_exception
		end

	tag: IMMUTABLE_STRING_32
		once
			create Result.make_from_string_8 ("Developer exception.")
		end

note
	copyright: "Copyright (c) 1984-2012, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
