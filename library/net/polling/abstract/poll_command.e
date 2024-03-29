note

	description:
		"A poll command for use with a medium poller."
	legal: "See notice at end of class.";

	status: "See notice at end of class.";
	date: "$Date: 2009-02-24 23:44:31 +0000 (Tue, 24 Feb 2009) $";
	revision: "$Revision: 77298 $"

deferred class

	POLL_COMMAND

feature -- Initalization

	make (s: like active_medium)
		require
			socket_open: s /= Void and then not s.is_closed
		do
			active_medium := s
		ensure
			socket_assigned: s = active_medium
		end

feature -- Access

	active_medium: IO_MEDIUM
			-- Medium which was polled

feature -- Basic operation

	execute (arg: detachable ANY)
			-- do the work of the command
		deferred
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




end -- class POLL_COMMAND

