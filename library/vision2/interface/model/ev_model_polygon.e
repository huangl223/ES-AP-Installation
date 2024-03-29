note
	description:
		"Filled area's defined by any number of `points'."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "figure, polygon"
	date: "$Date: 2015-02-17 11:56:14 +0000 (Tue, 17 Feb 2015) $"
	revision: "$Revision: 96648 $"

class
	EV_MODEL_POLYGON

inherit
	EV_MODEL_CLOSED
		redefine
			default_create
		end

	EV_MODEL_MULTI_POINTED
		undefine
			default_create,
			bounding_box
		end

create
	default_create,
	make_with_coordinates

feature {NONE} -- Initialization

	default_create
			-- Polygon with no points.
		do
			create point_array.make_empty (0)
			Precursor {EV_MODEL_CLOSED}
		end

	make_with_coordinates (coords: ARRAY [EV_COORDINATE])
			-- Initialize with points in `coords'.
		require
			coords_exist: coords /= Void
		local
			i: INTEGER
		do
			default_create
			from
				i := coords.lower
			until
				i > coords.upper
			loop
				extend_point (coords.item (i))
				i := i + 1
			end
			set_center
		end

feature -- Visitor

	project (a_projector: EV_MODEL_DRAWING_ROUTINES)
			-- <Precursor>
		do
			a_projector.draw_figure_polygon (Current)
		end

feature -- Status report

	side_count: INTEGER
			-- Returns number of sides this polyline has.
		do
			Result := point_count - 1
			if Result < 0 then
				Result := 0
			end
		ensure
			Result_not_bigger_than_point_count: Result <= point_count
		end

	is_rotatable: BOOLEAN = True
			-- Is rotatable? Yes.

	is_scalable: BOOLEAN = True
			-- Is scalable? Yes.

	is_transformable: BOOLEAN = True
			-- Is transformable? Yes.

feature -- Access

	angle: DOUBLE
			-- Angle to rotate for upright position
		do
			Result := 0
		end

feature -- Events

	position_on_figure (a_x, a_y: INTEGER): BOOLEAN
			-- Is (`a_x', `a_y') contained in this figure?
		do
			Result := point_on_polygon (a_x, a_y, point_array)
		end

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




end -- class EV_MODEL_POLYGON


