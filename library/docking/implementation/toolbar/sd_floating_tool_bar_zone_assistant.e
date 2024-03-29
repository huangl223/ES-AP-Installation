﻿note
	description: "Assistants that manage a SD_FLOATING_TOOL_BAR_ZONE position item issues."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2017-04-14 18:05:46 +0000 (Fri, 14 Apr 2017) $"
	revision: "$Revision: 100203 $"

class
	SD_FLOATING_TOOL_BAR_ZONE_ASSISTANT

inherit
	SD_ACCESS

create
	make

feature {NONE} -- Creation

	make (a_floating_zone: SD_FLOATING_TOOL_BAR_ZONE)
			-- Associate assistant with `a_floating_zone'.
		do
			zone := a_floating_zone
		end

feature -- Commands

	position_groups (a_groups_info: SD_TOOL_BAR_GROUP_INFO)
			-- Position tool_bar items by a_group_info
		require
			not_void: a_groups_info /= Void
		do
			debug ("docking")
				print ("%N=================== SD_FLOATING_TOOL_BAR_ZONE_ASSISTANT position_groups ================")
			end
			if zone.content.items_except_sep (False).count > 0 then
				position_groups_imp (a_groups_info)
				if attached zone.zone as z then
					z.assistant.last_state.set_floating_group_info (a_groups_info)
				end
			end
		end

	to_minmum_size
			-- To minmum size
		do
			zone.set_size (zone.minimum_width, zone.minimum_height)

			debug ("docking")
				print ("%N  SD_FLAOTING_TOOL_BAR_ZONE_ASSISTANT Untitled dialog zone set size: " + zone.minimum_width.out + ", " + zone.minimum_height.out)
				if attached zone.tool_bar as b then
					print ("%N                  zone's tool bar minimum size: " + b.minimum_width.out + ", " + b.minimum_height.out)
				end
			end
		end

feature {NONE} -- Implementation functions

	position_groups_imp (a_groups_info: SD_TOOL_BAR_GROUP_INFO)
			-- Position tool_bar items by a_group_info
		require
			not_void: a_groups_info /= Void
		do
			debug ("docking")
				print ("%N SD_FLOATING_TOOL_BAR_ZONE_ASSISTANT position_groups_imp START")
			end
			reset_all_items_wrap
			from
				a_groups_info.start
			until
				a_groups_info.after
			loop
				debug ("docking")
					print ("%N                                a_groups_info.index: " + a_groups_info.index.out)
				end
				if attached a_groups_info.sub_grouping.item (a_groups_info.index) as l_item then
					position_sub_level_items (l_item, a_groups_info.index)
					debug ("docking")
						print ("%N                                has sub group info")
					end
				else
					if a_groups_info.is_new_group then
						position_top_level_items (a_groups_info.item)
					end
					debug ("docking")
						print ("%N                                not has sub group info")
					end
				end
				a_groups_info.forth
			end
			if attached zone.tool_bar as b then
				b.compute_minimum_size
			end
			to_minmum_size
			debug ("docking")
				print ("%N SD_FLOATING_TOOL_BAR_ZONE_ASSISTANT position_groups_imp END")
			end
		end

	position_top_level_items (a_group_indexs: HASH_TABLE [INTEGER, INTEGER])
			-- Position tool bar items' groups
		require
			not_void: a_group_indexs /= Void
		local
			l_group: LIST [SD_TOOL_BAR_ITEM]
			l_first_item: detachable SD_TOOL_BAR_ITEM
			l_separator: detachable SD_TOOL_BAR_SEPARATOR
		do
			from
				a_group_indexs.start
			until
				a_group_indexs.after or l_first_item /= Void
			loop
				l_group := zone.content.group_items (a_group_indexs.key_for_iteration, False)
				l_first_item := l_group.first
				a_group_indexs.forth
			end
			if l_first_item /= Void then
					-- There should be a separator behind, otherwise this is the last tool bar item
				l_separator := zone.content.separator_before_item (l_first_item)
				if l_separator /= Void then
					l_separator.set_wrap (True)
				else
					l_first_item.set_wrap (True)
				end
			end
		end

	position_sub_level_items (a_sub_info: SD_TOOL_BAR_GROUP_INFO; a_group_index: INTEGER)
			-- Position group items
		require
			not_void: a_sub_info /= Void
		local
			l_items: LIST [SD_TOOL_BAR_ITEM]
			l_first_item: SD_TOOL_BAR_ITEM
			l_separator: detachable SD_TOOL_BAR_SEPARATOR
		do
			debug ("docking")
				print ("%N                                  position_sub_level_items START: ")
			end
			l_items := zone.content.group_items (a_group_index, False)
			from
				a_sub_info.start
			until
				a_sub_info.after
			loop
				a_sub_info.item.start
				debug ("docking")
					print ("%N                                  position a_sub_info.item.key_for_iteration: " + a_sub_info.item.key_for_iteration.out)
				end
				if a_sub_info.item.key_for_iteration > 1 and l_items.valid_index (a_sub_info.item.key_for_iteration - 1) then
					l_first_item := l_items.i_th (a_sub_info.item.key_for_iteration - 1)
					if (a_sub_info.is_new_group or a_sub_info.index = 1) and then zone.content.separator_after_item (l_first_item) = Void then
						l_first_item.set_wrap (True)
						debug ("docking")
							print ("%N                                  l_first_item set wrap")
						end
					end
					debug ("docking")
						print ("%N                                  larger than 1: a_sub_info.is_new_group" + a_sub_info.is_new_group.out)
					end
				elseif a_sub_info.item.key_for_iteration = 1 then
					-- For first item, we don't set group's separator wrap.
					l_separator := zone.content.separator_before_item (l_items.i_th (1))
					if l_separator /= Void and then zone.content.index_of (l_separator, False) /= 1 then
						-- If first item is separator, we don't set it wrap.
						l_separator.set_wrap (True)
					end
				end
				a_sub_info.forth
			end
			debug ("docking")
				print ("%N                                  position_sub_level_items END. ")
			end
		end

	reset_all_items_wrap
			-- Reset items to wrap state
		local
			l_items: LIST [SD_TOOL_BAR_ITEM]
		do
			l_items := zone.content.items_visible
			from
				l_items.start
			until
				l_items.after
			loop
				l_items.item.set_wrap (False)
				l_items.forth
			end
		end

feature {NONE} -- Implementation attributes

	zone: SD_FLOATING_TOOL_BAR_ZONE
			-- Floating zone which items positioned by Current.

;note
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
