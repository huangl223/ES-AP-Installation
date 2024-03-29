note
	description: "Class which allows to access the files %
				% corresponding to the in/out data flow"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2009-02-04 00:40:37 +0000 (Wed, 04 Feb 2009) $"
	revision: "$Revision: 76955 $"

class
	CGI_IN_AND_OUT

inherit
	SHARED_STDIN
	SHARED_STDOUT
		rename
			stdout as output
		end

feature -- Access

	response_header: CGI_RESPONSE_HEADER
		once
			create Result.make
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class CGI_IN_AND_OUT

