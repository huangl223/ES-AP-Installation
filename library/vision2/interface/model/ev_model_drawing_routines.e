note
	description: "Abstract class for drawing figures."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "figure, primitives, drawing"
	date: "$Date: 2015-02-17 10:35:54 +0000 (Tue, 17 Feb 2015) $"
	revision: "$Revision: 96645 $"

deferred class
	EV_MODEL_DRAWING_ROUTINES

inherit
	ANY

	EV_MODEL_MATH
		export
			{NONE} all
		end

feature -- Figure drawing

	draw_figure_arc (arc: EV_MODEL_ARC)
			-- Draw standard representation of `arc' to canvas.
		require
			arc_not_void: arc /= Void
		deferred
		end

	draw_figure_rotated_arc (arc: EV_MODEL_ROTATED_ARC)
			-- Draw standard representation of `arc' to canvas.
		require
			arc_not_void: arc /= Void
		deferred
		end

	draw_figure_dot (dot: EV_MODEL_DOT)
			-- Draw standard representation of `dot' to canvas.
		require
			dot_not_void: dot /= Void
		deferred
		end

	draw_figure_ellipse (ellipse: EV_MODEL_ELLIPSE)
			-- Draw standard representation of `ellipse' to canvas.
		require
			ellipse_not_void: ellipse /= Void
		deferred
		end

	draw_figure_rotated_ellipse (ellipse: EV_MODEL_ROTATED_ELLIPSE)
			-- Draw standard representation of `ellipse' to canvas.
		require
			ellipse_not_void: ellipse /= Void
		deferred
		end

	draw_figure_equilateral (eql: EV_MODEL_EQUILATERAL)
			-- Draw standard representation of `eql' to canvas.
		require
			eql_not_void: eql /= Void
		deferred
		end

	draw_figure_line (line: EV_MODEL_LINE)
			-- Draw a standard representation of `line' to the canvas.
		require
			line_not_void: line /= Void
		deferred
		end

	draw_figure_picture (picture: EV_MODEL_PICTURE)
			-- Draw standard representation of `picture' to canvas.
		require
			picture_not_void: picture /= Void
		deferred
		end

	draw_figure_pie_slice (slice: EV_MODEL_PIE_SLICE)
			-- Draw standard representation of `slice' to canvas.
		require
			slice_not_void: slice /= Void
		deferred
		end

	draw_figure_rotated_pie_slice (slice: EV_MODEL_ROTATED_PIE_SLICE)
			-- Draw standard representation of `slice' to canvas.
		require
			slice_not_void: slice /= Void
		deferred
		end

	draw_figure_polygon (polygon: EV_MODEL_POLYGON)
			-- Draw standard representation of `polygon' to canvas.
		require
			polygon_not_void: polygon /= Void
		deferred
		end

	draw_figure_polyline (line: EV_MODEL_POLYLINE)
			-- Draw standard representation of `polyline' to canvas.
		require
			line_not_void: line /= Void
		deferred
		end

	draw_figure_rectangle (rectangle: EV_MODEL_RECTANGLE)
			-- Draw standard representation of `rectangle' to canvas.
		require
			rectangle_not_void: rectangle /= Void
		deferred
		end

	draw_figure_rounded_rectangle (f: EV_MODEL_ROUNDED_RECTANGLE)
			-- Draw standard representation of `f' to canvas.
		require
			f_not_void: f /= Void
		deferred
		end

	draw_figure_star (star: EV_MODEL_STAR)
			-- Draw standard representation of `star' to canvas.
		require
			star_not_void: star /= Void
		deferred
		end

	draw_figure_text (text_figure: EV_MODEL_TEXT)
			-- Draw standard representation of `text_figure' to canvas.
		require
			text_figure_not_void: text_figure /= Void
		deferred
		end

	draw_figure_parallelogram (parallelogram: EV_MODEL_PARALLELOGRAM)
			-- Draw standard representation of `parallelogram' to canvas.
		require
			parallelogram_not_void: parallelogram /= Void
		deferred
		end

	draw_figure_rounded_parallelogram (parallelogram: EV_MODEL_ROUNDED_PARALLELOGRAM)
			-- Draw standard representation of `parallelogram' to canvas.
		require
			parallelogram_not_void: parallelogram /= Void
		deferred
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




end -- class EV_MODEL_DRAWING_ROUTINES

