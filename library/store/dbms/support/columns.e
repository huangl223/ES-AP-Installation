 note
	description: "Description of a database table column"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date: 2009-04-11 03:38:01 +0000 (Sat, 11 Apr 2009) $";
	revision: "$Revision: 78205 $"

class
	COLUMNS [G -> DATABASE create default_create end]

inherit

	TYPES [G]

feature -- Status report

	table_qualifier: detachable STRING
		-- Qualifier of the table in which the column belongs

	table_owner: detachable STRING
		-- Owner id of table of name `table_name'

	table_name: detachable STRING
		-- Table name

	table_type: detachable STRING
		-- Table type

	column_name: detachable STRING
		-- Column name

	column_id: INTEGER
		-- Column identification number (number of column in table)

	column_nulls: detachable STRING
		-- 'Y' if the column can contain null values, 'N' if the column can't contain null values

	column_typename: detachable STRING


	data_type: INTEGER
		-- Data type of a column. Ingres has the following data type code(negative is for nullable field):
		-- integer 	-30/30
		-- float	-31/31
		-- c		-32/32
		-- text		-37/37
		-- date		-3/3
		-- money 	-5/5
		-- char		-20/20
		-- varchar	-21/21
		-- table_key -12/12
		-- object_key -11/11

	data_precision, precision, column_size: INTEGER
		-- precision of the Column

	data_length, length, buffer_length: INTEGER
		-- Column length in bytes

	data_scale, scale, decimal_digits: INTEGER
		-- the scale of the column

	radix, num_prec_radix: INTEGER
		-- the radix of the Column

	nullable: INTEGER
		-- if the column can get NULL value

	default_length: INTEGER
		-- Length of default value for a column

	data_default: detachable STRING
		-- Default field value

	num_distinct: INTEGER
		-- Oracle V7 add ons.

	low_value: INTEGER
		-- Oracle V7 add ons.

	high_value: INTEGER
		-- Oracle V7 add ons.

	density: INTEGER
		-- Oracle V7 add ons.

	owner_id: INTEGER
		-- Owner id of table of name `table_name'

	table_id: INTEGER
		-- Table identification number

	creation_date: detachable DATE_TIME
		-- Table creation date

	status: INTEGER
		--  Flag to check whether a column field can be null

	duplicate: like Current
			-- Duplicate copy of Current
		do
			create Result
			Result.set_all (column_id, data_type, data_length, scale, radix, precision, nullable, default_length, num_distinct, low_value, high_value, density, owner_id, table_id, status,
					data_default, table_qualifier, table_owner, table_name, table_type, column_name, column_nulls,column_typename, creation_date)
		end

	eiffel_type: INTEGER
			-- Eiffel type code mapped to Ingres type `data_type'
		do
			Result := db_spec.conv_type (-data_length, data_type)
			-- Returns `String_type' instead of `Character_type'
		end

feature -- Status setting

	set_all (col_id, dat_type, dat_len, sca, rad, prec, nulable, def_len, num_dist, low_val, high_val, dens, own_id, tb_id, stat : INTEGER;
		dat_def, qualifier, own,tab_name, tab_type, col_name, col_nulls, col_typename: detachable STRING; creat_date: detachable DATE_TIME)
			-- Set attributes with input parameter values.
		do

-- For ODBC
			if qualifier /= Void then
				table_qualifier := qualifier.twin
			end
--
			if own /= Void then
				table_owner := own.twin
			end
			if tab_name /= Void then
				table_name := tab_name.twin
			end
			if tab_type /= Void then
				table_type := tab_type.twin
			end
			if col_nulls /= Void then
				column_nulls := col_nulls.twin
			end
			if col_typename /= Void then
				column_typename := col_typename.twin
			end
			if col_name /= Void then
				column_name := col_name.twin
			end
			data_type := dat_type
			column_id := col_id
			data_length := dat_len
-- For ODBC
			precision := prec
			scale := sca
			radix := rad
			nullable := nulable
--
-- For Oracle
			if dat_def /= Void then
				data_default := dat_def.twin
			end
			default_length := def_len
			num_distinct := num_dist
			low_value := low_val
			high_value := high_val
			density := dens
--
-- For Sybase
			status := stat
			owner_id :=  own_id
			table_id := tb_id
			if creat_date /= Void then
				creation_date := creat_date.twin
			end
--
		end

feature -- Removal

	clear_all
			-- Reset all attributes to default values.
		do
			table_qualifier := Void
			table_owner := Void
			table_name := Void
			table_type := Void
			column_nulls := Void
			column_typename := Void
			column_name := Void
			data_default := Void
			creation_date := Void
			column_id := 0
			data_type := 0
			data_length:= 0
			precision := 0
			scale := 0
			radix := 0
			nullable :=0
			default_length := 0
			num_distinct := 0
			low_value := 0
			high_value := 0
			density := 0
			owner_id := 0
			table_id := 0
			status := 0
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




end -- class COLUMNS


