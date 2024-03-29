﻿note

	description: "Handling of input documents through a lexical analyzer"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2019-08-05 08:11:48 +0000 (Mon, 05 Aug 2019) $"
	revision: "$Revision: 103393 $"

class INPUT inherit

	ARRAYED_LIST [TOKEN]
		rename
			item as token,
			make as arrayed_list_make
		end

create
	make

create {INPUT}
	arrayed_list_make

feature -- Initialisation

	make
			-- Create an empty document
		do
			arrayed_list_make (0)
		end

feature  -- Access

	analyzer: detachable LEXICAL
			-- Lexical analyzer used
		note
			option: stable
		attribute
		end

	keyword_code (s: STRING) : INTEGER
			-- Keyword code corresponding to `s';
			-- -1 if no specimen of `s' is found.
		require
			lex_not_void: analyzer /= Void
			s_not_void: s /= Void
		do
				-- Per precondition
			check attached analyzer as l_analyzer then
				Result := l_analyzer.keyword_code (s)
			end
		end

	keyword_string (code: INTEGER): STRING
			-- Keyword string corresponding to `code'
		require
			lex_not_void: analyzer /= Void
		do
				-- Per precondition
			check attached analyzer as l_analyzer then
				Result := l_analyzer.keyword_string (code)
			end
		end

	set_lexical (lexical: LEXICAL)
			-- Designate `lexical' as the `analyzer' to be used.
		require
			lex_not_void: lexical /= Void
		do
			analyzer := lexical
		end

feature  -- Status report

	end_of_document : BOOLEAN
			-- Has end of document been reached?
		require
			lex_not_void: analyzer /= Void
		do
				-- Per precondition
			check attached analyzer as l_analyzer then
				Result := l_analyzer.end_of_text
			end
		end

feature  -- Status setting

	set_input_file (filename: STRING)
			-- Set the name of the input file to be read
			-- by the lexical analyzer.
		require
			lex_not_void: analyzer /= Void
			name_not_void: filename /= Void
		do
				-- Per precondition
			check attached analyzer as l_analyzer then
				l_analyzer.set_file (filename)
			end
		end

	set_input_string (stringname: STRING)
			-- Set the name of the input string to be read
			-- by the lexical analyzer.
		require
			lex_not_void: analyzer /= Void
			stringname_not_void: stringname /= Void
		do
				-- Per precondition
			check attached analyzer as l_analyzer then
				l_analyzer.set_string (stringname)
			end
		end

feature  -- Input

	get_token
			-- Make next token accessible with `token'
		require
			analyzer_not_void: analyzer /= Void
		local
			new_token: TOKEN
		do
				-- Per precondition
			check attached analyzer as l_analyzer then
				if is_empty or else islast then
					analyzer.get_token
					if analyzer.last_token.type = 0 then
						io.put_string("unrecognized_tokens%N")
						raise_error ("Unrecognized token(s) found (and ignored)")
						from
						until
							end_of_document or analyzer.last_token.type /= 0
						loop
							analyzer.get_token
						end
					end
					new_token := analyzer.last_token
					if new_token /= Void then
						new_token := new_token.twin
					end
					put_right (new_token)
				end
				forth
			end
		end

	retrieve_lex (filename: STRING)
			-- Retrieve `analyzer' from filename if exists.
		require
			name_not_void: filename /= Void
		local
			retrieved_file: RAW_FILE
		do
			create retrieved_file.make_open_read (filename)
			if attached {like analyzer} retrieved_file.retrieved as l_ana then
				analyzer := l_ana
			end
			retrieved_file.close
		end

feature  -- Output

	out_list
			-- Output tokens recognized so far.
		do
			if not is_empty then
				from
					start
					io.put_string ("Printing all tokens ")
					io.new_line
				until
					after
				loop
					io.put_string (token.string_value)
					io.new_line
					forth
				end
			end
		end

	raise_error (s: STRING)
			-- Print error message `s'.
		require
			s_not_void: s /= Void
		do
			error_message.wipe_out
			if attached file_path as l_file_path then
				error_message.append (l_file_path.utf_8_name)
			end
			error_message.append (" (line ")
			error_message.append_integer (token.line_number)
			error_message.append ("): ")
			error_message.append (s)
			io.error.put_string (error_message)
			io.error.new_line
		end

feature {NONE} -- Access

	error_message : STRING
			-- Last error message output.
		once
			create Result.make (120)
		end

	file_name : detachable STRING
			-- Name of the file read by the lexical analyzer.
		obsolete
			"Use `file_path` instead. [2017-05-31]"
		require
			lex_not_void: analyzer /= Void
		do
				-- Per precondition
			check attached analyzer as l_analyzer then
				Result := l_analyzer.file_name
			end
		end

	file_path: detachable PATH
			-- Path of the file read by the lexical analyzer.
		require
			lex_not_void: analyzer /= Void
		do
				-- Per precondition
			check attached analyzer as l_analyzer then
				Result := l_analyzer.source_file_path
			end
		end

	line_number : INTEGER
			-- Line number of token.
		require
			lex_not_void: analyzer /= Void
		do
				-- Per precondition
			check attached analyzer as l_analyzer then
				Result := l_analyzer.token_line_number
			end
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

end
