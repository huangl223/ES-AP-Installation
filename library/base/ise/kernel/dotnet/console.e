﻿note
	description: "[
		Commonly used console input and output mechanisms. 
		This class may be used as ancestor by classes needing its facilities.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2020-05-18 14:42:57 +0000 (Mon, 18 May 2020) $"
	revision: "$Revision: 104246 $"

class CONSOLE inherit

	PLAIN_TEXT_FILE
		rename
			make_open_read as make_open_stdin,
			make_open_write as make_open_stdout
		export
			{NONE}
				all
			{CONSOLE} open_read, close, internal_stream
			{ANY}
				separator, append, file_pointer, last_character, last_integer,
				last_real, last_string, last_double, file_readable,
				lastchar, lastint, lastreal, laststring, lastdouble,
				read_character, readchar, read_real,
				last_integer_32, last_integer_8, last_integer_16, last_integer_64,
				last_natural_8, last_natural_16, last_natural, last_natural_32,
				last_natural_64,
				read_line, read_stream, read_word,
				put_boolean, put_real, put_double, put_string, put_character,
				put_new_line, new_line, readint, readreal, readline, readstream,
				readword,  putbool, putreal, putdouble, putstring, putchar,
				read_integer_8, read_integer_16, read_integer, read_integer_32, read_integer_64,
				read_natural_8, read_natural_16, read_natural, read_natural_32, read_natural_64,
				put_integer_8, put_integer_16, putint, put_integer, put_integer_32, put_integer_64,
				put_natural_8, put_natural_16, put_natural, put_natural_32, put_natural_64,
				dispose, before, readable, is_closed, extendible, is_open_write
		redefine
			initialize_encoding, detect_encoding,
			back,
			close,
			count,
			dispose,
			end_of_file,
			exists,
			is_empty,
			make_open_stdin,
			make_open_stdout,
			new_cursor,
			next_line,
			read_character,
			read_double,
			read_integer_with_no_type,
			read_line,
			readchar,
			readdouble,
			readline
		end

	ANY

create {STD_FILES}
	make_open_stdin, make_open_stdout, make_open_stderr

feature -- Initialization

	make_open_stdin (fn: READABLE_STRING_GENERAL)
			-- Create a standard input file.
		do
			make_with_name (fn)
			internal_stream := {SYSTEM_CONSOLE}.open_standard_input
			set_read_mode
		end

	make_open_stdout (fn: READABLE_STRING_GENERAL)
			-- Create a standard output file.
		do
			make_with_name (fn)
			internal_stream := {SYSTEM_CONSOLE}.open_standard_output
			set_write_mode
		end

	make_open_stderr (fn: READABLE_STRING_GENERAL)
			-- Create a standard error file.
		do
			make_with_name (fn)
			internal_stream := {SYSTEM_CONSOLE}.open_standard_error
			set_write_mode
		end

	initialize_encoding
			-- <Precursor/>
		do
			Precursor
			encoding := {SYSTEM_ENCODINGS}.console_encoding
		end

feature -- Encoding

	detect_encoding
			-- <Precursor/>
		do
			encoding := {SYSTEM_ENCODINGS}.console_encoding
		end

feature -- Cursor movement

	next_line
			-- Move to next input line.
		do
			if peek /= -1 then
				Precursor {PLAIN_TEXT_FILE}
			end
		end

feature -- Status report

	exists: BOOLEAN
			-- Does file exist?
		do
			Result := True
		end

	end_of_file: BOOLEAN = False
			-- Has an EOF been detected?
			-- Always false for a console.

	count: INTEGER = 1
			-- Useless for CONSOLE class.
			--| `count' is non null not to invalidate invariant clauses.

feature -- Removal

	close
			-- Do not close the streams.
		do
		end

	dispose
			-- This is closed by the operating system at completion.
		do
		end

feature -- Cursor movement

	back
			-- Not supported on console
		do
		end

feature -- Iteration

	new_cursor: FILE_ITERATION_CURSOR
			-- <Precursor>
		do
			if is_open_read then
				create Result.make_open_stdin
			else
				create Result.make_empty
			end
		end

feature -- Input

	read_character, readchar
			-- Read a new character.
			-- Make result available in `last_character'.
		local
			a_code: INTEGER
		do
			if attached internal_stream as l_stream then
				a_code := l_stream.read_byte
				if a_code = - 1 then
					internal_end_of_file := True
				else
						-- FIXME: If %R is not followed by %N,
						--        we will lost the following character.
						--        we always assume that %R is followed by %N.
					if a_code = 13 then
							a_code := l_stream.read_byte
							if a_code = -1 then
								internal_end_of_file := True
							end
							a_code := 10
					end
					last_character := a_code.to_character_8
				end
			end
		end

	read_double, readdouble
			-- Read the ASCII representation of a new double
			-- from file. Make result available in `last_double'.
		do
			read_number_sequence (ctor_convertor, {NUMERIC_INFORMATION}.type_double)
			last_double := ctor_convertor.parsed_double
				-- Consume all left characters until we meet a new-line character.
			consume_characters
		end

	read_line, readline
			-- Read a string until new line or end of file.
			-- Make result available in `last_string'.
			-- New line will be consumed but not part of `last_string'.
		local
			i, c, p: INTEGER
			str_cap: INTEGER
			p_fetched: BOOLEAN
			done: BOOLEAN
			l_last_string: like last_string
		do
			if attached internal_stream as l_stream then
				from
					l_last_string := last_string
					l_last_string.wipe_out
					done := False
					i := 0
					str_cap := l_last_string.capacity
				until
					done
				loop
					if p_fetched then
						c := p
					else
						c := l_stream.read_byte
					end
					if c = 13 then
						p := l_stream.read_byte
						p_fetched := True
					end
					if c = 13 and then p = 10 then
							-- Discard end of line in the form "%R%N".
						done := True
					elseif c = 10 then
							-- Discard end of line in the form "%N".
						done := True
					elseif c = -1 then
						internal_end_of_file := True
						done := True
					else
						i := i + 1
						if i > str_cap then
							if str_cap < 2048 then
								l_last_string.grow (str_cap + 1024)
								str_cap := str_cap + 1024
							else
								l_last_string.automatic_grow
								str_cap := l_last_string.capacity
							end
						end
						l_last_string.append_character (c.to_character_8)
					end
				end
			end
		end

feature {NONE} -- Implementation	

	read_integer_with_no_type
			-- Read a ASCII representation of number of `type'
			-- at current position.
		do
			read_number_sequence (ctoi_convertor, {NUMERIC_INFORMATION}.type_no_limitation)
				-- Consume all left characters until we meet a new-line character.
			consume_characters
		end

	consume_characters
			-- Consume all characters from current position
			-- until we meet a new-line character.
		do
			from

			until
				end_of_file or last_character = '%N'
			loop
				read_character
			end
		end


feature {NONE} -- Inapplicable

	is_empty: BOOLEAN = False;
			-- Useless for CONSOLE class.
			--| `empty' is false not to invalidate invariant clauses.

note
	library:	"EiffelBase: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2020, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
