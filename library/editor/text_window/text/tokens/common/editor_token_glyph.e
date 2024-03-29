note
	description: "A token that describes an image glyph."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date: 2013-05-20 23:15:17 +0000 (Mon, 20 May 2013) $";
	revision: "$Revision: 92557 $"

class
	EDITOR_TOKEN_GLYPH

inherit
	EDITOR_TOKEN
		redefine
			height
		end

create
	make

feature {NONE} -- Initialization

	make (a_glyph: like glyph)
			-- Initialize token with a predefined image glyph
		require
			not_a_glyph_is_destroyed: not a_glyph.is_destroyed
		do
			glyph := a_glyph
			set_is_fake (True)
			length := 1
			create wide_image.make_empty
		ensure
			glyph_set: glyph = a_glyph
		end

feature -- Access

	glyph: attached EV_PIXEL_BUFFER
			-- Graphical image.

	width: INTEGER
			-- Width in pixel of the entire token.
		do
			Result := glyph.width + (padding * 2)
		end

	height: INTEGER
			--
		do
			Result := glyph.height
		end

	padding: INTEGER
			-- Padding of glyph
		do
			Result := 2
		end

feature -- Query

	frozen get_substring_width (n: INTEGER): INTEGER
			-- Compute the width in pixels of the first
			-- `n' characters of the current string.
		do
			if n = 1 then
				Result := width
			end
		end

	frozen retrieve_position_by_width(a_width: INTEGER): INTEGER
			-- Return the character situated under the `a_width'-th
			-- pixel.
		do
			Result := 1
		end

feature -- Display

	display (d_y: INTEGER; device: EV_DRAWABLE; panel: TEXT_PANEL)
			-- Display the current token on device context `dc'
			-- at the coordinates (`position',`d_y')
		do
			display_with_offset (2, d_y, device, panel)
		end

	display_with_offset (x_offset, d_y: INTEGER; device: EV_DRAWABLE; panel: TEXT_PANEL)
			-- <Precursor>
		local
			l_width: INTEGER
		do
			l_width := width - (padding * 2)
			check l_width_positive: l_width > 0 end
			device.clear_rectangle (position + x_offset, d_y, l_width, height)
			device.draw_sub_pixel_buffer (position + x_offset, d_y, glyph, create {EV_RECTANGLE}.make (0, 0, l_width, height))
		end

feature -- Visitor

	process (a_visitor: TOKEN_VISITOR)
			-- Visitor
		do
			a_visitor.process_editor_token_glyph (Current)
		end

invariant
	not_glyph_is_destroyed: not glyph.is_destroyed
	length_is_one: length = 1
	is_fake: is_fake

;note
	copyright:	"Copyright (c) 1984-2007, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
