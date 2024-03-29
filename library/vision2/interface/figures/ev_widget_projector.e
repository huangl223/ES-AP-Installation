note
	description:
		"Projectors for widgets."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "projector, events"
	date: "$Date: 2017-05-03 15:56:14 +0000 (Wed, 03 May 2017) $"
	revision: "$Revision: 100317 $"

deferred class
	EV_WIDGET_PROJECTOR

obsolete
	"Use EV_MODEL_WIDGET_PROJECTOR instead. [2017-05-31]"

inherit
	EV_PROJECTOR

	EV_FIGURE_DRAWER

	EV_PROJECTION_ROUTINES

feature {NONE} -- Initialization

	make_with_drawable_widget (a_world: EV_FIGURE_WORLD; a_drawable: EV_DRAWABLE; a_widget: like widget)
			-- Create with `a_world' and `a_drawable' (= `a_widget').
		require
			a_world_not_void: a_world /= Void
			a_drawable_not_void: a_drawable /= Void
			a_widget_not_void: a_widget /= Void
		do
			make_with_drawable (a_drawable)
			create draw_routines.make_filled (Void, 0, 20)
			make_with_world (a_world)
			widget := a_widget
			register_basic_figures
			area_x := 0
			area_y := 0
			widget.pointer_motion_actions.extend (agent mouse_move)
			widget.pointer_button_press_actions.extend (agent button_press)
			widget.pointer_double_press_actions.extend (agent double_press)
			widget.pointer_button_release_actions.extend (agent button_release)
			widget.pointer_leave_actions.extend (agent pointer_leave)
			widget.set_pebble_function (agent on_pebble_request)
			widget.set_actual_drop_target_agent (agent on_drop_target_request)
		end

	make_with_drawable_widget_and_buffer (
		a_world: EV_FIGURE_WORLD;
		a_drawable: EV_DRAWABLE;
		a_buffer: EV_PIXMAP;
		a_widget: like widget)
			-- Create with `a_world', `a_drawable' (= `a_widget') and `a_buffer'.
		require
			a_world_not_void: a_world /= Void
			a_drawable_not_void: a_drawable /= Void
			a_buffer_not_void: a_buffer /= Void
			a_widget_not_void: a_widget /= Void
		do
			area := a_drawable
			make_with_drawable_widget (a_world, a_buffer, a_widget)
		end

feature -- Access

	widget: EV_WIDGET
			-- `device' if conforms to EV_WIDGET.
			-- `Void' otherwise.

	area: detachable EV_DRAWABLE
			-- Area associated with `widget'.
			-- `Void' if no buffer is used.

	area_x, area_y: INTEGER
			-- Coordinates of top-left corner of displayed part of `drawable'.
			-- (0, 0) when no buffer is used.

feature -- Status report

	buffer_used: BOOLEAN
			-- Is `drawable' only a buffer area for `area'?
		do
			Result := area /= Void
		end

feature -- Element change

	change_area_position (a_x, a_y: INTEGER)
			-- `area' has moved to (`a_x', `a_y') of `drawable'.
		require
			valid_position: a_x >= 0 and a_y >= 0
		local
			u: EV_RECTANGLE
			l_area: like area
		do
			l_area := area
			check l_area /= Void then end
			area_x := a_x
			area_y := a_y
			create u.make (0, 0, l_area.width, l_area.height)
			update_rectangle (u, 0, 0)
		end

feature -- Basic operations

	project
			-- Make a standard projection of world on device.
		local
			e, u: detachable EV_RECTANGLE
		do
			if not is_projecting then
				is_projecting := True

				if world.is_redraw_needed then
					full_project
					world.full_redraw_performed
				else
					e := world.invalid_rectangle
					if e /= Void then
						u := world.update_rectangle
						if u /= Void then
							e.merge (u)
						end
						project_rectangle (e)
					end
				end
			end
			is_projecting := False
		end

	project_rectangle (u: EV_RECTANGLE)
			-- Project area under `u'.
		local
			pixmap: detachable EV_PIXMAP
		do
			drawable.set_background_color (world.background_color)
			drawable.clear_rectangle (u.left, u.top, u.width, u.height)

			if world.grid_enabled and world.grid_visible then
				draw_grid
			end

			if world.is_show_requested then
				project_figure_group (world, u)
			end
			if has_mouse then
				change_current (figure_on_position (world, last_pointer_x,
				last_pointer_y))
			end
			if world.points_visible then
				project_rel_point (world.point)
			end

			world.validate

			if buffer_used then
					-- Flush `drawable' on `area'.
				pixmap ?= drawable
				if pixmap /= Void and then attached area as l_area then
					u.set_x (area_x)
					u.set_y (area_y)
					u.set_width (l_area.width)
					u.set_height (l_area.height)
					l_area.draw_sub_pixmap (0, 0, pixmap, u)
				end
			end
		end

	full_project
			-- Project entire area.
		local
			rectangle: EV_RECTANGLE
		do
			create rectangle.make (0, 0, drawable.width, drawable.height)
			project_rectangle (rectangle)
		end

	update_rectangle (u: EV_RECTANGLE; a_x, a_y: INTEGER)
			-- Flush `u' on `area' at (`a_x', `a_y').
		require
			buffer_used: buffer_used
		local
			pixmap: detachable EV_PIXMAP
		do
			pixmap ?= drawable
			if pixmap /= Void and then attached area as l_area then
				u.set_x (u.x + area_x)
				u.set_y (u.y + area_y)
				l_area.draw_sub_pixmap (a_x, a_y, pixmap, u)
			end
		end

	clear_device
			-- Erase entire canvas.
		do
			drawable.set_background_color (world.background_color)
			drawable.clear
		end

feature {NONE} -- Event implementation

	current_figure: detachable EV_FIGURE
			-- Figure mouse is currently on.
			--| To generate leave and enter actions.

	last_pointer_x, last_pointer_y: INTEGER
			-- Last mouse coordinates.
			--| Used when world changes using `project'.

	has_mouse: BOOLEAN
			-- Does canvas have mouse on it?

	figure_on_position (group: EV_FIGURE_GROUP; x, y: INTEGER): detachable EV_FIGURE
			-- Figure mouse-cursor is on.
		local
			grp: detachable EV_FIGURE_GROUP
		do
			if world.capture_figure /= Void then
				Result := world.capture_figure
			else
				from
					group.finish
				until
					Result /= Void or else group.before
				loop
					grp ?= group.item
					if grp /= Void and then group.is_show_requested then
						if group.position_on_figure (x, y) then
							Result := grp
						else
							Result := figure_on_position (grp, x, y)
						end
					elseif group.item.position_on_figure (x, y) then
						Result := group.item
					end
					group.back
				end
			end
		end

	button_press (x, y, button: INTEGER; x_tilt, y_tilt, pressure: DOUBLE;
		screen_x, screen_y: INTEGER)
			-- Pointer button down happened.
		local
			event_fig: detachable EV_FIGURE
			p: BOOLEAN
			w_x, w_y: INTEGER
		do
			w_x := x + area_x
			w_y := y + area_y
			from
				event_fig := figure_on_position (world, w_x, w_y)
			until
				event_fig = Void
			loop
				if event_fig.is_sensitive and attached event_fig.internal_pointer_button_press_actions as l_actions then
					l_actions.call ([w_x - world.point.x, w_y - world.point.y, button,
						x_tilt, y_tilt, pressure, screen_x, screen_y])
				end
				event_fig := event_fig.group
				p := True
			end
			if p then
				project
			end
		end

	double_press (x, y, button: INTEGER; x_tilt, y_tilt, pressure: DOUBLE;
		screen_x, screen_y: INTEGER)
			-- Pointer double click happened.
		local
			event_fig: detachable EV_FIGURE
			p: BOOLEAN
			w_x, w_y: INTEGER
		do
			w_x := x + area_x
			w_y := y + area_y
			from
				event_fig := figure_on_position (world, w_x, w_y)
			until
				event_fig = Void
			loop
				if event_fig.is_sensitive and attached event_fig.internal_pointer_double_press_actions as l_actions then
					l_actions.call ([w_x - world.point.x, w_y - world.point.y, button,
						x_tilt, y_tilt, pressure, screen_x, screen_y])
				end
				event_fig := event_fig.group
				p := True
			end
			if p then
				project
			end
		end

	button_release (x, y, button: INTEGER; x_tilt, y_tilt, pressure: DOUBLE;
		screen_x, screen_y: INTEGER)
			-- Pointer button up happened.
		local
			event_fig: detachable EV_FIGURE
			p: BOOLEAN
			w_x, w_y: INTEGER
		do
			w_x := x + area_x
			w_y := y + area_y
			from
				event_fig := figure_on_position (world, w_x, w_y)
			until
				event_fig = Void
			loop
				if event_fig.is_sensitive and attached event_fig.internal_pointer_button_release_actions as l_actions then
					l_actions.call ([w_x - world.point.x, w_y - world.point.y, button,
						x_tilt, y_tilt, pressure, screen_x, screen_y])
				end
				event_fig := event_fig.group
				p := True
			end
			if p then
				project
			end
		end

	pointer_leave
			-- Pointer left canvas.
		do
			has_mouse := False
		end

	has_focus (a_figure: EV_FIGURE): BOOLEAN
			-- Is mouse cursor on `a_figure'?
		local
			grp: detachable EV_FIGURE_GROUP
		do
			if current_figure = a_figure then
				Result := True
			else
				grp ?= a_figure
				if grp /= Void then
					from grp.start until Result or grp.after loop
						Result := has_focus (grp.item)
						grp.forth
					end
				end
			end
		end

	change_current (new_current_figure: detachable EV_FIGURE)
			-- Change current to `new_focused_figure'.
			--| Generate leave and/or enter events accordingly.
		local
			old_figure: detachable EV_FIGURE
			event_fig: detachable EV_FIGURE
			same_fig: detachable EV_FIGURE
			p: BOOLEAN
		do
			if current_figure /= new_current_figure then
				if
					new_current_figure /= Void and then
					new_current_figure.is_sensitive and then
					attached new_current_figure.pointer_style as l_new_current_figure_pointer_style
				then
					widget.set_pointer_style (l_new_current_figure_pointer_style)
				else
					widget.set_pointer_style (Default_pixmaps.Standard_cursor)
				end
				old_figure := current_figure
				current_figure := new_current_figure
				if old_figure /= Void then
					from
						event_fig := old_figure
					until
						event_fig = Void or else has_focus (event_fig)
					loop
						if event_fig.is_sensitive and attached event_fig.internal_pointer_leave_actions as l_actions then
							l_actions.call (Void)
						end
						p := True
						event_fig := event_fig.group
					end
				end
				same_fig := event_fig
				if current_figure /= Void then
					from
						event_fig := current_figure
					until
						event_fig = Void or else event_fig = same_fig
					loop
						if event_fig.is_sensitive and attached event_fig.internal_pointer_enter_actions as l_actions then
							l_actions.call (Void)
						end
						p := True
						event_fig := event_fig.group
					end
				end
			end
			if p then
				project
			end
		ensure
			current_figure_assigned: current_figure = new_current_figure
		end

	mouse_move (x, y: INTEGER; x_tilt, y_tilt, pressure: DOUBLE;
		screen_x, screen_y: INTEGER)
			-- Fire events that belong to mouse movement.
			--| i.e. leave, enter, motion.
		local
			event_fig: detachable EV_FIGURE
			p: BOOLEAN
			w_x, w_y: INTEGER
		do
			w_x := x + area_x
			w_y := y + area_y
			has_mouse := True
			last_pointer_x := w_x
			last_pointer_y := w_y
			from
				event_fig := figure_on_position (world, w_x, w_y)
				change_current (event_fig)
			until
				event_fig = Void
			loop
				if event_fig.is_sensitive and attached event_fig.internal_pointer_motion_actions as l_actions then
					l_actions.call ([w_x - world.point.x, w_y - world.point.y, x_tilt, y_tilt,
						pressure, screen_x, screen_y])
				end
				event_fig := event_fig.group
				p := True
			end
			if p then
				project
			end
		end

	call_actions (f: EV_FIGURE; actions: detachable EV_LITE_ACTION_SEQUENCE [TUPLE]; arg: detachable TUPLE)
			-- Call `actions' on `f' with `arg' if `f' is sensitive.
		obsolete
			"Use `actions' directly. [2017-05-31]"
		do
			if actions /= Void and then f.is_sensitive then
				actions.call (arg)
			end
		end

	on_pebble_request (a_x, a_y: INTEGER): detachable ANY
			-- Pebble of current figure.
			-- If figure is `Void', return pebble of world.
			--| Because when a context menu is up, no events are sent
			--| to the world, first simulate a mouse motion to update
			--| the projection.
		local
			fig: detachable EV_FIGURE
		do
			mouse_move (a_x, a_y, 0.0, 0.0, 0.0, 0, 0)
			fig := current_figure
			if fig = Void then
				Result := world.real_pebble
			elseif fig.is_sensitive then
				from until Result /= Void or fig = Void loop
					Result := fig.real_pebble
					if Result = Void then
						fig := fig.group
					end
				end
				if Result /= Void and then fig /= Void then
					widget.set_accept_cursor (fig.accept_cursor)
					widget.set_deny_cursor (fig.deny_cursor)
				end
			end
		end

	on_drop_target_request (a_x, a_y: INTEGER): detachable EV_ABSTRACT_PICK_AND_DROPABLE
			-- Find actual drop target.
		local
			event_fig: detachable EV_FIGURE
			w_x, w_y: INTEGER
		do
			w_x := a_x + area_x
			w_y := a_y + area_y
			event_fig := figure_on_position (world, w_x, w_y)
			if event_fig = Void and then not world.drop_actions.is_empty then
				Result := world
			else
				from until Result /= Void or event_fig = Void loop
					if not event_fig.drop_actions.is_empty then
						Result := event_fig
					end
					event_fig := event_fig.group
				end
			end
		end

feature {NONE} -- Implementation

	axle_length: INTEGER = 15
			-- Length of x and y axles when points are displayed.

	project_rel_point (point: EV_RELATIVE_POINT)
			-- Draw representation of a point on canvas.
		local
			dx, dy: INTEGER
			nl: LINKED_LIST [EV_RELATIVE_POINT]
		do
			dx := (sine (point.angle_abs) * axle_length).rounded
			dy := (cosine (point.angle_abs) * axle_length).rounded
			if attached point.origin as l_point_origin then
				drawable.set_foreground_color (
					create {EV_COLOR}.make_with_rgb (0, 0, 1)
				)
				drawable.draw_segment (point.x_abs, point.y_abs,
					l_point_origin.x_abs, l_point_origin.y_abs)
			end
			drawable.set_foreground_color (
				create {EV_COLOR}.make_with_rgb (0, 1, 0)
			)
			drawable.draw_segment (point.x_abs, point.y_abs,
					point.x_abs - (sine (point.angle_abs) *
					axle_length * point.scale_y_abs).rounded,
					point.y_abs + (cosine (point.angle_abs) *
					axle_length * point.scale_y_abs).rounded)
			drawable.draw_segment (point.x_abs, point.y_abs,
					point.x_abs + (cosine (point.angle_abs) *
					axle_length * point.scale_x_abs).rounded,
					point.y_abs + (sine (point.angle_abs) *
					axle_length * point.scale_x_abs).rounded)
			nl := point.notify_list
			from
				nl.start
			until
				nl.after
			loop
				project_rel_point (nl.item)
				nl.forth
			end
		end

note
	copyright:	"Copyright (c) 1984-2017, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class EV_WIDGET_PROJECTOR





