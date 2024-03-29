note
	description: "Cursor in editors"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2009-09-16 07:20:05 +0000 (Wed, 16 Sep 2009) $"
	revision: "$Revision: 80724 $"

class
	EDITOR_CURSOR

inherit
	TEXT_CURSOR
		redefine
			set_current_char,
			update_current_char,
			text
		end

create
	make_from_relative_pos,
	make_from_character_pos, make_from_integer

feature -- Element change

	set_current_char (a_token: EDITOR_TOKEN; a_position: INTEGER)
			-- Make `a_token' be the new value for `token'.
			-- Set the value of `pos_in_token' to `a_position'.
			-- Update `x_in_pixels' accordingly.
		do
			Precursor {TEXT_CURSOR} (a_token, a_position)
			if not initializing then
				text.on_cursor_move (Current)
			end
		end

	update_current_char
			-- Update the current token and the the position in it.
			-- It is required that the cursor is not in the left margin.
		do
			Precursor {TEXT_CURSOR}
			text.on_cursor_move (Current)
		end

feature {NONE} -- Implementation

	text: EDITABLE_TEXT;
			-- Text that contains `current'.

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




end -- class EDITOR_CURSOR
