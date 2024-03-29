note
	description: "Menu shown when right click on SD_NOTEBOOK_TABs."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2017-04-05 14:23:32 +0000 (Wed, 05 Apr 2017) $"
	revision: "$Revision: 100099 $"

class
	SD_ZONE_MANAGEMENT_MENU

create {SD_WIDGET_FACTORY}
	make

feature {NONE}  -- Initlization

	make (a_notebook: SD_NOTEBOOK)
			-- Creation method
		require
			not_void: a_notebook /= Void
		local
			l_selected_item: detachable SD_CONTENT
		do
			default_create
			create items.make (3)
			internal_notebook := a_notebook
			create internal_shared
			create internal_close
			internal_close.set_pixmap (internal_shared.icons.close_context_tool_bar)
			internal_close.set_text (internal_shared.interface_names.menu_close + "%TCtrl+F4")
			items.extend (internal_close)
			create internal_close_others
			internal_close_others.set_pixmap (internal_shared.icons.close_others)
			internal_close_others.set_text (internal_shared.interface_names.menu_close_all_but_this)
			items.extend (internal_close_others)
			create internal_close_all
			internal_close_all.set_pixmap (internal_shared.icons.close_all)
			internal_close_all.set_text (internal_shared.interface_names.menu_close_all)
			items.extend (internal_close_all)

			l_selected_item := internal_notebook.selected_item
			if l_selected_item /= Void then
				internal_close.select_actions.extend (agent on_close (l_selected_item))
				internal_close_others.select_actions.extend (agent on_close_others (l_selected_item))
				internal_close_all.select_actions.extend (agent on_close_all (l_selected_item))
			end
		ensure
			set: internal_notebook = a_notebook
		end

feature -- Query

	items: ARRAYED_LIST [EV_MENU_ITEM]
			-- Menu items for zone management

feature {NONE}  -- Agents

	on_close (a_content: SD_CONTENT)
			-- Handle close event
		require
			not_void: a_content /= Void
		do
			a_content.close_request_actions.call (Void)
		end

	on_close_others (a_content: SD_CONTENT)
			-- Handle close others event
		require
			not_void: a_content /= Void
		local
			l_contents: ARRAYED_LIST [SD_CONTENT]
		do
			l_contents := internal_notebook.contents
			l_contents.prune_all (a_content)
			from
				l_contents.start
			until
				l_contents.after
			loop
				l_contents.item.close_request_actions.call (Void)
				l_contents.forth
			end
		end

	on_close_all (a_content: SD_CONTENT)
			-- Handle close all event
		require
			not_void: a_content /= Void
		do
			-- First we close others, finally we close selected `a_content'
			-- This way is faster than just closing contents one by one.
			on_close_others (a_content)
			a_content.close_request_actions.call (Void)
		end

feature {NONE} -- Implementation

	internal_close, internal_close_others, internal_close_all: EV_MENU_ITEM
			-- Zone close items

	internal_notebook: SD_NOTEBOOK
			-- Notebook which is managing

	internal_shared: SD_SHARED
			-- All singletons

invariant

	not_void: internal_shared /= Void
	not_void: items /= Void

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
