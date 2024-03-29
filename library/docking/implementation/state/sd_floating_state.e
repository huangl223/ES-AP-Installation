﻿note
	description: "SD_STATE that manage SD_FLOATING_ZONE."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2018-12-18 18:07:47 +0000 (Tue, 18 Dec 2018) $"
	revision: "$Revision: 102628 $"

class
	SD_FLOATING_STATE

inherit
	SD_STATE
		redefine
			change_zone_split_area,
			stick,
			move_to_docking_zone,
			move_to_tab_zone,
			record_state
		end

create
	make

feature {NONE} -- Initlization

	make (a_screen_x, a_screen_y: INTEGER; a_docking_manager: SD_DOCKING_MANAGER; a_visible: BOOLEAN)
			-- Creation method
		require
			a_docking_manager_not_void: a_docking_manager /= Void
		do
			set_docking_manager (a_docking_manager)
			create internal_zone.make (a_docking_manager)
			internal_zone.set_position (a_screen_x, a_screen_y)
			docking_manager.command.add_inner_container (internal_zone.inner_container)
			internal_zone.set_floating_state (Current)
			if a_visible then
				internal_zone.show
			end
			initialized := True
		ensure
			set: docking_manager = a_docking_manager
		end

feature  -- States report

	value: INTEGER
		do
			check should_not_be_called: False end
		end

feature -- Redefine

	dock_at_top_level (a_multi_dock_area: SD_MULTI_DOCK_AREA)
			-- <Precursor>
		local
			l_widget: EV_WIDGET
			l_split_area: EV_SPLIT_AREA
			l_main_container_widget: EV_WIDGET
		do
			docking_manager.command.lock_update (a_multi_dock_area, False)
			set_all_zones_direction (direction)
			l_widget := internal_zone.inner_container.item
			internal_zone.inner_container.wipe_out

			if 	direction	= {SD_ENUMERATION}.left or direction = {SD_ENUMERATION}.right then
				l_split_area := create {SD_HORIZONTAL_SPLIT_AREA}
			else
				l_split_area := create {SD_VERTICAL_SPLIT_AREA}
			end
			l_main_container_widget := docking_manager.query.inner_container_main.item
			docking_manager.query.inner_container_main.save_spliter_position (l_main_container_widget, generating_type.name_32 + {STRING_32} ".dock_at_top_level")
			docking_manager.query.inner_container_main.wipe_out
			docking_manager.query.inner_container_main.extend (l_split_area)
			if direction = {SD_ENUMERATION}.left or direction = {SD_ENUMERATION}.top then
				l_split_area.set_first (l_widget)
				l_split_area.set_second (l_main_container_widget)
			else
				l_split_area.set_second (l_widget)
				l_split_area.set_first (l_main_container_widget)
			end
			if l_split_area.full then
				l_split_area.set_split_position (top_split_position (direction, l_split_area))
			end
			docking_manager.query.inner_container_main.restore_spliter_position (l_main_container_widget, generating_type.name_32 + {STRING_32} ".dock_at_top_level")
			docking_manager.command.unlock_update
			docking_manager.command.update_title_bar
		end

	stick (a_direction: INTEGER)
			-- <Precursor>
		do
		end

	change_zone_split_area (a_target_zone: SD_ZONE; a_direction: INTEGER)
			-- <Precursor>
		local
			l_current_item: EV_WIDGET
		do
			l_current_item := inner_container.item
			if attached {SD_ZONE} l_current_item as l_zone then
				l_zone.state.change_zone_split_area (a_target_zone, a_direction)
			else
				change_zone_split_area_whole_content (a_target_zone, a_direction)
			end
			docking_manager.command.update_title_bar
		end

	move_to_docking_zone (a_target_zone: SD_DOCKING_ZONE; a_first: BOOLEAN)
			-- <Precursor>
		local
			l_zones: ARRAYED_LIST [SD_ZONE]
			l_tab_zone, l_tab_zone_source: detachable SD_TAB_ZONE
		do
			docking_manager.command.lock_update (a_target_zone, False)

			l_zones := inner_container.zones
			from
				l_zones.start
			until
				l_zones.after
			loop
				if attached {SD_TAB_ZONE} l_zones.item as l_item_tab_zone then
					l_tab_zone_source := l_item_tab_zone
					l_tab_zone_source.set_drag_title_bar (True)
				end

				if l_tab_zone = Void then
					l_zones.item.state.move_to_docking_zone (a_target_zone, a_first)
					if
						a_target_zone.has_content and then
						attached {SD_TAB_ZONE} a_target_zone.content.state.zone as z then
						l_tab_zone := z
					else
						check is_tab_zone: False end
					end
				else
					if a_first then
						l_zones.item.state.move_to_tab_zone (l_tab_zone, 1)
					else
						l_zones.item.state.move_to_tab_zone (l_tab_zone, 0)
					end
				end

				if l_tab_zone_source /= Void then
					l_tab_zone_source.set_drag_title_bar (False)
				end
				l_zones.forth
			end
			docking_manager.command.update_title_bar
			docking_manager.command.unlock_update
		end

	move_to_tab_zone (a_target_zone: SD_TAB_ZONE; a_index: INTEGER)
			-- <Precursor>
		local
			l_zones: ARRAYED_LIST [SD_ZONE]
			l_tab_zone_source: detachable SD_TAB_ZONE
		do
			if attached {EV_WIDGET} zone as lt_widget then
				docking_manager.command.lock_update (lt_widget, False)
			else
				check not_possible: False end
			end

			l_zones := inner_container.zones
			from
				l_zones.start
			until
				l_zones.after
			loop
				if attached {SD_TAB_ZONE} l_zones.item as z then
					l_tab_zone_source := z
					l_tab_zone_source.set_drag_title_bar (True)
				end

				l_zones.item.state.move_to_tab_zone (a_target_zone, 0)

				if l_tab_zone_source /= Void then
					l_tab_zone_source.set_drag_title_bar (False)
				end
				l_zones.forth
			end

			docking_manager.command.update_title_bar
			docking_manager.command.unlock_update
		end

	record_state
			-- <Precursor>
		do
			last_floating_width := internal_zone.width
			last_floating_height := internal_zone.height
		end

	content_void: BOOLEAN
			-- <Precursor>
		do
			Result := not internal_zone.inner_container.readable
		end

	internal_zone: SD_FLOATING_ZONE
			-- <Precursor>

	zone: SD_ZONE
			-- <Precursor>
		do
			Result := internal_zone
		end

	set_user_widget (a_widget: EV_WIDGET)
			-- <Precursor>
		do
			-- Do nothing
		end

	set_mini_toolbar (a_toolbar: EV_WIDGET)
			-- <Precursor>
		do
			-- Do nothing
		end

feature -- Command

	update_title_bar
			-- Update title bar
		do
			internal_zone.update_title_bar
		end

	set_size (a_width, a_height: INTEGER)
			-- Set floating zone size
		do
			internal_zone.set_size (a_width, a_height)
			last_floating_width := a_width
			last_floating_height := a_height
		end

feature -- Query

	inner_container: SD_MULTI_DOCK_AREA
			-- Main container of Current
		do
			Result := internal_zone.inner_container
		ensure
			not_void: Result /= Void
		end

feature {NONE} -- Implementation

	set_all_zones_direction (a_direction: INTEGER)
			-- Set all zones direction
		local
			l_zones: ARRAYED_LIST [SD_ZONE]
		do
			l_zones := inner_container.zones
			from
				l_zones.start
			until
				l_zones.after
			loop
				l_zones.item.state.set_direction (a_direction)
				l_zones.forth
			end
		end

	change_zone_split_area_whole_content (a_target_zone: SD_ZONE; a_direction: INTEGER)
			-- Change whole floating zone contents to `a_target_zone'
		require
			a_target_zone_not_void: a_target_zone /= Void
			a_direction_valid: a_direction = {SD_ENUMERATION}.top or a_direction = {SD_ENUMERATION}.bottom
				or a_direction = {SD_ENUMERATION}.left or a_direction = {SD_ENUMERATION}.right
		local
			l_spliter: EV_SPLIT_AREA
			l_target_split: detachable EV_SPLIT_AREA
			l_target_split_position: INTEGER
		do
			if
				attached {EV_SPLIT_AREA} inner_container.item as l_current_item and then
				attached {EV_WIDGET} a_target_zone as l_widget and then
				attached l_widget.parent as l_container
			then
				inner_container.save_spliter_position (l_current_item, generating_type.name_32 + {STRING_32} ".change_zone_split_area_whole_content")
				if attached {EV_SPLIT_AREA} l_container as spl then
					l_target_split	:= spl
					l_target_split_position := l_target_split.split_position
				end
				l_container.prune_all (l_widget)
				inner_container.wipe_out

				if a_direction = {SD_ENUMERATION}.left or a_direction = {SD_ENUMERATION}.right then
					l_spliter := create {SD_HORIZONTAL_SPLIT_AREA}
				else
					l_spliter := create {SD_VERTICAL_SPLIT_AREA}
				end

				if a_direction = {SD_ENUMERATION}.left or a_direction = {SD_ENUMERATION}.top then
					l_spliter.set_first (l_current_item)
					l_spliter.set_second (l_widget)
				else
					l_spliter.set_first (l_widget)
					l_spliter.set_second (l_current_item)
				end

				l_container.extend (l_spliter)
				if l_target_split /= Void then
					if l_target_split.minimum_split_position > l_target_split_position  then
						l_target_split_position := l_target_split.minimum_split_position
					elseif l_target_split.maximum_split_position  < l_target_split_position then
						l_target_split_position := l_target_split.maximum_split_position
					end
					l_target_split.set_split_position (l_target_split_position)
				end
				l_spliter.set_proportion ({REAL_32} 0.5)
				inner_container.restore_spliter_position (l_current_item, generating_type.name_32 + {STRING_32} ".change_zone_split_area_whole_content")
			else
				check a_target_zone_is_widget_and_is_parented: False end
				check inner_container_item_is_split_area: False end
			end
		end

note
	library:	"SmartDocking: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2018, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
