note
	description: "EiffelVision Split Area. Cocoa implementation."
	author: "Daniel Furrer"
	id: "$Id: ev_split_area_imp.e 102950 2019-03-11 13:20:02Z jfiat $"
	date: "$Date: 2019-03-11 13:20:02 +0000 (Mon, 11 Mar 2019) $"
	revision: "$Revision: 102950 $"

deferred class
	EV_SPLIT_AREA_IMP

inherit
	EV_SPLIT_AREA_I
		undefine
			propagate_foreground_color,
			propagate_background_color
		redefine
			interface
		select
			copy
		end

	EV_CONTAINER_IMP
		redefine
			interface,
			dispose
		end

	NS_SPLIT_VIEW_DELEGATE
		rename
			make as create_split_view_delegate,
			item as delegate_item,
			copy as copy_cocoa
		undefine
			is_equal
		redefine
			split_view_did_resize_subviews,
			dispose
		end

feature -- Access

	make
		do
			initialize
			create_split_view_delegate
			split_view.set_delegate (current)
			first_expandable := True
			second_expandable := True
		end

	split_view_did_resize_subviews
		do
			split_view.adjust_subviews
		end

	set_first (v: attached like item)
			-- Make `an_item' `first'.
		local
			l_imp: detachable EV_WIDGET_IMP
		do
			l_imp ?= v.implementation
			check l_imp_not_void: l_imp /= Void then end
			first := v
--			on_new_item (l_imp)
			l_imp.set_parent_imp (current)
			disable_item_expand (v)
			update_subviews

			--notify_change (nc_minsize, Current)
			if second_visible then
				set_split_position (minimum_split_position)
			else
				set_split_position (maximum_split_position)
			end
			notify_change (Nc_minsize, Current)
			new_item_actions.call ([v])
		end

	set_second (v: attached like item)
			-- Make `an_item' `second'.
		local
			v_imp: detachable EV_WIDGET_IMP
		do
			v.implementation.on_parented
			v_imp ?= v.implementation
			check l_imp_not_void: v_imp /= Void then end
			v_imp.set_parent_imp (Current)
			notify_change (Nc_minsize, Current)
			second := v
			update_subviews

			notify_change (Nc_minsize, Current)
			if first_visible then
				check
					second /= Void
				end
				if attached {EV_HORIZONTAL_SPLIT_AREA_IMP} current then
					set_split_position (width - splitter_width - v.minimum_width.min
						(width - minimum_split_position - splitter_width))
				else
					set_split_position (height - splitter_width - v.minimum_height.min
						(height - minimum_split_position - splitter_width))
				end
			else
				set_split_position (0)
			end
				--| Notify change is called twice, as we need
				--| the sizing calculations performed once before
				--| we call set_split_position, so we can use `height'
				--| and be sure it is correct. Then we call notify change
				--| again after the split position has been set,
				--| to reflect these changes.
			notify_change (Nc_minsize, Current)
			new_item_actions.call ([v])
		end

	update_subviews
		local
			l_subviews: NS_ARRAY [NS_VIEW]
		do
			l_subviews := attached_view.subviews.twin
			from
				l_subviews.start
			until
				l_subviews.after
			loop
				l_subviews.item_for_iteration.remove_from_superview
				l_subviews.forth
			end

			if attached first_imp as l_imp then
				attached_view.add_subview (l_imp.attached_view)
			end
			if attached second_imp as l_imp then
				attached_view.add_subview (l_imp.attached_view)
			end
		end

	prune (an_item: like item)
			-- Remove `an_item' if present from `Current'.
		local
			an_item_imp: detachable EV_WIDGET_IMP
		do
			if has (an_item) and then an_item /= Void then
				an_item_imp ?= an_item.implementation
				check an_item_imp_not_void: an_item_imp /= Void then end
				an_item_imp.set_parent_imp (Void)
				if an_item = first then
					first_expandable := False
					first := Void
					set_split_position (0)
					if second /= Void then
						set_item_resize (second, True)
					end
				else
					second := Void
					second_expandable := True
					if first /= Void then
						set_item_resize (first, True)
					end
				end
				an_item_imp.attached_view.remove_from_superview
				notify_change (Nc_minsize, Current)
			end
		end

	enable_item_expand (an_item: attached like item)
			-- Let `an_item' expand when `Current' is resized.
		do
			set_item_resize (an_item, True)
		end

	disable_item_expand (an_item: attached like item)
			-- Make `an_item' non-expandable on `Current' resize.
		do
			set_item_resize (an_item, False)
		end

	split_position: INTEGER
			-- Position from the left/top of the splitter from `Current'.
		do
			--Result := internal_split_position
			Result := internal_split_position.max (minimum_split_position).min (maximum_split_position) -- enforce invariant
		end

	set_split_position (a_split_position: INTEGER)
			-- Set the position of the splitter.
		do
			internal_split_position := a_split_position
			layout_widgets (True)
		ensure then
			split_position_set: split_position = a_split_position
		end

	ev_apply_new_size (a_x_position, a_y_position, a_width, a_height: INTEGER; repaint: BOOLEAN)
		do
			ev_move_and_resize (a_x_position, a_y_position, a_width, a_height, repaint)
			layout_widgets (False)
		end

	layout_widgets (originator: BOOLEAN)
		deferred
		end

feature -- Widget relationships

	top_level_window_imp: detachable EV_WINDOW_IMP
			-- Top level window that contains `Current'.

	set_top_level_window_imp (a_window: detachable EV_WINDOW_IMP)
			-- Make `a_window' the new `top_level_window_imp'
			-- of `Current'.
		local
			widget_imp: detachable EV_WIDGET_IMP
		do
			top_level_window_imp := a_window
			if attached first as l_first then
				widget_imp ?= l_first.implementation
				check
					widget_implementation_not_void: widget_imp /= Void then
				end
				widget_imp.set_top_level_window_imp (a_window)
			end
			if attached second as l_second then
				widget_imp ?= l_second.implementation
				check
					widget_implementation_not_void: widget_imp /= Void then
				end
				widget_imp.set_top_level_window_imp (a_window)
			end
		end

feature {NONE} -- Implementation

	first_imp: detachable EV_WIDGET_IMP
			-- `Result' is implementation of first.
		do
			if attached first as l_first then
				Result ?= l_first.implementation
				check
					implementation_of_first_not_void: Result /= Void
				end
			end
		end

	second_imp: detachable EV_WIDGET_IMP
			-- `Result' is implementation of second.
		do
			if attached second as l_second then
				Result ?= l_second.implementation
				check
					implementation_of_second_not_void: Result /= Void
				end
			end
		end

	splitter_width: INTEGER
		do
			Result := split_view.divider_thickness.truncated_to_integer
		end

	internal_split_position: INTEGER
		-- Position of the splitter in pixels.
		-- For a vertical split area, the position is the top of the splitter.
		-- For a horizontal split area, the position is the left
		-- of the splitter.

	set_item_resize (an_item: like item; a_resizable: BOOLEAN)
			-- Set whether `an_item' is `a_resizable' when `Current' resizes.
		do
			if an_item = first then
				first_expandable := a_resizable
			else
				second_expandable := a_resizable
			end
		end

feature {EV_ANY_I} -- Implementation

	dispose
			-- <Precursor>
		do
			Precursor {EV_CONTAINER_IMP}
			Precursor {NS_SPLIT_VIEW_DELEGATE}
		end

	split_view: NS_SPLIT_VIEW

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_SPLIT_AREA note option: stable attribute end;

note
	copyright: "Copyright (c) 1984-2019, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end -- class EV_SPLIT_AREA_IMP
