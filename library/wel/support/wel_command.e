note
	description: "General notion of command. To write an actual command %
		%inherit from this class and implement the `execute' feature."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2009-02-24 23:44:31 +0000 (Tue, 24 Feb 2009) $"
	revision: "$Revision: 77298 $"

deferred class
	WEL_COMMAND

feature -- Access

	message_information: detachable WEL_MESSAGE_INFORMATION
			-- Information associated to the message

feature -- Execution

	execute (argument: detachable ANY)
			-- Execute the command with `argument'.
		deferred
		end

feature -- Element change

	set_message_information (mi: detachable WEL_MESSAGE_INFORMATION)
			-- Set `message_information' with `mi'.
		do
			message_information := mi
		ensure
			message_information_set: message_information = mi
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




end -- class WEL_COMMAND

