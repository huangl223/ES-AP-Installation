note
	description: "[         
								
				The arc is drawen from `start_angle' until `start_angle' + `aperture'.
				A full rotation is 2*pi. Direction is counter clockwise. 0 is 3 o`clock.

			]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "figure, arc, curve"
	date: "$Date: 2015-02-17 11:56:14 +0000 (Tue, 17 Feb 2015) $"
	revision: "$Revision: 96648 $"

class
	EV_MODEL_ROTATED_ARC

inherit
	EV_MODEL_ROTATED_ELLIPTIC
		redefine
			default_create
		end

create
	default_create,
	make_with_positions,
	make_with_points

feature {NONE} -- Initialization

	default_create
			-- Create an arc with some `start_angle' and `aperture'.
		do
			Precursor {EV_MODEL_ROTATED_ELLIPTIC}
			start_angle := 0.2
			aperture := Pi
		end

feature -- Access

	start_angle: DOUBLE
			-- Angle that defines start of arc.

	aperture: DOUBLE
			-- Angle that defines percentage of arc.

feature -- Visitor

	project (a_projector: EV_MODEL_DRAWING_ROUTINES)
			-- <Precursor>
		do
			a_projector.draw_figure_rotated_arc (Current)
		end

feature -- Element change

	set_start_angle (a_start_angle: DOUBLE)
			-- Set `start_angle' to `a_start_angle'.
		require
			a_start_angle_within_bounds:
				a_start_angle >= 0 and a_start_angle <= 2 * Pi
		do
			start_angle := a_start_angle
			invalidate
		ensure
			start_angle_assigned: start_angle = a_start_angle
		end

	set_aperture (an_aperture: DOUBLE)
			-- Set `aperture' to `an_aperture'.
		require
			an_aperture_within_bounds:
				an_aperture >= 0 and an_aperture <= 2 * Pi
		do
			aperture := an_aperture
			invalidate
		ensure
			aperture_assigned: aperture = an_aperture
		end

feature -- Events

	position_on_figure (a_x, a_y: INTEGER): BOOLEAN
			-- Is (`a_x', `a_y') on this figure?
		local
			cx, cy: DOUBLE
			an_angle, end_angle: DOUBLE
			angle_inside: BOOLEAN
			p0, p1, p2, p3: EV_COORDINATE
			r1, r2, p0x, p0y: DOUBLE
			l_point_array: like point_array
			l_angle: like angle
		do
			if aperture /= 0.0 then

				l_point_array := point_array

				p0 := l_point_array.item (0)
				p1 := l_point_array.item (1)
				p2 := l_point_array.item (2)
				p3 := l_point_array.item (3)

				p0x := p0.x_precise
				p0y := p0.y_precise

				cx := (p0x + p2.x_precise) / 2
				cy := (p0y + p2.y_precise) / 2

				r1 := distance (p0x, p0y, p1.x_precise, p1.y_precise) / 2
				r2 := distance (p0x, p0y, p3.x_precise, p3.y_precise) / 2

				l_angle := angle

				an_angle := 2 * pi - line_angle (cx, cy, a_x * cosine (l_angle) - a_y * sine (l_angle), a_x * sine (l_angle) + a_y * cosine (l_angle))
				end_angle := modulo (start_angle + aperture, 2 * Pi)
				if start_angle < end_angle then
					angle_inside := an_angle >= start_angle and an_angle <= end_angle
				else
					angle_inside := an_angle >= start_angle or an_angle <= end_angle
				end
				Result := point_on_rotated_ellipse_boundary (a_x, a_y, cx, cy, r1, r2, -l_angle, line_width ) --and angle_inside
			else
				Result := False
			end
		end

invariant
	start_angle_within_bounds: start_angle >= 0 and then start_angle <= 2 * Pi
	aperture_within_bounds: aperture >= 0 and then aperture <= 2 * Pi

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




end -- class EV_MODEL_ROTATED_ARC

