note
	description: "Objects that represent the zone when docking in SD_MULTI_DOCK_AREA."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2013-01-22 22:19:10 +0000 (Tue, 22 Jan 2013) $"
	revision: "$Revision: 90796 $"

deferred class
	SD_DOCKING_ZONE

inherit
	EV_CELL
		rename
			has as has_cell,
			extend as extend_cell
		end

	SD_SINGLE_CONTENT_ZONE
		redefine
			close
		end

	SD_DOCKER_SOURCE
		undefine
			copy, is_equal, default_create
		end

	SD_TITLE_BAR_REMOVEABLE
		undefine
			copy, is_equal, default_create
		end

feature -- Command

	set_title (a_title: READABLE_STRING_GENERAL)
			-- Set title
		require
			not_void: a_title /= Void
		deferred
		end

	set_pixmap (a_pixmap: EV_PIXMAP)
			-- Set pixmap
		require
			not_void: a_pixmap /= Void
		do
		end

	close
			-- <Precursor>
		do
			docking_manager.command.lock_update (Current, False)
			Precursor {SD_SINGLE_CONTENT_ZONE}
			docking_manager.zones.prune_zone (Current)
			docking_manager.command.unlock_update
		end

	update_user_widget
			-- If `content''s user_widget changed, we update containers
		do
		end

	update_mini_toolbar
			-- If `content''s mini toolbar changed, we update containers
		do
		end

feature -- Query

	title: STRING_32
			-- Title
		deferred
		end

	title_area: EV_RECTANGLE
			-- Title area
		deferred
		ensure
			not_void: Result /= Void
		end

	is_parent_split: BOOLEAN
			-- Is parent a split area?
		do
			Result := attached {EV_SPLIT_AREA} parent
		end

	parent_split_position: INTEGER
			-- If parent is split area, get split position
		require
			parent_is_split_area: is_parent_split
		do
			if attached {EV_SPLIT_AREA} parent as l_split_area then
				-- Implied by precondition `ready'
				Result := l_split_area.split_position
			end
		end

feature {NONE} -- For redocker

	on_drag_started (a_x: INTEGER; a_y: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER)
			-- Create a SD_DOCKER_MEDIATOR, start hanlde pointer motion
		local
			l_docker_mediator: like docker_mediator
		do
			debug ("docking")
				io.put_string ("%N ******** draging window in SD_DOCKING_ZONE " + a_screen_x.out + " " + a_screen_y.out + "and window width height is: " + width.out + " " + height.out)
			end
			-- We should check if `docker_mediator' is void since `on_drag_started' will be called multi times when starting dragging on GTK
			l_docker_mediator := docker_mediator
			if l_docker_mediator = Void then
				l_docker_mediator := docking_manager.query.docker_mediator (Current, docking_manager)
				docker_mediator := l_docker_mediator
				l_docker_mediator.cancel_actions.extend (agent on_cancel_dragging)
				l_docker_mediator.start_tracing_pointer (a_screen_x - screen_x, a_screen_y - screen_y)
				internal_shared.setter.before_enable_capture
				enable_capture
			end
		end

	on_pointer_release (a_x, a_y, a_button: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER)
			-- Stop SD_DOCKER_MEDIATOR
		do
			if attached docker_mediator as l_docker_mediator then
				disable_capture
				internal_shared.setter.after_disable_capture
				l_docker_mediator.end_tracing_pointer (a_screen_x, a_screen_y)
				docker_mediator := Void
			end
		end

	on_pointer_motion (a_x, a_y: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER)
			-- Forward pointer motion data to SD_DOCKER_MEDIATOR
		do
			if attached docker_mediator as l_docker_mediator and then l_docker_mediator.is_tracing then
				l_docker_mediator.on_pointer_motion (a_screen_x,  a_screen_y)
			end
		end

	on_cancel_dragging
			-- Handle cancel dragging from SD_DOCKER_MEDIATOR
		do
			disable_capture
			internal_shared.setter.after_disable_capture
			docker_mediator := Void
		end

	docker_mediator: detachable SD_DOCKER_MEDIATOR
			-- Mediator perform dock

;note
	library:	"SmartDocking: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2012, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"






end
