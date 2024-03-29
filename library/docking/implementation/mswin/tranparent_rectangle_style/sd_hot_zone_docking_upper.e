﻿note
	description: "SD_HOT_ZONE for SD_DOCKING_ZONE_UPPER."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2017-04-14 18:05:46 +0000 (Fri, 14 Apr 2017) $"
	revision: "$Revision: 100203 $"

class
	SD_HOT_ZONE_DOCKING_UPPER

inherit
	SD_HOT_ZONE_DOCKING
		redefine
			update_feedback
		end

create
	make

feature {NONE} -- Redefine

	update_feedback (a_screen_x, a_screen_y: INTEGER; a_rect: EV_RECTANGLE)
			-- <Precursor>, draw tab recangle on top.
		local
			l_shared: like internal_shared
			l_center_rect, l_top_rect: EV_RECTANGLE
		do
			l_shared := internal_shared
			if a_rect = internal_rectangle_left then
				l_shared.feedback.draw_transparency_rectangle (internal_rectangle.left, internal_rectangle.top, (internal_rectangle.width* 0.5).ceiling, internal_rectangle.height )
			elseif a_rect = internal_rectangle_right then
				l_shared.feedback.draw_transparency_rectangle (internal_rectangle.right - (internal_rectangle.width * 0.5).ceiling, internal_rectangle.top, (internal_rectangle.width* 0.5).ceiling, internal_rectangle.height )
			elseif a_rect = internal_rectangle_top then
				l_shared.feedback.draw_transparency_rectangle (internal_rectangle .left, internal_rectangle.top, internal_rectangle.width, (internal_rectangle.height * 0.5).ceiling)
			elseif a_rect = internal_rectangle_bottom then
				l_shared.feedback.draw_transparency_rectangle (internal_rectangle .left, internal_rectangle.bottom - (internal_rectangle.height * 0.5).ceiling, internal_rectangle.width, (internal_rectangle.height * 0.5).ceiling)
			elseif a_rect = internal_rectangle_center or a_rect = internal_rectangle_title_area then
				create l_center_rect.make (internal_rectangle.left, internal_rectangle.top + l_shared.title_bar_height, internal_rectangle.width, internal_rectangle.height - l_shared.title_bar_height)
				create l_top_rect.make (internal_rectangle.left + l_shared.title_bar_height, internal_rectangle.top, l_shared.title_bar_height * 3, l_shared.title_bar_height)
				l_shared.feedback.draw_transparency_rectangle_for_tab (l_top_rect, l_center_rect)
			end
		end

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
