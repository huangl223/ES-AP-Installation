note
	description: "A command which executes a list of commands."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2009-02-24 23:44:31 +0000 (Tue, 24 Feb 2009) $"
	revision: "$Revision: 77298 $"

class
	WEL_COMMAND_LIST

inherit
	WEL_COMMAND
		undefine
			copy, is_equal
		end

	LINKED_LIST [WEL_COMMAND_EXEC]

create
	make

feature -- Element change

	add_command (command: WEL_COMMAND; argument: ANY)
			-- Add `command' with `argument' to list of commands.
		local
			exec: WEL_COMMAND_EXEC
		do
			create exec.make (command, argument)
			extend (exec)
		end

	remove_command (command: WEL_COMMAND; argument: detachable ANY)
			-- Remove all `command' with `argument' from the list of commands.
		require
			command_not_void: command /= Void
		do
			from
				start
			until
				after
			loop
				if item.command = command and then
					equal (item.argument, argument) then
					remove
				else
					forth
				end
			end
		end

feature -- Execution

	execute (argument: detachable ANY)
			-- Execute list of commands
		do
			from
				start
			until
				after
			loop
				item.command.set_message_information (message_information)
				item.command.execute (item.argument)
				forth
			end
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




end -- class WEL_COMMAND_LIST

