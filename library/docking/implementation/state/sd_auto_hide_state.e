﻿note
	description: "SD_STATE for  SD_AUTO_HIDE_ZONE."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2017-04-18 18:22:38 +0000 (Tue, 18 Apr 2017) $"
	revision: "$Revision: 100223 $"

class
	SD_AUTO_HIDE_STATE

inherit
	SD_STATE_WITH_CONTENT
		redefine
			show,
			close,
			stick,
			float,
			change_short_title,
			change_long_title,
			change_pixmap,
			hide,
			set_focus,
			record_state,
			restore,
			move_to_docking_zone,
			move_to_tab_zone,
			change_zone_split_area
		end

create
	make,
	make_with_size,
	make_with_friend

feature {NONE} -- Initlization

	make (a_content: SD_CONTENT; a_direction: INTEGER)
			-- Creation method
		require
			a_content_not_void: a_content /= Void
			a_direction_valid: a_direction = {SD_ENUMERATION}.top or a_direction = {SD_ENUMERATION}.bottom
				or a_direction = {SD_ENUMERATION}.left or a_direction = {SD_ENUMERATION}.right
		do
			internal_content := a_content
			set_docking_manager (a_content.docking_manager)
			direction := a_direction
			if a_direction = {SD_ENUMERATION}.left or a_direction = {SD_ENUMERATION}.right then
				width_height := (docking_manager.fixed_area.width * {SD_SHARED}.default_docking_width_rate).ceiling
			else
				width_height := (docking_manager.fixed_area.height * {SD_SHARED}.default_docking_height_rate).ceiling
			end
			auto_hide_panel := docking_manager.query.auto_hide_panel (a_direction)

			create tab_stub.make (content, a_direction)

			create animation.make (Current, docking_manager)

			debug ("docking")
				io.put_string ("%N ************************** SD_AUTO_HIDE_STATE: insert tab stubs.")
			end
			tab_stub.pointer_enter_actions.extend (agent show)
			tab_stub.pointer_press_actions.extend (agent show)
			auto_hide_panel.tab_stubs.extend (tab_stub)

			last_floating_height := a_content.state.last_floating_height
			last_floating_width := a_content.state.last_floating_width

			initialized := True
		ensure
			set: internal_content = a_content
			set: direction = a_direction
		end

	make_with_size (a_content: SD_CONTENT; a_direction: INTEGER; a_width_height: INTEGER)
			-- Creation with a size
		require
			a_content_not_void: a_content /= Void
			a_direction_valid: a_direction = {SD_ENUMERATION}.top or a_direction = {SD_ENUMERATION}.bottom
				or a_direction = {SD_ENUMERATION}.left or a_direction = {SD_ENUMERATION}.right
		do
			make (a_content, a_direction)
			width_height := max_size_by_zone (a_width_height)
		ensure
			set: width_height = max_size_by_zone (a_width_height)
		end

	make_with_friend (a_content:SD_CONTENT; a_friend: SD_CONTENT)
			-- Make with `a_friend', so tab together
		do
			make (a_content, a_friend.state.direction)
			auto_hide_panel.set_tab_with_friend (tab_stub, a_friend)
		end

feature  -- States report

	value: INTEGER
		do
			Result := {SD_ENUMERATION}.auto_hide
		end

feature -- Redefine

	set_focus (a_content: SD_CONTENT)
			-- <Precursor>
		do
			show
			if attached zone as z then
				z.on_focus_in (a_content)
			end
			docking_manager.property.set_last_focus_content (content)
		end

	close
			-- <Precursor>
		do
			Precursor
			internal_close
		ensure then
			tab_group_pruned: not auto_hide_panel.has (tab_stub)
		end

	stick (a_direction: INTEGER)
			-- <Precursor>
			-- `a_direction' is useless
			-- This feature used by SD_DOCKING_STATE and SD_CONTENT.set_auto_hide.
		local
			l_retried: BOOLEAN
		do
			if not l_retried then
				docking_manager.command.lock_update (Void, True)
				docking_manager.command.remove_auto_hide_zones (False)
				docking_manager.command.recover_normal_state

				-- Hanlde the case that first call SD_AUTO_HIDE_STATE.hide, then SD_AUTO_HIDE_STATE.stick
				-- So we should insert the `tab_stub' which removed by `hide'.
				if is_hide then
					auto_hide_panel.tab_stubs.extend (tab_stub)
				end

				stick_zones (a_direction)

				docking_manager.command.remove_empty_split_area
				docking_manager.command.unlock_update
			end
		ensure then
			tab_stubs_pruned: old not is_hide implies auto_hide_panel.tab_stubs.count < old auto_hide_panel.tab_stubs.count
		rescue
			docking_manager.command.unlock_update
			l_retried := True
			retry
		end

	float (a_x, a_y: INTEGER)
			-- <Precursor>
		local
			l_floating_state: SD_FLOATING_STATE
		do
			docking_manager.command.lock_update (Void, True)
			create l_floating_state.make (a_x, a_y, docking_manager, True)
			l_floating_state.set_size (last_floating_width, last_floating_height)
			dock_at_top_level (l_floating_state.inner_container)
			l_floating_state.update_title_bar
			docking_manager.command.remove_empty_split_area
			docking_manager.command.unlock_update

			docking_manager.command.update_title_bar

			docking_manager.query.inner_container_main.recover_normal_for_only_one
			-- After floating, left minmized editor zones in SD_MULTI_DOCK_AREA, then we
			-- have to resize
			docking_manager.command.resize (True)
		end

 	change_short_title (a_title: READABLE_STRING_GENERAL; a_content: SD_CONTENT)
			-- <Precursor>
		do
			tab_stub.set_text (a_title)
		ensure then
			set: tab_stub.text.same_string_general (a_title)
		end

 	change_long_title (a_title: READABLE_STRING_GENERAL; a_content: SD_CONTENT)
			-- <Precursor>
		do
			if attached zone as z then
				z.set_title (a_title)
			end
		ensure then
			set: attached zone as z implies z.title.same_string_general (a_title)
		end

	change_pixmap (a_pixmap: EV_PIXMAP; a_content: SD_CONTENT)
			-- <Precursor>
		do
			tab_stub.on_expose (0, 0, tab_stub.width, tab_stub.height)
		end

	restore (a_data: SD_INNER_CONTAINER_DATA; a_container: EV_CONTAINER)
			-- <Precursor>
		do
			-- This class can created by make (not like SD_DOCKING_STATE, created by INTERNAL), so this routine do less work.
			change_state (Current)
			direction := a_data.direction
			Precursor (a_data, a_container)
			initialized := True
		end

	record_state
			-- <Precursor>
		do
			if attached zone as z then
				if direction = {SD_ENUMERATION}.left or direction = {SD_ENUMERATION}.right then
					width_height := z.width
				else
					width_height := z.height
				end
			end
			animation.remove_moving_timer (False)
			animation.remove_close_timer

		ensure then
			-- This contract cannot write on GTK.
			-- Because the width/height is changed immediately
--			width_height_set: direction = {SD_DOCKING_MANAGER}.dock_left or direction = {SD_DOCKING_MANAGER}.dock_right
--				implies width_height = zone.width
--			width_height_set: direction = {SD_DOCKING_MANAGER}.dock_top or direction = {SD_DOCKING_MANAGER}.dock_bottom
--				implies width_height = zone.height
		end

	dock_at_top_level (a_multi_dock_area: SD_MULTI_DOCK_AREA)
			-- <Precursor>
			-- It's completely same as SD_STATE_VOID, merge?
		local
			l_docking_state: SD_DOCKING_STATE
		do
			docking_manager.command.lock_update (Void, True)
			if direction = {SD_ENUMERATION}.left or direction = {SD_ENUMERATION}.right then
				create l_docking_state.make (content, direction, (docking_manager.query.container_rectangle.width * {SD_SHARED}.default_docking_width_rate).ceiling)
			else
				create l_docking_state.make (content, direction, (docking_manager.query.container_rectangle.height * {SD_SHARED}.default_docking_height_rate).ceiling)
			end
			l_docking_state.dock_at_top_level (a_multi_dock_area)
			change_state (l_docking_state)

			internal_close
			docking_manager.command.unlock_update
		ensure then
			state_changed: content.state /= Current
		end

	change_zone_split_area (a_target_zone: SD_ZONE; a_direction: INTEGER)
			-- <Precursor>
		local
			l_docking_state: SD_DOCKING_STATE
		do
			content.set_visible (True)
			if attached {EV_WIDGET} a_target_zone as lt_widget then
				docking_manager.command.lock_update (lt_widget, False)
			else
				check not_possible: False end
			end
			create l_docking_state.make (content, a_direction, 0)
			l_docking_state.change_zone_split_area (a_target_zone, a_direction)
			change_state (l_docking_state)

			internal_close
			docking_manager.command.unlock_update
		ensure then
			state_changed: content.state /= Current
		end

	show
			-- <Precursor>
		local
			l_retried: BOOLEAN
		do
			if not l_retried then
				docking_manager.command.lock_update (Void, True)
				if is_hide then
					auto_hide_panel.tab_stubs.extend (tab_stub)
				end
				animation.show (True)
				content.show_actions.call (Void)
				docking_manager.command.unlock_update
			end
		ensure then
			show: docking_manager.zones.has_zone_by_content (content)
		rescue
			docking_manager.command.unlock_update
			l_retried := True
			retry
		end

	hide
			-- <Precursor>
		local
			l_state: SD_STATE_VOID
		do
			if not is_hide then
				docking_manager.command.remove_auto_hide_zones (False)
				-- Change to SD_STATE_VOID.... wait for user call show.... then back to special state
				create l_state.make (content, docking_manager)
				if attached auto_hide_panel.tab_group (tab_stub) as l_tab_group then
					internal_close
					l_tab_group.prune (tab_stub)
					if l_tab_group.count >= 1 then
						if attached auto_hide_panel.content_by_tab (l_tab_group.last) as t then
							l_state.set_relative (t)
						end
						change_state (l_state)
					end
				end
			end
		end

	set_user_widget (a_widget: EV_WIDGET)
			-- <Precursor>
		do
			if attached zone as z then
				z.window.set_user_widget (a_widget)
			end
		end

	set_mini_toolbar (a_widget: EV_WIDGET)
			-- <Precursor>
		do
			if attached zone as z then
				z.window.set_mini_toolbar (a_widget)
			end
		end

feature -- Command

	close_animation
			-- Close with animation
		do
			animation.close_animation
		end

feature -- Query

	zone: detachable SD_AUTO_HIDE_ZONE
			-- <Precursor>

	is_hide: BOOLEAN
			-- If current Hide?
		do
			Result := not auto_hide_panel.tab_stubs.has (tab_stub)
		end

	is_width_height_valid (a_width_height: INTEGER): BOOLEAN
			-- If a_width_height valid?
		do
			if direction  = {SD_ENUMERATION}.left or direction = {SD_ENUMERATION}.right then
				Result := a_width_height <= (docking_manager.fixed_area.width * 0.8).ceiling
			else
				Result := a_width_height <= (docking_manager.fixed_area.height * 0.8).ceiling
			end
		end

feature {NONE} -- Implementation functions

	stick_zones (a_direction: INTEGER)
			-- Stick zones which should together with current zone
		require
			a_direction_valid: a_direction = {SD_ENUMERATION}.top or a_direction = {SD_ENUMERATION}.bottom
				or a_direction = {SD_ENUMERATION}.left or a_direction = {SD_ENUMERATION}.right
		local
			l_docking_state: detachable SD_DOCKING_STATE
			l_tab_state: detachable SD_TAB_STATE
			l_tab_stub: SD_TAB_STUB
			l_content: SD_CONTENT
			l_last_tab_zone: detachable SD_TAB_ZONE
		do
			if attached auto_hide_panel.tab_group (tab_stub) as l_tab_group then
				l_tab_group.start
				if not l_tab_group.after then
					l_tab_stub := l_tab_group.item
					auto_hide_panel.tab_stubs.start
					auto_hide_panel.tab_stubs.prune (l_tab_stub)
					l_content := l_tab_stub.content
					create l_docking_state.make (l_content, direction, width_height)
					l_docking_state.dock_at_top_level (docking_manager.query.inner_container_main)
					l_content.state.change_state (l_docking_state)
					l_tab_group.forth
					if not l_tab_group.after then
						l_tab_stub := l_tab_group.item
						auto_hide_panel.tab_stubs.start
						auto_hide_panel.tab_stubs.prune (l_tab_stub)
						l_content := l_tab_stub.content
						create l_tab_state.make (l_content, l_docking_state.zone, direction)
						l_tab_state.set_width_height (width_height)
						l_tab_state.set_direction (l_docking_state.direction)
						l_last_tab_zone := l_tab_state.zone
						l_content.change_state (l_tab_state)
						l_tab_group.forth
						from
						until
							l_tab_group.after
						loop
							l_tab_stub := l_tab_group.item
							auto_hide_panel.tab_stubs.start
							auto_hide_panel.tab_stubs.prune (l_tab_stub)

							l_content := l_tab_stub.content
							if attached l_content.user_widget.parent as l_parent then
								l_parent.prune (l_content.user_widget)
							end
							create l_tab_state.make_with_tab_zone (l_content, l_last_tab_zone, direction)
							l_tab_state.set_width_height (width_height)
							l_tab_state.set_direction (l_last_tab_zone.state.direction)

							l_last_tab_zone := l_tab_state.zone
							l_content.change_state (l_tab_state)

							l_tab_group.forth
						end
						l_tab_state.select_tab (content, True)
					end
				end

				auto_hide_panel.tab_groups.start
				auto_hide_panel.tab_groups.prune (l_tab_group)
			end
		ensure
			state_changed: content.state /= Current
		end

	internal_close
			-- Prune internal widgets
		do
 			animation.remove_close_timer

			-- Remove tab stub from the SD_AUTO_HIDE_PANEL
			auto_hide_panel.tab_stubs.start
			auto_hide_panel.tab_stubs.prune (tab_stub)
		end

	move_to_docking_zone (a_target_zone: SD_DOCKING_ZONE; a_first: BOOLEAN)
			-- <Precursor>
			-- FIXIT: It's similiar to SD_DOCKING_STATE move_to_docking_zone, merge?
		do
			move_to_zone_internal (a_target_zone, a_first)
		end

	move_to_tab_zone (a_target_zone: SD_TAB_ZONE; a_index: INTEGER_32)
			-- <Precursor>
			-- FIXIT: It's similiar to SD_DOCKING_STATE move_to_tab_zone, merge?
		do
			if a_index = 1 then
				move_to_zone_internal (a_target_zone, True)
			else
				move_to_zone_internal (a_target_zone, False)
			end

			if a_index > 0 and a_index <= a_target_zone.contents.count then
				a_target_zone.set_content_position (content, a_index)
			end
		end

	move_to_zone_internal (a_target_zone: SD_ZONE; a_first: BOOLEAN)
			-- Move to `a_target_zone'
		local
			l_tab_state: detachable SD_TAB_STATE
			l_original_direction: INTEGER
		do
			if attached zone as z and then not z.is_destroyed then
				docking_manager.command.lock_update (z, False)
			else
				docking_manager.command.lock_update (Void, True)
			end

			internal_close
			docking_manager.zones.prune_zone_by_content (content)

			l_original_direction := a_target_zone.state.direction
			if attached {SD_DOCKING_ZONE} a_target_zone as l_docking_zone then
				create l_tab_state.make (content, l_docking_zone, l_original_direction)
			elseif attached {SD_TAB_ZONE} a_target_zone as l_tab_zone then
				create l_tab_state.make_with_tab_zone (content, l_tab_zone, l_original_direction)
			else
				check only_allow_two_type_zone: False end
			end
			if l_tab_state /= Void then
				if a_first then
					l_tab_state.zone.set_content_position (content, 1)
				end
				l_tab_state.set_direction (l_original_direction)
			end
			docking_manager.command.remove_empty_split_area
			if l_tab_state /= Void then
				change_state (l_tab_state)
			end
			docking_manager.command.update_title_bar
			docking_manager.command.unlock_update
		end

feature {SD_AUTO_HIDE_ANIMATION} -- Internal features

	max_size_by_zone (a_width_height: INTEGER): INTEGER
			-- Caculate max size
		require
			valid: a_width_height >= 0
		do
			if direction  = {SD_ENUMERATION}.left or direction = {SD_ENUMERATION}.right then
				if a_width_height <= (docking_manager.fixed_area.width * 0.8).ceiling then
					Result := a_width_height
				else
					Result := (docking_manager.fixed_area.width * 0.8).ceiling
				end
			else
				if a_width_height <= (docking_manager.fixed_area.height * 0.8).ceiling then
					Result := a_width_height
				else
					Result := (docking_manager.fixed_area.height * 0.8).ceiling
				end
			end
		ensure
			valid: is_width_height_valid (Result)
		end

	set_zone (a_zone: SD_AUTO_HIDE_ZONE)
			-- Set `zone'
		require
			not_void: a_zone /= Void
		do
			zone := a_zone
		ensure
			set: zone = a_zone
		end

	auto_hide_panel: SD_AUTO_HIDE_PANEL
			-- Auto hide panel which current is in

	tab_stub: SD_TAB_STUB
			-- Tab stub related to `internal_content'

feature {SD_DOCKING_MANAGER_AGENTS} -- Implementation

	animation: SD_AUTO_HIDE_ANIMATION
			-- Animation helper

invariant

	internal_content_not_void: initialized implies internal_content /= Void
	tab_stub_not_void: initialized implies tab_stub /= Void
	auto_hide_panel_not_void: initialized implies auto_hide_panel /= Void
	animation_not_void: initialized implies animation /= Void
	direction_valid: initialized implies direction = {SD_ENUMERATION}.top or direction = {SD_ENUMERATION}.bottom
		or direction = {SD_ENUMERATION}.left or direction = {SD_ENUMERATION}.right

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
