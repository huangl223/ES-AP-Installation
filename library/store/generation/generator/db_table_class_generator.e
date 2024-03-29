note
	Description: "Objects that enable to create a class related%
			%to a specific database table from a template and%
			%a class description (class DB_REPOSITORY)."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	Date: "$Date: 2014-04-10 22:22:43 +0000 (Thu, 10 Apr 2014) $"
	Revision: "$Revision: 94822 $"
	Product: EiffelStore
	Database: All_Bases

deferred class
	DB_TABLE_CLASS_GENERATOR

inherit
	DB_CLASS_GENERATOR
		redefine
			generate_file
		end

feature -- Access

	generated_file_name: detachable STRING
			-- File name possibility for the generated file:
			-- maps the class name and has the ".e" extension.
		require
			is_ok: is_ok
		do
			Result := gfn
		end

feature -- Status report

	description_set: BOOLEAN
			-- Is table description set?
		do
			Result := table_description /= Void
		end

feature -- Basic operations

	set_table_description (a_table_description: DB_REPOSITORY)
			-- Set table description to map template to the database table.
		require
			not_void: a_table_description /= Void
			is_loaded_and_exists: a_table_description.exists
		do
			table_description := a_table_description
		ensure
			table_description_set: description_set
		end

	generate_file
			-- Generate file with table description and
			-- template file content.
		local
			class_name: STRING
			l_gfn: like gfn
		do
			Precursor
				-- implied by precursor's postcondition
			check attached gfc as l_gfc then
				class_name := table_description.repository_name.as_upper
				class_name.replace_substring_all (" ", "_")
				l_gfc.replace_substring_all (tags.upper_class_name, class_name)
				class_name.to_lower
				l_gfn := class_name + Class_file_extension
				gfn := l_gfn
				if l_gfn.has ('$') then
					l_gfn.replace_substring_all ("$", "")
				end
				l_gfc.replace_substring_all (tags.lower_class_name, class_name)
				to_initcap (class_name)
				l_gfc.replace_substring_all (tags.initcap_class_name, class_name)
	--			gfc.replace_substring_all (tags.Attribute_count, table_description.column_number.out)
			end
		end

feature {NONE} -- Implementation

	append_block (a_result_block, attribute_block: STRING; column_number: INTEGER)
			-- Replace tags in `attribute_block' with values of attribute in
			-- `column' (which is at `column_number').
			-- Append result to `a_result_block'.
		local
			attribute_name, tn: STRING
			mapped_item: STRING
			column: COLUMNS [DATABASE]
			l_column_name: detachable STRING
		do
			column := table_description.column_i_th (column_number)
			manage_type (column)
			if type_correspond then
				mapped_item := attribute_block.twin
				check attached column.column_name as l_name then
				 		-- FIXME: implied by ...bug?
					l_column_name := l_name
				end

				attribute_name := l_column_name.as_lower
				mapped_item.replace_substring_all (tags.Lower_attribute_name, attribute_name)
				to_initcap (attribute_name)
				mapped_item.replace_substring_all (tags.Initcap_attribute_name, attribute_name)
				attribute_name.to_upper
				mapped_item.replace_substring_all (tags.Upper_attribute_name, attribute_name)
				mapped_item.replace_substring_all (tags.Iterator, column_number.out)

					-- The value `column_id' is not properly set for Oracle.
		--		mapped_item.replace_substring_all (tags.Iterator, column.column_id.out)

				tn := type_name.twin
				mapped_item.replace_substring_all (tags.Upper_type_name, tn)
				tn.to_lower
				mapped_item.replace_substring_all (tags.Lower_type_name, tn)
				to_initcap (tn)
				mapped_item.replace_substring_all (tags.Initcap_type_name, tn)
				mapped_item.replace_substring_all (tags.Type_default_value, type_default_value)
				a_result_block.append (mapped_item)
			end
		end

	description_count: INTEGER
			-- Count of database entities (table or attribute) in description.
		do
			Result := table_description.column_number
		end

	Class_file_extension: STRING = ".e"
			-- Extension for an Eiffel class file.

	type_correspond: BOOLEAN
			-- Is current attribute block valid for last managed attribute column type?

	type_name: STRING
			-- Name (in uppercase) of last managed attribute column type.

	type_default_value: STRING
			-- Default value for last managed attribute column type.

	type_code: STRING
			-- Code of last managed attribute column type.

	manage_type (column: COLUMNS [DATABASE])
			-- Manage type of attribute in `column': set `type_correspond',
			-- `type_name' and `type_default_value'.
		do
			inspect column.eiffel_type
			when {DB_TYPES}.string_type then
				type_correspond := tags.has_string_type_option
				type_name := String_type_name
				type_default_value := String_type_default_value
			when {DB_TYPES}.integer_32_type then
				type_correspond := tags.has_integer_type_option
				type_name := Integer_type_name
				type_default_value := Integer_type_default_value
			when {DB_TYPES}.real_64_type then
				type_correspond := tags.has_double_type_option
				type_name := Double_type_name
				type_default_value := Integer_type_default_value
			when {DB_TYPES}.real_32_type then
				type_correspond := tags.has_double_type_option
				type_name := Double_type_name
				type_default_value := Double_type_default_value
			when {DB_TYPES}.date_type then
				type_correspond := tags.has_date_type_option
				type_name := Date_type_name
				type_default_value := Date_type_default_value
			when {DB_TYPES}.character_type then
				type_correspond := tags.has_character_type_option
				type_name := Character_type_name
				type_default_value := Character_type_default_value
			when {DB_TYPES}.boolean_type then
				type_correspond := tags.has_boolean_type_option
				type_name := Boolean_type_name
				type_default_value := Boolean_type_default_value
			end
		end

	gfn: detachable STRING
			-- `generated_file_name' implementation.

	table_description: DB_REPOSITORY
			-- Description of database table to map in class to generate.

	Integer_type_name: STRING = "INTEGER_32"
			-- Integer type name.

	Double_type_name: STRING = "REAL_64"
			-- Double type name.

	Boolean_type_name: STRING = "BOOLEAN"
			-- Boolean type name.

	Character_type_name: STRING = "CHARACTER"
			-- Character type name.

	String_type_name: STRING = "STRING_8"
			-- String type name.

	Date_type_name: STRING = "DATE_TIME"
			-- Date type name.

	Integer_type_default_value: STRING = "0"
			-- Integer type default_value.

	Double_type_default_value: STRING = "0.0"
			-- Double type default_value.

	Boolean_type_default_value: STRING = "False"
			-- Boolean type default_value.

	Character_type_default_value: STRING = "'%U'"
			-- Character type default_value.

	String_type_default_value: STRING = "%"%""
			-- String type default_value.

	Date_type_default_value: STRING = "create {DATE_TIME}.make_now";
			-- Date type default_value.

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




end -- class DB_CLASS_GENERATOR


