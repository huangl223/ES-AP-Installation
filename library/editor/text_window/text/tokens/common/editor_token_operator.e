note
	description: "Token that describe an operator (+, :=, ?=, ...) "
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"
	date: "$Date: 2013-11-20 01:00:03 +0000 (Wed, 20 Nov 2013) $"
	revision: "$Revision: 93461 $"

class
	EDITOR_TOKEN_OPERATOR

inherit
	EDITOR_TOKEN_TEXT
		redefine
			text_color_id,
			background_color_id,
			process
		end

create
	make

feature -- Visitor

	process (a_visitor: TOKEN_VISITOR)
			-- Visitor
		do
			a_visitor.process_editor_token_operator (Current)
		end

feature -- Color

	text_color_id: INTEGER
		do
			Result := operator_text_color_id
		end

	background_color_id: INTEGER
		do
			if is_highlighted then
				Result := highlight_color_id
			else
				Result := operator_background_color_id
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




end -- class EDITOR_SYMBOL
