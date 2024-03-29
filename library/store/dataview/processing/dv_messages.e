note
	description: "Objects that stores default messages."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2019-08-26 15:54:41 +0000 (Mon, 26 Aug 2019) $"
	revision: "$Revision: 103422 $"

deferred class
	DV_MESSAGES

feature -- Creation

	creation_done (table_name: STRING): STRING
			-- Table row creation on `table_name' successful message.
		do
			Result := "Database creation on table " + table_name + " done."
		end

	creation_confirmation (table_name: STRING): STRING
			-- Table row creation on `table_name' confirmation message.
		do
			Result := "Do you really want to create the " + table_name + " row?"
		end

feature -- Selection

	tablerows_selected (count: INTEGER): STRING
			-- Database selection carried out message. `count' table rows
			-- have been selected.
		local
			plural: STRING
		do
			if count > 1 then
				plural := "s"
			else
				plural := ""
			end
			Result := count.out + " table row" + plural + " selected."
		end

feature -- Update

	update_done (table_name: STRING): STRING
			-- Table row update on `table_name' successful message.
		do
			Result := "Database update on table " + table_name + " done."
		end

feature -- Deletion

	deletion_done (table_name: STRING): STRING
			-- Table row deletion on `table_name' successful message.
		do
			Result := "Database deletion on table " + table_name + " done."
		end

	deletion_confirmation (table_name: STRING): STRING
			-- Table row deletion on `table_name' confirmation message.
		do
			Result := "Do you really want to delete selected " + table_name + " row %Nfrom the database?"
		end

feature --

	retrieve_field_value (type: detachable STRING; name: READABLE_STRING_GENERAL): STRING
			-- Value of field with `name' and `type' retrieval failure message.
		do
			if type /= Void then
				Result := "Cannot retrieve " + type + " value for field '" + {UTF_CONVERTER}.utf_32_string_to_utf_8_string_8 (name) + "'."
			else
				Result := "Cannot retrieve for field '" + {UTF_CONVERTER}.utf_32_string_to_utf_8_string_8 (name) + "' of an unknown type."
			end
		end

	enter_field_value (type: detachable STRING; name: READABLE_STRING_GENERAL): STRING
			-- Value of field with `name' and `type' not valid message.
		do
			if type /= Void then
				Result := "Please enter a " + type + " value for field '" + {UTF_CONVERTER}.utf_32_string_to_utf_8_string_8 (name) + "'."
			else
				Result := "Please enter a value for field '" + {UTF_CONVERTER}.utf_32_string_to_utf_8_string_8 (name) + "' of an unknown type."
			end
		end

	type_not_recognized (name: READABLE_STRING_GENERAL): STRING
			-- Type of field with `name' not recognized message.
		do
			Result := "Field '" + {UTF_CONVERTER}.utf_32_string_to_utf_8_string_8 (name) + "' type not recognized."
		end

	wrong_date_format (name: READABLE_STRING_GENERAL): STRING
			-- Wrong date type format for field with `name' message.
		do
			Result := "Date format not valid for field: '"
					+ {UTF_CONVERTER}.utf_32_string_to_utf_8_string_8 (name) + "'.%NPlease see sample in field to make sure %
					%to enter a valid date. Please 'Refresh' to restore original value."
		end

	wrong_datetime_format (name: READABLE_STRING_GENERAL): STRING
			-- Wrong date & time type format for field with `name' message.
		do
			Result := "Date & time format not valid for field: '"
					+ {UTF_CONVERTER}.utf_32_string_to_utf_8_string_8 (name) + "'.%NPlease see sample in field to make sure %
					%to enter a valid date & time. Please 'Refresh' to restore original value."
		end

feature -- Window to select foreign key values for creation

	selection_window_title (table_name: STRING): STRING
			-- Selection window title.
		do
			Result := "Select a related " + table_name + " row:"
		end

	Undetermined_table_name: STRING
			-- Undetermined table name (use for `selection_window_title').
		do
			Result := "table"
		end

feature -- Combo box

	Empty_combo_item_label: STRING
			-- Label for an empty combo item value.
		do
			Result := "(Empty)"
		end

note
	copyright:	"Copyright (c) 1984-2019, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"


end -- class DV_MESSAGES


