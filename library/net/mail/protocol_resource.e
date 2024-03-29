note
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date: 2008-12-29 20:27:11 +0000 (Mon, 29 Dec 2008) $"
	revision: "$Revision: 76420 $"

deferred class
	PROTOCOL_RESOURCE

inherit
	EMAIL_RESOURCE

feature -- Basic operations

	initiate_protocol
			-- initiate the protocol with the server.
		deferred
		ensure
			protocol_initiated: is_initiated
		end

	close_protocol
			-- Close the protocol.
		require
			is_initiated: is_initiated
		deferred
		ensure
			protocol_not_initiated: not is_initiated
		end

feature -- Implementation (EMAIL_RESOURCE)

	can_be_sent: BOOLEAN = False
		-- Can a protocol resource be send?

	can_be_received: BOOLEAN = False;
		-- Can a protocol be received?

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




end -- class PROTOCOL_RESOURCE

