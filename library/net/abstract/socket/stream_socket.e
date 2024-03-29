note

        description:
                "Connexion oriented socket."
	legal: "See notice at end of class.";

        status: "See notice at end of class.";
        date: "$Date: 2010-12-08 18:38:29 +0000 (Wed, 08 Dec 2010) $";
        revision: "$Revision: 85098 $"

deferred class

	STREAM_SOCKET

inherit

	SOCKET
		redefine
			support_storable
		end

feature -- Status report

	support_storable: BOOLEAN = True
			-- Can medium be used to store an Eiffel structure?

feature

	listen (queue: INTEGER)
			-- Listen on socket for at most `queue' connections.
		require
			socket_exists: exists
			address_attached: address /= Void
		deferred
		end

	accepted: detachable like Current
			-- Last accepted socket.

	accept
			-- Accept a new connection on listen socket.
			-- Accepted service socket available in `accepted'.
		require
			socket_exists: exists
			address_attached: address /= Void
		deferred
		ensure
			same_blocking_status: attached accepted as l_accepted implies l_accepted.is_blocking = is_blocking
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




end -- class STREAM_SOCKET

