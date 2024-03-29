note
	description: "A groups of tokens."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2013-11-20 01:00:03 +0000 (Wed, 20 Nov 2013) $"
	revision: "$Revision: 93461 $"

class
	EDITOR_TOKEN_GROUP

inherit
	EDITOR_TOKEN

	DOUBLE_MATH

create
	make_from_lexer

feature -- Initialisation

	make_from_lexer (lexer: EDITOR_SCANNER)
			-- Create a group of tokens from using token from `lexer'
		require
			lexer_exists: lexer /= Void
		local
			lexer_token,
			lexer_end_token: detachable EDITOR_TOKEN
		do
			lexer_end_token := lexer.end_token
			if lexer_end_token /= Void then
				from
					create internal_representation.make (2)
					lexer_token := lexer.first_token
				until
					lexer_token = lexer_end_token
				loop
					check lexer_token /= Void end -- Implied by `lexer_end_token' attached and before the end token is not void.
					internal_representation.extend (lexer_token)
					lexer_token := lexer_token.next
				end
				internal_representation.extend (lexer_end_token)
			else
				create internal_representation.make (0)
			end
			wide_image := composite_image
		end

feature -- Miscellaneous

	width: INTEGER
			-- Width in pixel of the entire token.

	get_substring_width (n: INTEGER): INTEGER
			-- Conpute the width in pixels of the first
			-- `n' characters of the current string.
		do
			from
				internal_representation.start
			until
				internal_representation.after
			loop
				Result := Result + internal_representation.item.get_substring_width (n)
				internal_representation.forth
			end
		end

	retrieve_position_by_width (a_width: INTEGER): INTEGER
			-- Return the character situated under the `a_width'-th
			-- pixel.
		local
			current_position: INTEGER
			current_width	: INTEGER
			next_width	: INTEGER
		do
				-- precompute an estimation of the current_position
			current_position := (a_width // font.width).min (length)

				-- We have now to check that our current position is the good one.
				-- If we are above, we decrease current_position, and the opposite.
			from
				current_width := get_substring_width (current_position)
				next_width := get_substring_width (current_position + 1)
			until
				a_width >= current_width and then a_width < next_width
			loop
				if a_width < current_width then
					current_position := current_position - 1
					next_width := current_width
					current_width := get_substring_width (current_position)
				else
					current_position := current_position + 1
					current_width := next_width
					next_width := get_substring_width (current_position + 1)
				end
			end

			Result := current_position + 1 -- We return a 1-based result (first character = 1)
		end

	display (d_y: INTEGER; device: EV_DRAWABLE; panel: TEXT_PANEL)
			-- Display the current token on device context `dc'
			-- at the coordinates (`position',`d_y')
		do
			from
				internal_representation.start
			until
				internal_representation.after
			loop
				internal_representation.item.display (d_y, device, panel)
				internal_representation.forth
			end
		end

	display_with_offset (x_offset, d_y: INTEGER; device: EV_DRAWABLE; panel: TEXT_PANEL)
			-- Display the current token on device context `dc'
			-- at the coordinates (`position',`d_y')
		do
			from
				internal_representation.start
			until
				internal_representation.after
			loop
				internal_representation.item.display (d_y, device, panel)
				internal_representation.forth
			end
		end

	tab_size_cell: detachable CELL [INTEGER]

	tabulation_width: INTEGER
		local
			l_tab_size: like tab_size_cell
		do
				-- Compute the number of pixels represented by a tabulation based on
				-- user preferences number of spaces per tabulation.
			l_tab_size := tab_size_cell
			if l_tab_size /= Void then
				Result := l_tab_size.item * font.string_width(" ")
			end
		end

	internal_representation: ARRAYED_LIST [EDITOR_TOKEN]
			-- Internal representation of tokens

feature -- Visitor

	process (a_visitor: TOKEN_VISITOR)
			-- Visitor
		do
			a_visitor.process_editor_token_group (Current)
		end

feature {NONE} -- Implementation

	composite_image: STRING_32
			-- Image of Current as single token
		do
			from
				create Result.make_empty
				internal_representation.start
			until
				internal_representation.after
			loop
				Result.append (internal_representation.item.wide_image)
				internal_representation.forth
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




end -- class EDITOR_TOKEN_SELECTABLE
