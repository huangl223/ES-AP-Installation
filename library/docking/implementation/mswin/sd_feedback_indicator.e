﻿note
	description: "Objecs that use layered windows to feedback display indicators"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2017-02-26 14:18:00 +0000 (Sun, 26 Feb 2017) $"
	revision: "$Revision: 99858 $"

class
	SD_FEEDBACK_INDICATOR

inherit
	EV_POPUP_WINDOW
		redefine
			show,
			set_position,
			implementation,
			create_implementation
		end

	EV_ANY_HANDLER
		undefine
			default_create,
			copy
		end

	EV_SHARED_APPLICATION
		undefine
			default_create,
			copy
		end

create
	make,
	make_for_splash

feature {NONE} -- Initlization

	make (a_pixel_buffer: attached like pixel_buffer; a_parent_window: EV_WINDOW)
			-- Creation method.
		require
			not_void: a_pixel_buffer /= Void
		do
			default_create
			if attached {WEL_COMPOSITE_WINDOW} a_parent_window.implementation as l_composite_window then
				-- FIXME [20130404] rewrite that code to hide this and put that in the implementation.init_common code.
				implementation.init_common (a_pixel_buffer, l_composite_window)
			end
		ensure
			set: pixel_buffer = a_pixel_buffer
		end

	make_for_splash (a_pixel_buffer: attached like pixel_buffer)
			-- Creation method for splash screen.
		require
			not_void: a_pixel_buffer /= Void
		do
			default_create
			if attached {EV_APPLICATION_IMP} ev_application.implementation as l_app_imp then
				implementation.init_common (a_pixel_buffer, l_app_imp.silly_main_window)
			end
		end

feature -- Command

	show
			-- Show current with fading effect if possible
		do
			implementation.show
			if attached shared_environment.application as application then
				application.register_window (Current)
			end
		end

	set_pixel_buffer (a_pixel_buffer: like pixel_buffer)
			-- Set `pixel_buffer'
		do
			implementation.set_pixel_buffer (a_pixel_buffer)
		ensure
			set: pixel_buffer = a_pixel_buffer
		end

	set_position (a_screen_x, a_screen_y: INTEGER)
			-- Set position
		do
			implementation.set_position (a_screen_x, a_screen_y)
		end

	clear
			-- Disappear with fading effect.
		require
			exists: exists
		do
			implementation.clear
			if attached shared_environment.application as application then
				application.unregister_window (Current)
			end
		end

feature -- Query

	pixel_buffer: detachable EV_PIXEL_BUFFER
			-- Pixmap to show
		do
			Result := implementation.pixel_buffer
		end

	exists: BOOLEAN
			-- Does the OS native pointer exist?
		do
			Result := implementation.exists
		end

	create_implementation
			-- <Precursor>
		do
			create {SD_FEEDBACK_INDICATOR_IMP} implementation.make
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	implementation: SD_FEEDBACK_INDICATOR_I
			-- <Precursor>

;note
	library:	"SmartDocking: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2016, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
