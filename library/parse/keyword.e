﻿note

	description:
		"Terminal constructs with just one specimen, %
		%representing a language keyword or special symbol"
	legal: "See notice at end of class.";

	status: "See notice at end of class.";
	date: "$Date: 2017-04-14 10:59:28 +0000 (Fri, 14 Apr 2017) $";
	revision: "$Revision: 100194 $"

class KEYWORD inherit

	TERMINAL
		rename
			make as construct_make
		redefine
			token_correct
		end

create

	make

feature {NONE}-- Initialization

	make (s: STRING)
			-- Set up terminal to represent `s'.
		require
			s_not_void: s /= Void
		do
			construct_name := s
			construct_make
			lex_code := document.keyword_code (s)
		ensure
			construct_name = s;
			lex_code = document.keyword_code (s)
		end;

feature -- Access

	construct_name: STRING;
			-- Name of the keyword

	lex_code: INTEGER
			-- Code of keyword in the lexical anayser

feature {KEYWORD} -- Implementation

	clone_node (n: like Current): like Current
			-- <precursor>
		do
			create Result.make (n.construct_name)
			Result.copy_node (n)
		end

	new_tree: like Current
			-- <precursor>
		do
			create Result.make (construct_name)
		end

feature {NONE} -- Implementation

	token_correct: BOOLEAN
			-- Is this keyword the active token?
		do
			Result := document.token.is_keyword (lex_code)
		end;

	token_type: INTEGER = 0;
			-- Unused token type

note
	copyright:	"Copyright (c) 1984-2017, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
