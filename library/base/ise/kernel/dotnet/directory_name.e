﻿note
	description:
		"Directory name abstraction"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2017-03-28 12:36:24 +0000 (Tue, 28 Mar 2017) $"
	revision: "$Revision: 100064 $"

class DIRECTORY_NAME

inherit
	PATH_NAME

create
	make, make_from_string

create {DIRECTORY_NAME}
	string_make

feature -- Status report

	is_valid: BOOLEAN
			-- Is the directory name valid?
		do
			Result := True
		end

feature {NONE} -- Implementation

	new_string (n: INTEGER): like Current
			-- New instance of current with space for at least `n' characters.
		do
			create Result.string_make (n)
		end

note
	library:	"EiffelBase: Library of reusable components for Eiffel."
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
