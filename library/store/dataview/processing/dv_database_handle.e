note
	description: "Objects that enables to set default values%
			%for DB_TABLE_COMPONENT without creating an instance%
			%of the class."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2015-12-17 13:34:17 +0000 (Thu, 17 Dec 2015) $"
	revision: "$Revision: 98279 $"

class
	DV_DATABASE_HANDLE

create
	make_for_settings

feature -- Initialization

	make_for_settings
			-- Give access.
		do
		end

feature -- Status report

	database_handler_set: BOOLEAN
			-- Is a database handler set?
		do
			Result := database_handler_cell.item /= Void
		end

feature -- Access

	database_handler: ABSTRACT_DB_TABLE_MANAGER
			-- Interface with the database.
		require
			database_handler_set: database_handler_set
		do
			check attached database_handler_cell.item as l_item then
				Result := l_item
			end
		end

	basic_message_handler (message: STRING)
			-- Display `message' on standard output.
		do
			io.putstring (message)
		end

	basic_confirmation_handler (message: STRING; action_to_confirm: PROCEDURE)
			-- Execute `action_to_confirm' without confirmation.
		do
			action_to_confirm.call ([])
		end

feature -- Basic operations

	set_database_handler (db_handler: ABSTRACT_DB_TABLE_MANAGER)
			-- Set `db_handler' to
			-- `database_handler'.
		do
			database_handler_cell.put (db_handler)
		end

feature {NONE} -- Implementation

	database_handler_cell: CELL [detachable ABSTRACT_DB_TABLE_MANAGER]
			-- Default Interface with the database.
		once
			create Result.put (Void)
		ensure
			Result /= Void
		end

note
	copyright:	"Copyright (c) 1984-2014, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"





end -- class DV_DATABASE_HANDLE


