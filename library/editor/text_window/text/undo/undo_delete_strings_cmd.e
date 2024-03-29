note
	description: "Undo removing trailing blanks command."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2009-09-11 01:52:19 +0000 (Fri, 11 Sep 2009) $"
	revision: "$Revision: 80680 $"

class
	UNDO_DELETE_STRINGS_CMD

inherit
	UNDO_TEXT_CMD

create
	make

feature {NONE} -- Initialization

	make (a_text: EDITABLE_TEXT)
			-- Initialization
		require
			a_text_attached: a_text /= Void
		do
			create undo_remove_trailing_blank_list.make
			text := a_text
		ensure
			text_not_void: text = a_text
		end

feature -- Transformation

	add (urc: UNDO_DELETE_CMD)
			-- add the undo command to the list
		do
			undo_remove_trailing_blank_list.extend (urc)
		end

feature -- Status report

	converse : BOOLEAN
			-- Converse redo and undo behavior?

feature -- Status change

	set_converse (b: BOOLEAN)
			-- Set `converse' with `b'.
		do
			converse := b
		end

feature -- Basic Operations

	redo
			-- undo this command
		do
			if not converse then
				actual_redo
			else
				actual_undo
			end
		end

	undo
			-- redo this command
		do
			if not converse then
				actual_undo
			else
				actual_redo
			end
		end

feature {NONE} -- Implementation

	actual_undo
			-- Actual undo
		require
			undo_possible: undo_possible
		local
			x_in_characters, y_in_lines : INTEGER
			l_cursor: detachable EDITOR_CURSOR
		do
			l_cursor := text.cursor
			check l_cursor /= Void end -- Implied by precondition
			x_in_characters := l_cursor.x_in_characters
			y_in_lines := l_cursor.y_in_lines
			from
				undo_remove_trailing_blank_list.finish
			until
				undo_remove_trailing_blank_list.before
			loop
				undo_remove_trailing_blank_list.item.undo
				undo_remove_trailing_blank_list.back
			end
			l_cursor.set_from_character_pos (x_in_characters, y_in_lines, text)
		end

	actual_redo
			-- Actual redo
		require
			redo_possible: redo_possible
		local
			x_in_characters, y_in_lines : INTEGER
			l_cursor: detachable EDITOR_CURSOR
		do
			l_cursor := text.cursor
			check l_cursor /= Void end -- Implied by precondition
			x_in_characters := l_cursor.x_in_characters
			y_in_lines := l_cursor.y_in_lines
			from
				undo_remove_trailing_blank_list.start
			until
				undo_remove_trailing_blank_list.after
			loop
				undo_remove_trailing_blank_list.item.redo
				undo_remove_trailing_blank_list.forth
			end
			l_cursor.set_from_character_pos (x_in_characters, y_in_lines, text)
		end

	undo_remove_trailing_blank_list: LINKED_LIST [UNDO_DELETE_CMD]

invariant

	undo_list_not_void: undo_remove_trailing_blank_list /= Void

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




end
