﻿note
	description: "A dialog hold SD_TOOL_BAR_ZONE when it floating."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2017-04-14 18:05:46 +0000 (Fri, 14 Apr 2017) $"
	revision: "$Revision: 100203 $"

class
	SD_FLOATING_TOOL_BAR_ZONE

inherit
	SD_WINDOW
		rename
			show as show_allow_to_back,
			extend as extend_to_dialog,
			has as has_dialog,
			wipe_out as wipe_out_dialog
		export
			{NONE} all
			{ANY} destroy, screen_x, screen_y, has_recursive, is_destroyed, prune, set_position, set_size, prunable
			{ANY} lock_update, unlock_update, ev_application, shared_environment
			{SD_FLOATING_TOOL_BAR_ZONE_ASSISTANT, SD_TOOL_BAR} minimum_width, minimum_height, resize_actions
			{SD_TOOL_BAR_MANAGER, SD_TOOL_BAR_CONTENT} hide, is_displayed
		redefine
			create_implementation
		end

	SD_ACCESS
		undefine
			default_create,
			is_equal,
			copy
		end

create
	make

feature {NONE} -- Initlization

	make (a_docking_manager: SD_DOCKING_MANAGER)
			-- Creation method
		require
			a_docking_manager_not_void: a_docking_manager /= Void
		local
			l_pixmaps: EV_STOCK_PIXMAPS
		do
			create internal_shared
			internal_docking_manager := a_docking_manager
			create internal_title_bar.make
			create l_pixmaps
			create internal_padding_box
			create {EV_VERTICAL_BOX} internal_border_box

			default_create

			create assistant.make (Current)

			disable_user_resize

			init_border_box

			internal_padding_box.set_border_width (1)
			internal_padding_box.set_padding_width (1)
			internal_padding_box.set_pointer_style (l_pixmaps.standard_cursor)
			internal_border_box.extend (internal_padding_box)

			internal_title_bar.pointer_double_press_actions.extend (agent recover_docking_state)
			internal_title_bar.close_request_actions.extend (agent on_close_request)
			internal_title_bar.custom_actions.extend (agent on_customize)
			internal_padding_box.extend (internal_title_bar)
			internal_padding_box.disable_item_expand (internal_title_bar)

			last_group_count := 1

			accelerators.append (internal_docking_manager.main_window.accelerators)
		ensure
			set: internal_docking_manager = a_docking_manager
		end

	create_implementation
			-- <Precursor>
		do
			Precursor
			create assistant.make (Current)
		end

	init_border_box
			-- Initialize `internal_border_box'
		do
			internal_border_box.set_border_width (internal_border_width)
			internal_border_box.set_background_color (internal_shared.tool_bar_title_bar_color)
			extend_to_dialog (internal_border_box)
			internal_border_box.pointer_motion_actions.extend (agent on_border_box_pointer_motion)
			internal_border_box.pointer_button_press_actions.extend (agent on_border_pointer_press)
			internal_border_box.pointer_button_release_actions.extend (agent on_border_pointer_release)
		end

feature -- Command

	show
			-- Show `Current'
		do
			if internal_shared.allow_window_to_back then
				show_allow_to_back
			else
				show_relative_to_window (internal_docking_manager.main_window)
			end
		ensure
			shown: is_displayed
		end

	extend (a_tool_bar_zone: SD_TOOL_BAR_ZONE)
			-- Extend `a_tool_bar_zone'
		require
			a_tool_bar_zone_not_void: a_tool_bar_zone /= Void
			a_tool_bar_zone_horizontal: not a_tool_bar_zone.is_vertical
			a_tool_bar_zone_parent_void: attached {EV_WIDGET} a_tool_bar_zone.tool_bar as lt_widget implies lt_widget.parent = Void
			not_extended: not is_tool_bar_zone_set
		do
			zone := a_tool_bar_zone
			tool_bar := a_tool_bar_zone.tool_bar
			if attached {EV_WIDGET} a_tool_bar_zone.tool_bar as lt_widget_2 then
				internal_padding_box.extend (lt_widget_2)
			else
				check not_possible: False end
			end

			internal_content := a_tool_bar_zone.content

			internal_title_bar.set_content (content)

			if attached a_tool_bar_zone.agents as a then
				internal_title_bar.drawing_area.pointer_button_press_actions.extend (agent a.on_drag_area_pressed)
				internal_title_bar.drawing_area.pointer_button_release_actions.extend (agent a.on_drag_area_release)
				internal_title_bar.drawing_area.pointer_motion_actions.extend (agent a.on_drag_area_motion)
			end

			create group_divider.make_with_content (content)
		ensure
			set: content = a_tool_bar_zone.content
			set: zone = a_tool_bar_zone
			set: is_tool_bar_zone_set
		end

	regroup_after_customize
			-- Initlized group divider and regroup items
		require
			ready: is_tool_bar_zone_set
		local
			l_group_count: INTEGER
			l_height: INTEGER
			l_has_lock_window: BOOLEAN
			l_group_divider: like group_divider
		do
			if attached tool_bar as l_tool_bar then
				create l_group_divider.make_with_content (content)
				group_divider := l_group_divider
				-- `l_height' is the height of inner SD_TOOL_BAR, EXCEPT the heights:
				-- 1. floating zone title bar height (the height between the border and the tool bar buttons)
				-- 2. border height of floating tool bar zone (one if up side border, another is bottom side border)
				l_height := height -  (l_tool_bar.screen_y - screen_y) - internal_border_box.border_width * 2
				check positive: l_height > 0 end
				l_group_count := group_count_by_height (l_height)
				if attached (create {EV_ENVIRONMENT}).application as l_app then
					l_has_lock_window := l_app.locked_window /= Void
				else
					check False end -- Implied by current application is running
				end

				if not l_has_lock_window then
					lock_update
				end

				if l_group_count > 0 and then attached l_group_divider.best_grouping (l_group_count) as l_best_grouping then
					assistant.position_groups (l_best_grouping)
				else
					assistant.to_minmum_size
				end
				last_group_count := l_group_count

				if not l_has_lock_window then
					unlock_update
				end
			else
				check from_precondition_ready: False end
			end
		end

feature -- Query

	zone: detachable SD_TOOL_BAR_ZONE
			-- Tool bar zone Current managed (if any).

	has (a_tool_bar_zone: EV_WIDGET): BOOLEAN
			-- Has a_tool_bar_zone?
		require
			not_void: a_tool_bar_zone /= Void
		do
			Result := internal_padding_box.has (a_tool_bar_zone)
		end

	content: SD_TOOL_BAR_CONTENT
			-- attached `internal_content'
		require
			ready: is_tool_bar_zone_set
		do
			Result := internal_content
			check from_precondition_ready: attached Result then end
		ensure
			not_void: Result /= Void
		end

	assistant: SD_FLOATING_TOOL_BAR_ZONE_ASSISTANT
			-- Assistant to position items

	tool_bar: detachable SD_GENERIC_TOOL_BAR
			-- SD_TOOL_BAR where contain SD_TOOL_BAR_ITEMs (if any).

	is_tool_bar_zone_set: BOOLEAN
			-- If `tool_bar', `zone' and `content' have been set?
		do
			Result := attached tool_bar and attached zone and attached internal_content
		end

feature {NONE} -- Implementation of resize issues

	on_border_box_pointer_motion (a_x: INTEGER; a_y: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER)
			-- Handle border box pointer motion
		local
			l_temp_group_count: INTEGER
			l_temp_group_info: SD_TOOL_BAR_GROUP_INFO
			l_pointer_offset: INTEGER
			l_old_position: INTEGER
		do
			if not internal_border_box.has_capture then
				on_border_pointer_motion_no_capture (a_x, a_y)
			elseif content.items_visible.count > 0 then
				if
					attached group_divider as l_group_divider and
					attached tool_bar as l_tool_bar
				then
					inspect
						internal_pointer_direction
					when {SD_ENUMERATION}.left then
						l_old_position := screen_x + width
						l_pointer_offset := (screen_x + width) - a_screen_x
						if l_pointer_offset > 0 then
							if start_width < l_pointer_offset then
								l_temp_group_info := l_group_divider.best_grouping_by_width_to_right (l_pointer_offset)
							else
								l_temp_group_info := l_group_divider.best_grouping_by_width_to_left (l_pointer_offset)
							end

							l_temp_group_count := l_group_divider.last_group_index
							if l_temp_group_count /= last_group_count then
								lock_update
								assistant.position_groups (l_temp_group_info)
								last_group_count := l_group_divider.last_group_index
								set_x_position (l_old_position - width)
								unlock_update
							end
						end
					when {SD_ENUMERATION}.right then
						if a_screen_x - screen_x > 0 then
							if start_width < a_screen_x - screen_x then
								l_temp_group_info := l_group_divider.best_grouping_by_width_to_right (a_screen_x - screen_x)
							else
								l_temp_group_info := l_group_divider.best_grouping_by_width_to_left (a_screen_x - screen_x)
							end
							l_temp_group_count := l_group_divider.last_group_index
							if l_temp_group_count /= last_group_count then
								assistant.position_groups (l_temp_group_info)
								last_group_count := l_group_divider.last_group_index
							end
						end
					when {SD_ENUMERATION}.top then
						l_old_position := screen_y + height
						l_pointer_offset := screen_y + height - a_screen_y - (l_tool_bar.screen_y - screen_y)
						if l_pointer_offset > 0  then
							l_temp_group_count := group_count_by_height (l_pointer_offset)
							if
								l_temp_group_count /= last_group_count and
								l_temp_group_count > 1 and
								l_temp_group_count <= l_group_divider.max_row_count and then
								attached l_group_divider.best_grouping (l_temp_group_count) as l_best_grouping
							then
								lock_update
								assistant.position_groups (l_best_grouping)
								last_group_count := l_temp_group_count
								set_y_position (l_old_position - height)
								unlock_update
							end
						end
					when {SD_ENUMERATION}.bottom then
						l_pointer_offset := a_screen_y - l_tool_bar.screen_y
						if l_pointer_offset > 0 then
							l_temp_group_count := group_count_by_height (l_pointer_offset)
							if
								l_temp_group_count /= last_group_count and
								l_temp_group_count > 1 and
								l_temp_group_count <= l_group_divider.max_row_count and then
								attached l_group_divider.best_grouping (l_temp_group_count) as l_best_grouping
							then
								debug ("docking")
									print ("%N SD_FLOATING_TOOL_BAR_ZONE on_border_box_pointer_motion bottom dragging:")
									print ("%N        l_temp_group_count: " + l_temp_group_count.out)
									print ("%N        last_group_count: " + last_group_count.out)
									print ("%N        max_row_count: " + l_group_divider.max_row_count.out)
								end
								assistant.position_groups (l_best_grouping)
								last_group_count := l_temp_group_count
								debug ("docking")
									print ("%N        postion tool bar items")
									print ("%N        group infos: " + l_best_grouping.out)
								end
							end
						end
					else
						-- It maybe just initialized Current
					end
				end
			end
		end

	group_count_by_height (a_pointer_height: INTEGER): INTEGER
			-- Group count base on `a_pointer_height'
		require
			valid: a_pointer_height > 0
			ready: is_tool_bar_zone_set
		local
			l_total_height_without_subgroup: INTEGER
			l_temp_height: INTEGER
			l_item_count: INTEGER
			l_row_height: INTEGER
			n: INTEGER
		do
			if
				attached tool_bar as l_tool_bar and then
				attached zone as l_zone and then
				attached l_zone.content as l_content
			then
				n := l_content.groups_count (False)
				l_total_height_without_subgroup := n * l_tool_bar.row_height + (n - 1) * {SD_TOOL_BAR_SEPARATOR}.width
				if a_pointer_height <= l_total_height_without_subgroup then
					Result := a_pointer_height // (l_tool_bar.row_height + {SD_TOOL_BAR_SEPARATOR}.width) + 1
				else
					l_temp_height := a_pointer_height - (n - 1) * {SD_TOOL_BAR_SEPARATOR}.width
					check valid: l_temp_height > 0 end
					l_row_height := l_tool_bar.row_height
					if l_row_height = 0 then
						-- If tool bar don't have items
						l_row_height := l_tool_bar.standard_height
					end
					Result := l_temp_height // l_row_height + 1
				end

				l_item_count := content.item_count_except_sep (False)
				if Result > l_item_count then
					Result := l_item_count
				elseif Result = 0 then
					Result := 1
				end

				debug ("docking")
					print ("%N SD_FLOATING_TOOL_BAR_ZONE group_count_by_height Result: " + Result.out)
				end
			else
				check from_precondition_ready: False end
			end
		ensure
			valid: 0 <= Result and Result <= content.item_count_except_sep (False)
		end

	last_group_count: INTEGER
			-- Group index for last pointer motion

	on_border_pointer_motion_no_capture (a_x, a_y: INTEGER)
			-- Handle pointer motion actions when not has capture
		require
			not_capture: not internal_border_box.has_capture
		local
			l_styles: EV_STOCK_PIXMAPS
		do
			create l_styles
			if 0 <= a_x and a_x <= internal_border_width then
				internal_pointer_direction := {SD_ENUMERATION}.left
			elseif (internal_border_box.width - internal_border_width) <= a_x and a_x <= internal_border_box.width then
				internal_pointer_direction := {SD_ENUMERATION}.right
			elseif 0 <= a_y and a_y <= internal_border_width then
				internal_pointer_direction := {SD_ENUMERATION}.top
			else
				internal_pointer_direction := {SD_ENUMERATION}.bottom
			end
			if internal_pointer_direction = {SD_ENUMERATION}.left or internal_pointer_direction = {SD_ENUMERATION}.right then
				internal_border_box.set_pointer_style (l_styles.sizewe_cursor)
			else
				internal_border_box.set_pointer_style (l_styles.sizens_cursor)
			end
		end

	on_border_pointer_press (a_x: INTEGER; a_y: INTEGER; a_button: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER)
			-- Handle pointer press actions
		do
			if a_button = {EV_POINTER_CONSTANTS}.left then
				internal_shared.setter.before_enable_capture
				internal_border_box.enable_capture
				start_width := width
			end
		end

	on_border_pointer_release (a_x: INTEGER; a_y: INTEGER; a_button: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER)
			-- Handle pointer release actions
		do
			if internal_border_box.has_capture then
				internal_border_box.disable_capture
				internal_shared.setter.after_disable_capture
			end
		end

	internal_pointer_direction: INTEGER
			-- Pointer direction, one value of SD_DOCKING_MANAGER dock_top, dock_bottom, dock_left, dock_right
			-- Used when user dragging Current border

	internal_content: detachable SD_TOOL_BAR_CONTENT
			-- Content which Current managed

	internal_zone: detachable SD_TOOL_BAR_ZONE
			-- Tool bar zone Current managed

feature {SD_FLOATING_TOOL_BAR_ZONE_ASSISTANT, SD_TOOL_BAR_DRAGGING_AGENTS} -- Implementation

	recover_docking_state
			-- Recover to orignal docking state
		require
			ready: is_tool_bar_zone_set
		do
			if attached zone as l_zone then
					-- First we record floating states.
					-- SD_TOOL_BAR_GROUP_INFO is already recorded when grouping.
				l_zone.assistant.last_state.set_screen_x (screen_x)
				l_zone.assistant.last_state.set_screen_y (screen_y)
				l_zone.assistant.dock_last_state
			else
				check from_precondition_ready: False end
			end
		end

	start_width: INTEGER
			-- Window width when starting dragging

	group_divider: detachable SD_TOOL_BAR_GROUP_DIVIDER
			-- Divider to divide tool bar groups

	internal_title_bar: SD_TOOL_BAR_TITLE_BAR
			-- Title bar

	internal_border_box: EV_BOX
			-- Border box surround target tool bar

	internal_padding_box: EV_VERTICAL_BOX
			-- Box to show padding

	internal_border_width: INTEGER = 2
			-- Border width

	internal_docking_manager: SD_DOCKING_MANAGER
			-- Docking manager manage Current

	internal_shared: SD_SHARED
			-- All singletons

feature {NONE} -- Implementation

	on_close_request
			-- Handle close request actions
		do
			content.close_request_actions.call (Void)
		end

	on_customize
			-- Handle customize actions
		require
			ready: is_tool_bar_zone_set
		local
			l_dialog: SD_TOOL_BAR_HIDDEN_ITEM_DIALOG
			l_helper: SD_POSITION_HELPER
			l_rect: EV_RECTANGLE
		do
			if attached zone as l_zone then
				create l_dialog.make (create {ARRAYED_LIST [SD_TOOL_BAR_ITEM]}.make (1), l_zone)
				create l_helper.make
				l_rect := internal_title_bar.custom_rectangle
				l_helper.set_tool_bar_floating_dialog_position (l_dialog, l_rect.x, l_rect.y, l_rect.width, l_rect.height)
				l_dialog.show
			else
				check from_precondition_ready: False end
			end
		end

invariant

	internal_shared_not_void: internal_shared /= Void
	internal_title_bar_not_void: internal_title_bar /= Void

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
