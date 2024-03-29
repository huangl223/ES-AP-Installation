note
	description: "Eiffel Vision notebook. Cocoa implementation."
	author: "Daniel Furrer"
	date: "$Date: 2019-03-11 13:20:02 +0000 (Mon, 11 Mar 2019) $"
	revision: "$Revision: 102950 $"

class
	EV_NOTEBOOK_IMP

inherit
	EV_NOTEBOOK_I
		undefine
			propagate_foreground_color,
			propagate_background_color
		redefine
			interface
		end

	EV_WIDGET_LIST_IMP
		redefine
			interface,
			initialize,
			remove_i_th,
			insert_i_th
		end

	EV_FONTABLE_IMP
		redefine
			interface
		end

create
	make

feature {NONE} -- Initialization

	initialize
			-- Initialize the notebook.
		do
			tab_position := {EV_NOTEBOOK}.tab_top
			create tabs.make (5)
			create tab_view.make
			cocoa_view := tab_view

			Precursor {EV_WIDGET_LIST_IMP}
			initialize_pixmaps

			last_selected := 0
		end

feature {NONE} -- Layout

	compute_minimum_width
			-- Recompute the minimum_width of `Current'.
		local
			child_imp: EV_WIDGET_IMP
			counter, value: INTEGER
		do
			from
				counter := 1
				value := 0
			until
				counter > ev_children.count
			loop
				child_imp := ev_children.i_th (counter)
				check
					child_imp_not_void: child_imp /= Void
				end
				value := child_imp.minimum_width.max (value)
				counter := counter + 1
			end

				-- We found the biggest child.
			if
				tab_position = {EV_NOTEBOOK}.Tab_right
				or else tab_position = {EV_NOTEBOOK}.Tab_left
			then
				internal_set_minimum_width (value + tab_height + 4)
			else
				internal_set_minimum_width (value + 6)
			end
		end

	compute_minimum_height
			-- Recompute the minimum_height of `Current'.
		local
			counter: INTEGER
			child_imp: EV_WIDGET_IMP
			value: INTEGER
		do
			from
				counter := 1
				value := 0
			until
				counter > ev_children.count
			loop
				child_imp := ev_children.i_th (counter)
				check
					child_imp_not_void: child_imp /= Void
				end
				value := child_imp.minimum_height.max (value)
				counter := counter + 1
			end

				-- We found the biggest child.
			if
				tab_position = {EV_NOTEBOOK}.Tab_top
				or else tab_position = {EV_NOTEBOOK}.Tab_bottom
			then
				internal_set_minimum_height (value + tab_height + 4)
			else
				internal_set_minimum_height (value + 6)
			end
		end

	compute_minimum_size
			-- Recompute both the minimum_width and then
			-- minimum_height of `Current'.
		local
			counter: INTEGER
			child_imp: EV_WIDGET_IMP
			mw, mh: INTEGER
		do
			from
				counter := 1
				mw := 0; mh := 0
			until
				counter > ev_children.count
			loop
				child_imp := ev_children.i_th (counter)
				check
					child_imp_not_void: child_imp /= Void
				end
				mw := child_imp.minimum_width.max (mw)
				mh := child_imp.minimum_height.max (mh)
				counter := counter + 1
			end

			-- We found the biggest child.
			if
				tab_position = {EV_NOTEBOOK}.Tab_top
				or else tab_position = {EV_NOTEBOOK}.Tab_bottom
			then
				internal_set_minimum_size (mw + 6, mh + tab_height + 4)
			else
				internal_set_minimum_size (mw + tab_height + 4, mh + 6)
			end
		end

feature -- Access

	pointed_tab_index: INTEGER
			-- index of tab currently under mouse pointer, or 0 if none.
		do

		end

	pixmaps_size_changed
			-- The size of the displayed pixmaps has just
			-- changed.
		do
			--| FIXME Implement this
		end

feature {EV_NOTEBOOK, EV_NOTEBOOK_TAB_IMP} -- Access

	item_tab (an_item: EV_WIDGET): EV_NOTEBOOK_TAB
			-- Tab associated with `an_item'.
		local
			item_index : INTEGER
		do
			item_index := index_of (an_item, 1)
			Result := tabs.i_th (item_index)
		end

	item_text (an_item: like item): STRING_32
			-- Label of `an_item'.
		local
			item_index : INTEGER
		do
			item_index := index_of (an_item, 1)
			Result := tabs.i_th (item_index).text
		end

	item_pixmap (an_item: like item): detachable EV_PIXMAP
			-- Pixmap of `an_item'.
		do
			-- FIXME Currently not supported on Mac OS X
		end

feature -- Status report

	selected_item: like item
			-- Page displayed topmost.
		do
			Result := i_th ( selected_item_index )
		end

	selected_item_index: INTEGER
			-- Page index of selected item
		do
			if ev_children.is_empty then
				Result := 0
			else
				Result := last_selected
			end
		end

	tab_position: INTEGER
			-- Position of tabs

feature {EV_NOTEBOOK} -- Status setting

	set_tab_position (a_tab_position: INTEGER)
			-- Display tabs at `a_position'.
			-- Recreate the tab control with changed settings
		do
		end

	select_item (an_item: like item)
			-- Display `an_item' above all others.
		local
			an_item_imp: detachable EV_WIDGET_IMP
			item_index : INTEGER
		do
			an_item_imp ?= an_item.implementation
			check
				an_item_imp_not_void : an_item_imp /= Void
			end
			item_index := index_of (an_item, 1)
			if last_selected > 0 and last_selected <= count then
--				w_imp ?= i_th (last_selected).implementation
--				check
--					w_imp_not_void : w_imp /= Void
--				end
			end
			last_selected := selected_item_index
		end

feature -- Element change

	remove_i_th (i: INTEGER)
			-- Remove item at `i'-th position.
		local
			v: detachable EV_WIDGET
			v_imp: detachable EV_WIDGET_IMP
			l_tab_imp: detachable EV_NOTEBOOK_TAB_IMP
		do
			tabs.go_i_th (i)
			l_tab_imp ?= tabs.item.implementation
			check l_tab_imp /= Void then end
			tab_view.remove_tab_view_item (l_tab_imp.tab_view_item)
			tabs.remove

			v := i_th (i)
			check v /= Void then end
			v_imp ?= v.implementation
			check v_imp_not_void: v_imp /= Void then end
			remove_item_actions.call ([v_imp.attached_interface])
			v_imp.on_orphaned
			v_imp.set_parent_imp (Void)

			ev_children.go_i_th (i)
			ev_children.remove

			notify_change (Nc_minsize, v_imp)
		end

	insert_i_th (v: attached like item; i: INTEGER)
			-- Insert `v' at position `i'.
		local
			v_imp: detachable EV_WIDGET_IMP
			l_tab: EV_NOTEBOOK_TAB
			l_tab_imp: detachable EV_NOTEBOOK_TAB_IMP
		do
			v_imp ?= v.implementation
			check not_void : v_imp /=  Void then end
			ev_children.go_i_th (i)
			ev_children.put_left (v_imp)
			if last_selected = 0 then
				last_selected := 1
			end
			v.implementation.on_parented
			v_imp.set_parent_imp (Current)
			notify_change (Nc_minsize, Current)
			v_imp.set_top_level_window_imp (top_level_window_imp)

			create l_tab.make_with_widgets (attached_interface, v)
			l_tab_imp ?= l_tab.implementation
			check l_tab_imp /= Void then end
			tabs.go_i_th (i)
			tabs.put_left (l_tab)

			tab_view.add_tab_view_item (l_tab_imp.tab_view_item)
			--l_tab_imp.tab_view_item.set_view (v_imp.cocoa_view)

			notify_change (Nc_minsize, v_imp)

			-- Call `new_item_actions' on `Current'.
			new_item_actions.call ([v])
		end

	ev_apply_new_size (a_x_position, a_y_position, a_width, a_height: INTEGER_32; repaint: BOOLEAN)
		local
--			l_tab_imp: detachable EV_NOTEBOOK_TAB_IMP
--			l_widget: detachable EV_WIDGET
--			l_widget_imp: detachable EV_WIDGET_IMP
		do
			ev_move_and_resize (a_x_position, a_y_position, a_width, a_height, repaint)
--			from
--				tabs.start
--			until
--				tabs.after
--			loop
--				l_tab_imp ?= tabs.item.implementation
--				check l_tab_imp /= Void end
--				l_widget ?= l_tab_imp.widget
--				check l_widget /= Void end
--				l_widget_imp ?= l_widget.implementation
--				check l_widget_imp /= Void end
--				l_widget_imp.ev_apply_new_size (a_x_position, a_y_position, client_width, a_height, True)
--				tabs.forth
--			end
		end

feature {EV_NOTEBOOK, EV_NOTEBOOK_TAB_IMP} -- Element change

	default_tab_label_spacing: INTEGER = 3
		-- Space between pixmap and text in the tab label.

	set_item_text (an_item: like item; a_text: READABLE_STRING_GENERAL)
			-- Assign `a_text' to the label for `an_item'.
		local
			item_index : INTEGER
		do
			item_index := index_of ( an_item, 1 )
			tabs.i_th (item_index).set_text (a_text)
		end

	set_item_pixmap (an_item: like item; a_pixmap: EV_PIXMAP)
			-- Assign `a_pixmap' to the tab for `an_item'.
		do
			-- FIXME Currently not supported on Mac OS X
		end

	tabs: ARRAYED_LIST [EV_NOTEBOOK_TAB]

feature {EV_INTERMEDIARY_ROUTINES} -- Implementation

	tab_height : INTEGER = 20
		-- Offset between the tabs and the content -- TODO

	last_selected : INTEGER

feature {EV_ANY_I, EV_ANY} -- Implementation

	interface: detachable EV_NOTEBOOK note option: stable attribute end;
			-- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'

	tab_view: NS_TAB_VIEW

;note
	copyright: "Copyright (c) 1984-2019, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end -- class EV_NOTEBOOK_IMP
