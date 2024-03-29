﻿note
	description: "Draw half-tone lines (include rectangles) on windows."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2017-04-14 18:05:46 +0000 (Fri, 14 Apr 2017) $"
	revision: "$Revision: 100203 $"

class
	SD_LINE_DRAWER

create
	make

feature {NONE}  -- Initlization

	make
			-- Creation method
		do
			create internal_shared
			reset_screen
		end

feature -- Command

	draw_line_area (a_start_x, a_start_y, a_width, a_height: INTEGER)
			-- Draw a half-tone line on screen
		local
			l_dc: WEL_SCREEN_DC
			l_spliter_brush: WEL_BRUSH
		do
			create l_dc
			l_dc.get
			l_spliter_brush := half_tone_brush

			l_dc.select_brush (l_spliter_brush)
			-- We must use pattern to draw half tone feedback on Windows Vista
			-- Otherwise, when erasing the background will be whole black (Vista Aero theme enabled)
			l_dc.pat_blt (a_start_x, a_start_y, a_width, a_height, {WEL_RASTER_OPERATIONS_CONSTANTS}.patinvert)

			l_spliter_brush.dispose
			l_dc.dispose
		end

	draw_rectangle (left, top, width, height, line_width: INTEGER)
			-- Draw a rectangle on screen which center is blank
		require
			line_width_valid: line_width > 0
			width_positive: width > 0
			height_positive: height > 0
		do
			if internal_last_feedback_left /= 0 and internal_last_feedback_top /= 0
				and internal_last_feedback_width /= 0 and internal_last_feedback_height /= 0 then
				clear_last_feedback
			end
			internal_last_feedback_left := left
			internal_last_feedback_top := top
			internal_last_feedback_width := width
			internal_last_feedback_height := height

			draw_rectangle_internal (left, top, width, height, line_width)
		end

	reset_feedback_clearing
			-- Reset feedback's values to default
		do
			if internal_last_feedback_top /= 0 and internal_last_feedback_left /=0
				and internal_last_feedback_width /= 0 and internal_last_feedback_height /= 0 then
				clear_last_feedback
				internal_last_feedback_top := 0
				internal_last_feedback_left := 0
				internal_last_feedback_width := 0
				internal_last_feedback_height := 0
			end
		end

	reset_screen
			-- Because dc will change between user using Remote Desktop and normal video card
			-- So we need to recreate `internal_screen' to make sure line can be drawn
		do
			create internal_screen
		end

feature -- Query

	screen: EV_SCREEN
			-- Screen to draw
		do
			Result := internal_screen
		ensure
			not_void: Result /= Void
		end

feature {NONE} -- Implementation for draw_rectangle

	draw_rectangle_internal_top (a_start_x, a_start_y, a_width, a_height: INTEGER)
			-- Draw a vertical line on the screen
		local
			l_pixmap: like last_half_tone_pixmap_top
		do
			l_pixmap := last_half_tone_pixmap_top
			if l_pixmap = Void or else
				(l_pixmap.width /= a_width or l_pixmap.height /= a_height) then
				l_pixmap := half_tone_pixmap (a_width, a_height)
				last_half_tone_pixmap_top := l_pixmap
			end
			screen.set_invert_mode
			screen.draw_pixmap (a_start_x, a_start_y, l_pixmap)
		end

	draw_rectangle_internal_bottom (a_start_x, a_start_y, a_width, a_height: INTEGER)
			-- Draw a vertical line on the screen
		local
			l_pixmap: like last_half_tone_pixmap_bottom
		do
			l_pixmap := last_half_tone_pixmap_bottom
			if l_pixmap = Void or else
				(l_pixmap.width /= a_width or l_pixmap.height /= a_height) then
				l_pixmap := half_tone_pixmap (a_width, a_height)
				last_half_tone_pixmap_bottom := l_pixmap
			end
			screen.set_invert_mode
			screen.draw_pixmap (a_start_x, a_start_y, l_pixmap)
		end

	draw_rectangle_internal_left (a_start_x, a_start_y, a_width, a_height: INTEGER)
			-- Draw a vertical line on the screen
		local
			l_pixmap: like last_half_tone_pixmap_left
		do
			l_pixmap := last_half_tone_pixmap_left
			if l_pixmap = Void or else
				(l_pixmap.width /= a_width or l_pixmap.height /= a_height) then
				l_pixmap := half_tone_pixmap (a_width, a_height)
				last_half_tone_pixmap_left := l_pixmap
			end
			screen.set_invert_mode
			screen.draw_pixmap (a_start_x, a_start_y, l_pixmap)
		end

	draw_rectangle_internal_right (a_start_x, a_start_y, a_width, a_height: INTEGER)
			-- Draw a vertical line on the screen
		local
			l_pixmap: like last_half_tone_pixmap_right
		do
			l_pixmap := last_half_tone_pixmap_right
			if l_pixmap = Void or else
				(l_pixmap.width /= a_width or l_pixmap.height /= a_height) then
				l_pixmap := half_tone_pixmap (a_width, a_height)
				last_half_tone_pixmap_right := l_pixmap
			end
			screen.set_invert_mode
			screen.draw_pixmap (a_start_x, a_start_y, l_pixmap)
		end

	last_half_tone_pixmap_top, last_half_tone_pixmap_bottom, last_half_tone_pixmap_left, last_half_tone_pixmap_right: detachable EV_PIXMAP
			-- Pixmap last dran for `draw_rectangle'

feature {NONE} -- Implementation

	half_tone_pixmap (a_width, a_height: INTEGER): EV_PIXMAP
			-- Get a dot line pixmap
		require
			valid: a_width > 0 and a_height > 0
		local
			l_x,l_y: INTEGER
			l_white, l_black: EV_COLOR
			l_black_or_white: BOOLEAN
		do
			create l_white.make_with_rgb (1, 1, 1)
			create l_black.make_with_rgb (0, 0, 0)
			create Result.make_with_size (a_width, a_height)
			from
				l_x := 0
			until
				l_x > a_width
			loop
				from
					l_y := 0
				until
					l_y > a_height
				loop
					if l_black_or_white then
						Result.set_foreground_color (l_white)
					else
						Result.set_foreground_color (l_black)
					end
					Result.draw_point (l_x, l_y)
					l_y := l_y + 1
					l_black_or_white := not l_black_or_white
				end
				l_x := l_x + 1
				if a_height \\ 2 /= 0 then
					l_black_or_white := not l_black_or_white
				end
			end
		ensure
			not_void: Result /= Void
		end

	internal_last_feedback_left, internal_last_feedback_top, internal_last_feedback_width, internal_last_feedback_height: INTEGER

	clear_last_feedback
			-- Clear last drawn feedback rectangle
		do
			draw_rectangle_internal (internal_last_feedback_left, internal_last_feedback_top, internal_last_feedback_width, internal_last_feedback_height, internal_shared.line_width)
		end

	draw_rectangle_internal (a_left, a_top, a_width, a_height, a_line_width: INTEGER)
			-- Draw half-tone rectangle feedback
		require
			valid: a_line_width > 0
		do
			-- Draw window area, top one
			draw_rectangle_internal_top (a_left, a_top, a_width, a_line_width)
			-- Draw window area, bottom one
			draw_rectangle_internal_bottom (a_left, a_top + a_height - a_line_width, a_width, a_line_width)
			-- Draw window area, left one
			draw_rectangle_internal_left (a_left, a_top + a_line_width, a_line_width, a_height - 2 * a_line_width)
			-- Draw window area, right one
			draw_rectangle_internal_right (a_left + a_width - a_line_width, a_top + a_line_width, a_line_width, a_height - 2 * a_line_width)
		end

feature {NONE}  -- Implementation

 	half_tone_brush: WEL_BRUSH
			-- Create the brush to draw resize bar feedback.
		do
			Result := (create {WEL_BITMAP_HELPER}).half_tone_brush
		ensure
			not_void: Result /= Void
		end

	internal_screen: EV_SCREEN
			-- Internal screen instance, one instance per a dragging process

	internal_shared: SD_SHARED;
			-- All singletons

note
	library:	"SmartDocking: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2017, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"






end
