note
	description: "[

				`text's in a `font' displayed on p0 == point.
		
					p0---------------------------p2
					|fooooooooooooooooooooooooooo
					| p3
					|bar        center
					|foobar
					p1
					
					p3.y - p0.y  is the should height of a character to match scale
					p3.x - p0.x  is the should width of a character to match scale

				]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "figure, text, string"
	date: "$Date: 2015-02-17 11:56:14 +0000 (Tue, 17 Feb 2015) $"
	revision: "$Revision: 96648 $"

class
	EV_MODEL_TEXT

inherit
	EV_MODEL_ATOMIC
		undefine
			is_equal
		redefine
			default_create,
			recursive_transform,
			default_line_width,
			border_width
		end

	EV_FONT_CONSTANTS
		export
			{NONE} all
			{ANY} valid_family, valid_weight, valid_shape
		undefine
			default_create,
			out,
			is_equal
		end

	EV_MODEL_SINGLE_POINTED
		undefine
			default_create,
			point_count,
			is_equal
		end

	COMPARABLE
		undefine
			default_create
		end

	EV_SHARED_SCALE_FACTORY
		undefine
			default_create,
			is_equal
		end

create
	default_create,
	make_with_text,
	make_with_position

feature {NONE} -- Initialization

	default_create
			-- Create in (0, 0)
		do
			Precursor {EV_MODEL_ATOMIC}
			create point_array.make_empty (4)
			point_array.extend (create {EV_COORDINATE})
			point_array.extend (create {EV_COORDINATE})
			point_array.extend (create {EV_COORDINATE})
			create {STRING_32} text.make_empty
			id_font := default_font
			scaled_font := font
			point_array.extend (create {EV_COORDINATE}.make (font.width, font.height))
			is_default_font_used := True
			is_center_valid := True
		ensure then
			center_is_valid: is_center_valid
		end

	make_with_text (a_text: READABLE_STRING_GENERAL)
			-- Create with `a_text'.
		require
			a_text_not_void: a_text /= Void
		do
			default_create
			set_text (a_text)
			set_center
		ensure
			center_is_valid: is_center_valid
		end

feature -- Access

	text: STRING_32
			-- Text that is displayed.

	font: EV_FONT
			-- Typeface `text' is displayed in.
		do
			Result := id_font.font
		end

	angle: DOUBLE = 0.0
			-- Since not rotatable.

	is_scalable: BOOLEAN = True
			-- Is scalable? (Yes)

	is_rotatable: BOOLEAN = False
			-- Not yet.

	is_transformable: BOOLEAN = False
			-- No.

	point_x: INTEGER
			-- x position of `point'.
		do
			Result := point_array.item (0).x
		end

	point_y: INTEGER
			-- y position of `point'.
		do
			Result := point_array.item (0).y
		end

feature -- Status report

	width: INTEGER
			-- Horizontal dimension.
		local
			l_point_array: like point_array
		do
			l_point_array := point_array
			Result := as_integer (l_point_array.item (2).x_precise - l_point_array.item (0).x_precise)
		end

	height: INTEGER
			-- Vertical dimension.
		local
			l_point_array: like point_array
		do
			l_point_array := point_array
			Result := as_integer (l_point_array.item (1).y_precise - l_point_array.item (0).y_precise)
		end

	is_default_font_used: BOOLEAN
			-- Is `Current' using a default font?

	is_less alias "<" (other: like Current): BOOLEAN
			-- Is current object less than `other'?
		do
			Result := text < other.text
		end

feature -- Visitor

	project (a_projector: EV_MODEL_DRAWING_ROUTINES)
			-- <Precursor>
		do
			a_projector.draw_figure_text (Current)
		end

feature -- Status setting

	set_point_position (ax, ay: INTEGER)
			-- Set position of `point' to (`ax', `ay').
		local
			a_delta_x, a_delta_y: DOUBLE
			l_point_array: like point_array
			p0, p1, p2, p3: EV_COORDINATE
		do
			l_point_array := point_array
			p0 := l_point_array.item (0)
			p1 := l_point_array.item (1)
			p2 := l_point_array.item (2)
			p3 := l_point_array.item (3)

			a_delta_x := ax - p0.x_precise
			a_delta_y := ay - p0.y_precise

			p0.set (ax, ay)
			p1.set_precise (p1.x_precise + a_delta_x, p1.y_precise + a_delta_y)
			p2.set_precise (p2.x_precise + a_delta_x, p2.y_precise + a_delta_y)
			p3.set_precise (p3.x_precise + a_delta_x, p3.y_precise + a_delta_y)
			invalidate
			center_invalidate
		end

	set_font (a_font: like font)
			-- Assign `a_font' to `font'.
		require
			a_font_not_void: a_font /= Void
		do
			set_identified_font (font_factory.registered_font (a_font))
		ensure
			font_assigned: font = a_font
		end

	set_identified_font (an_id_font: EV_IDENTIFIED_FONT)
			-- Set `id_font' to `an_id_font' initialize `scaled_font'.
		require
			an_id_font_not_Void: an_id_font /= Void
		local
			l_point_array: like point_array
			p0: EV_COORDINATE
			should_height, real_height, scale_factor: DOUBLE
		do
			real_height := id_font.font.height

			id_font := an_id_font
			font_factory.register_font (id_font)

			l_point_array := point_array
			should_height := l_point_array.item (3).y_precise - l_point_array.item (0).y_precise

			scale_factor := should_height / real_height

			scaled_font := font_factory.scaled_font (id_font, as_integer (id_font.font.height * scale_factor).max (1))

			p0 := l_point_array.item (0)
			l_point_array.item (3).set_precise (p0.x_precise + scaled_font.width, p0.y_precise + scaled_font.height)

			update_dimensions
			invalidate
			center_invalidate
		ensure
			set: id_font = an_id_font
		end

	set_text (a_text: READABLE_STRING_GENERAL)
			-- Assign `a_text' to `text'.
		require
			a_text_not_void: a_text /= Void
		do
			text := a_text.as_string_32
			update_dimensions
			invalidate
		ensure
			text_assigned: text.same_string_general (a_text)
		end

feature -- Events

	position_on_figure (a_x, a_y: INTEGER): BOOLEAN
			-- Is the point on (`a_x', `a_y') on this figure?
			--| Used to generate events.
		local
			l_point_array: like point_array
			p0: EV_COORDINATE
		do
			l_point_array := point_array
			p0 := l_point_array.item (0)
			Result := point_on_rectangle (a_x, a_y, p0.x_precise, p0.y_precise, l_point_array.item (2).x_precise, l_point_array.item (1).y_precise)
		end

feature {EV_MODEL_GROUP} -- Figure group

	recursive_transform (a_transformation: EV_MODEL_TRANSFORMATION)
			-- Same as transform but without precondition
			-- is_transformable and without invalidating
			-- groups center.
		local
			l_font: like font
			l_point_array: like point_array
			should_height: INTEGER
		do
			Precursor {EV_MODEL_ATOMIC} (a_transformation)

			l_font := scaled_font
			l_point_array := point_array
			should_height := as_integer (l_point_array.item (3).y_precise - l_point_array.item (0).y_precise).max (1)
			if should_height /= l_font.height then

				scaled_font := font_factory.scaled_font (id_font, should_height)

				if should_height > 1 then
					update_dimensions
				end
			end
		end

feature {EV_MODEL_DRAWER}

	scaled_font: like font

	left_offset: INTEGER

feature {NONE} -- Implementation

	id_font: EV_IDENTIFIED_FONT

	update_dimensions
			-- Reassign `width' and `height'.
		local
			t: TUPLE [width: INTEGER; height: INTEGER; left_offset: INTEGER; right_offset: INTEGER]
			l_point_array: like point_array
			p0: EV_COORDINATE
		do
			t := scaled_font.string_size (text)

			left_offset := t.left_offset

			l_point_array := point_array
			p0 := l_point_array.item (0)

			l_point_array.item (1).set_y_precise (p0.y_precise + t.height)
			l_point_array.item (2).set_x_precise (p0.x_precise + t.width - left_offset + t.right_offset)
			center_invalidate
		end

	default_font: EV_IDENTIFIED_FONT
			-- Font set by `default_create'.
		local
			l_font: EV_FONT
		once
			create l_font
			Result := font_factory.registered_font (l_font)
			font_factory.register_font (Result)
		end

	set_center
			-- Set the position to the center
		local
			l_point_array: like point_array
			p0, p1, p2: EV_COORDINATE
		do
			l_point_array := point_array
			p0 := l_point_array.item (0)
			p1 := l_point_array.item (1)
			p2 := l_point_array.item (2)

			center.set_precise ((p1.x_precise + p2.x_precise) / 2, (p1.y_precise + p2.y_precise) / 2)
			is_center_valid := True
		end

	default_line_width: INTEGER = 0
		-- <Precursor>
	border_width: INTEGER = 0
		-- <Precursor>

invariant
	text_exists: text /= Void
	font_exists: font /= Void

note
	copyright:	"Copyright (c) 1984-2015, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class EV_MODEL_TEXT


