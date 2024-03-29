note
	description: "Fields representing part of%
			%the content of a table row."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2014-01-15 18:27:37 +0000 (Wed, 15 Jan 2014) $"
	revision: "$Revision: 94004 $"

class
	DV_TABLEROW_FIELDS

inherit
	DV_COMPONENT

	DB_TABLES_ACCESS_USE

create
	make

feature -- Initialization

	make
			-- Initialize.
		do
			create field_list.make (1)
			create error_message.make_empty
		end

feature -- Status report

	can_be_activated: BOOLEAN
			-- Can the component be activated?
		do
			Result := table_description /= Void
		end

	is_activated: BOOLEAN
			-- Is component activated?

feature -- Basic Operations

	add_field, extend (ta_field: DV_TABLEROW_FIELD)
			-- Add `field' to structure.
		require
			not_void: ta_field /= Void
			not_activated: not is_activated
		do
			field_list.extend (ta_field)
		end

feature {DV_COMPONENT} -- Access

	table_description: detachable DB_TABLE_DESCRIPTION
			-- Description of table represented by component.

	updated_tablerow (default_tablerow: DB_TABLE): detachable DB_TABLE
			-- Displayed object with user changes. Fields unchanged are taken
			-- from `default_tablerow'.
			-- Updated table row if `is_update_valid'.	
		require
			is_activated: is_activated
			is_update_valid: is_update_valid
		local
			is_val: BOOLEAN
			td: detachable DB_TABLE_DESCRIPTION
		do
			Result := default_tablerow.twin
			td := Result.table_description
			from
				is_val := True
				field_list.start
			until
				not is_val or else field_list.after
			loop
				field_list.item.update_tablerow (td)
				is_val := field_list.item.is_update_valid
				if is_val then
					field_list.forth
				end
			end
			is_update_valid := is_val
			if not is_val then
				error_message := field_list.item.error_message
				Result := Void
			end
		end

feature {DV_COMPONENT} --  Status report

	is_update_valid: BOOLEAN
			-- Are values entered by the user valid?

	error_message: STRING
			-- Error message if values entered by the user
			-- are not valid.

feature {DV_COMPONENT} -- Basic operations

	set_table_description (td: DB_TABLE_DESCRIPTION)
			-- Set represented table description to `td'.
		require
			not_void: td /= Void
			not_activated: not is_activated
		do
			table_description := td
		end

	activate
			-- Activate component.
		do
			if attached table_description as l_table then
				from
					field_list.start
				until
					field_list.after
				loop
					field_list.item.set_table_description (l_table)
					field_list.item.activate
					field_list.forth
				end
				is_activated := True
			end
		end

	refresh (table_descr: DB_TABLE_DESCRIPTION)
			-- Refresh fields with values of `tr'.
		require
			is_activated: is_activated
 		do
			from
				field_list.start
			until
				field_list.after
			loop
				field_list.item.refresh (table_descr)
				field_list.forth
			end
		end

	clear
			-- Clear fields and make them insensitive.
		require
			is_activated: is_activated
		do
			from
				field_list.start
			until
				field_list.after
			loop
				field_list.item.clear
				field_list.forth
			end
		end

	enable_sensitive
			-- Make structure sensitive.
		do
			from
				field_list.start
			until
				field_list.after
			loop
				field_list.item.enable_sensitive
				field_list.forth
			end
		end

	disable_sensitive
			-- Make structure insensitive.
		do
			from
				field_list.start
			until
				field_list.after
			loop
				field_list.item.disable_sensitive
				field_list.forth
			end
		end

feature {NONE} -- Implementation

	field_list: ARRAYED_LIST [DV_TABLEROW_FIELD]
			-- List containing table row fields.

invariant
	
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

end -- class DV_TABLEROW_FIELDS
