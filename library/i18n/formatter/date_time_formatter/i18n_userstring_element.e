note
	description: "Formatting element that consists of a constant string"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2013-05-20 23:15:17 +0000 (Mon, 20 May 2013) $"
	revision: "$Revision: 92557 $"

class
	I18N_USERSTRING_ELEMENT

inherit
	I18N_FORMATTING_ELEMENT

create {I18N_FORMAT_STRING_PARSER}
	make

feature {NONE} -- Initialization

	make (a_string: READABLE_STRING_GENERAL)
			-- set the `user_string'
		require
			a_string_not_void: a_string /= Void
		do
			user_string := a_string.as_string_32
		end

feature -- Output

	filled (a_date: DATE; a_time: TIME): STRING_32
 			-- Return the `user_string'
 		do
			Result := user_string
 		end

feature {NONE} -- Implementation

	user_string: STRING_32

invariant
	correct_user_string: user_string /= Void

note
	library:   "Internationalization library"
	copyright: "Copyright (c) 1984-2009, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
