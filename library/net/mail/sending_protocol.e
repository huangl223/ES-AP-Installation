note
	description: "Objects that handle the sending of data"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "david"
	date: "$Date: 2013-12-04 01:09:18 +0000 (Wed, 04 Dec 2013) $"
	revision: "$Revision: 93617 $"

deferred class
	SENDING_PROTOCOL

inherit
	EMAIL_PROTOCOL

feature -- Basic operations

	send_mail
		-- Send resource.
		require
			connection_exists: is_connected
			connection_initiated: is_initiated
			valid_headers: memory_resource.can_be_sent
		deferred
		end

feature -- Implemantation (EMAIL_RESOURCE)

	can_send: BOOLEAN = True
		--Can a sending protocol send?

feature -- Access

	memory_resource: MEMORY_RESOURCE;
		-- Memory resource to be send

note
	copyright:	"Copyright (c) 1984-2013, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class SENDING_PROTOCOL

