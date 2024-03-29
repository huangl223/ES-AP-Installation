note
	description: "A partial line in the editor.  Unlinke full lines a partial line has not breakpoint and no eol token."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date: 2009-09-11 01:52:19 +0000 (Fri, 11 Sep 2009) $"
	revision: "$Revision: 80680 $"

class
	EDITOR_PARTIAL_LINE

inherit
	EDITOR_LINE
		redefine
			make_from_lexer
		end

create
	make_empty_line,
	make_from_lexer

feature -- Initialisation

	make_from_lexer (lexer: EDITOR_SCANNER)
			-- Create a line using token from `lexer'
		local
			lexer_end_token		: detachable EDITOR_TOKEN
		do
			lexer_end_token := lexer.end_token
			if lexer_end_token /= Void then
					-- The lexer has parsed something.
				real_first_token := lexer.first_token
			end
			set_part_of_verbatim_string (lexer.in_verbatim_string)
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




end -- class EDITOR_PARTIAL_LINE
