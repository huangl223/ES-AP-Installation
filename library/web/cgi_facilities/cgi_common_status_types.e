note
	description: "Common Status Types that may be returned to the browser."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2008-12-29 20:27:11 +0000 (Mon, 29 Dec 2008) $"
	revision: "$Revision: 76420 $"

class
	CGI_COMMON_STATUS_TYPES

feature -- Access

	success_status: INTEGER = 200

	no_response_status: INTEGER = 204

	document_moved_status: INTEGER = 301

	unauthorized_status: INTEGER = 401

	forbidden_status: INTEGER = 403

	not_found_status: INTEGER = 404

	internal_server_error_status: INTEGER = 500

	not_implemented_status: INTEGER = 501;

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




end -- class CGI_COMMON_STATUS_TYPES

