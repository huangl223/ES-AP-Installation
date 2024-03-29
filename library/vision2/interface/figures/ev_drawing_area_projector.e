note
	description:
		"Projectors that make representations of `world' on%N%
		%EV_DRAWING_AREA."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "figures, project, pointer, drawing, points"
	date: "$Date: 2017-05-03 15:56:14 +0000 (Wed, 03 May 2017) $"
	revision: "$Revision: 100317 $"

class
	EV_DRAWING_AREA_PROJECTOR

obsolete
	"Use EV_MODEL_DRAWING_AREA_PROJECTOR instead. [2017-05-31]"

inherit
	EV_WIDGET_PROJECTOR

create
	make,
	make_with_buffer

feature {NONE} -- Initialization

	make (a_world: EV_FIGURE_WORLD; a_drawing_area: EV_DRAWING_AREA)
			-- Create with `a_world' and `a_drawing_area'.
		require
			a_world_not_void: a_world /= Void
			a_drawing_area_not_void: a_drawing_area /= Void
		do
			make_with_drawable_widget (a_world, a_drawing_area, a_drawing_area)
			a_drawing_area.expose_actions.extend (agent on_paint)
		end

	make_with_buffer (
		a_world: EV_FIGURE_WORLD;
		a_buffer: EV_PIXMAP;
		a_drawing_area: EV_DRAWING_AREA)
			-- Create with `a_world', `a_drawing_area' and `a_buffer'.
		require
			a_world_not_void: a_world /= Void
			a_drawing_area_not_void: a_drawing_area /= Void
			a_buffer_not_void: a_buffer /= Void
		do
			make_with_drawable_widget_and_buffer (
				a_world,
				a_drawing_area,
				a_buffer,
				a_drawing_area)
			a_drawing_area.expose_actions.extend (agent on_paint)
		end
		
feature {NONE} -- Implementation

	on_paint (x, y, w, h: INTEGER)
		do
			if buffer_used then
				update_rectangle (create {EV_RECTANGLE}.make (x, y, w, h), x, y)
			else
				project_rectangle (create {EV_RECTANGLE}.make (x, y, w, h))
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




end -- class EV_DRAWING_AREA_PROJECTOR

