note
	description: "Ancestor of all PND widgets which contain items."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2013-05-20 23:15:17 +0000 (Mon, 20 May 2013) $"
	revision: "$Revision: 92557 $"

deferred class
	EV_PICK_AND_DROPABLE_ITEM_HOLDER_IMP

inherit

	EV_PICK_AND_DROPABLE_IMP
		undefine
			set_pointer_style, enable_capture, disable_capture
		redefine
			pnd_press,
			interface,
			escape_pnd
		end

feature {EV_ANY_I, EV_INTERNAL_COMBO_FIELD_IMP,
		EV_INTERNAL_COMBO_BOX_IMP} -- Implementation

	pnd_press (a_x, a_y, a_button, a_screen_x, a_screen_y: INTEGER)
		do
			inspect
				press_action
			when
				Ev_pnd_start_transport
			then
				start_transport (a_x, a_y, a_button, True, 0, 0, 0.5,
					a_screen_x, a_screen_y, False)
					-- We must only set the parent source to true if
					-- the transport has began.
				if application_imp.pick_and_drop_source /= Void then
					if (a_button = 1 and mode_is_drag_and_drop) or
						(a_button = 3 and mode_is_pick_and_drop and application_imp.pick_and_drop_source /= Void) then
						set_parent_source_true
					end
				end
			when
				Ev_pnd_end_transport
			then
				end_transport (a_x, a_y, a_button, 0, 0, 0.5,
						a_screen_x, a_screen_y)
					-- If the user cancelled a pick and drop with the left
					-- button then we need to make sure that the
					-- pointer_button_press_actions are not called on
					-- `Current' or an item at the current
					-- pointer position.
				if a_button = 1 then
					discard_press_event
				end
				set_parent_source_false
			else
				check
					disabled: press_action = Ev_pnd_disabled
				end
			end
		end

	escape_pnd
			-- Escape the pick and drop.
		do
				--| This is redefined so that when escape has been pressed, we
				--| can reset the attributes help in `Current' which relate to
				--| the current state of a pick and drop.
			item_is_pnd_source:= False
			parent_is_pnd_source := False
			pnd_item_source := Void
			application_imp.clear_transport_just_ended
				-- If we are executing a pick and drop
			if attached application_imp.pick_and_drop_source as l_pnd_source then
					-- We use default values which cause pick and drop to end.
				l_pnd_source.end_transport (0, 0, 2, 0, 0, 0,
					0, 0)
			end
		end

	on_middle_button_down (keys, x_pos, y_pos: INTEGER)
			-- Wm_mbuttondown message
			-- See class WEL_MK_CONSTANTS for `keys' value
		local
			pt: WEL_POINT
		do
			internal_propagate_pointer_press (keys, x_pos, y_pos, 2)
			pt := client_to_screen (x_pos, y_pos)
			if application_imp.pointer_button_press_actions_internal /= Void then
				application_imp.pointer_button_press_actions.call ([attached_interface, 2, pt.x, pt.y])
			end
			if attached pointer_button_press_actions_internal as l_actions then
				l_actions.call
					([x_pos, y_pos, 3, 0.0, 0.0, 0.0, pt.x, pt.y])
			end
		end

	press_actions_called: BOOLEAN
		-- Have `pointer_button_press_actions' been called on `Current'?

	item_is_pnd_source_at_entry: BOOLEAN
		-- Is an item the source of a pick/drag and drop?
		-- updated every time entering `on_right_button_down'.
		-- or `on_left_button_down.

	item_is_in_pnd: BOOLEAN
		do
			if attached pnd_item_source as l_pnd_item_source then
				Result := l_pnd_item_source.is_pnd_in_transport or else l_pnd_item_source.is_dnd_in_transport
			end
		end

	on_right_button_down (keys, x_pos, y_pos: INTEGER)
			-- Wm_rbuttondown message
			-- See class WEL_MK_CONSTANTS for `keys' value
		local
			pt: WEL_POINT
		do
			item_is_pnd_source_at_entry := item_is_pnd_source
			create pt.make (x_pos, y_pos)
			pt := client_to_screen (x_pos, y_pos)
			if (not item_is_pnd_source and not is_pnd_in_transport
				and not is_dnd_in_transport) or (item_is_pnd_source and then attached pnd_item_source as l_pnd_item_source and then not
				l_pnd_item_source.is_pnd_in_transport and then not
				l_pnd_item_source.is_dnd_in_transport)
			then
				if application_imp.pointer_button_press_actions_internal /= Void then
					application_imp.pointer_button_press_actions.call ([attached_interface, 3, pt.x, pt.y])
				end
				if attached pointer_button_press_actions_internal as l_actions then
					l_actions.call
						([x_pos, y_pos, 3, 0.0, 0.0, 0.0, pt.x, pt.y])
				end
				press_actions_called := True
			end
			internal_propagate_pointer_press (keys, x_pos, y_pos, 3)
			press_actions_called := False
			item_is_pnd_source_at_entry := False
		end

	on_left_button_down (keys, x_pos, y_pos: INTEGER)
			-- Wm_rbuttondown message
			-- See class WEL_MK_CONSTANTS for `keys' value
		local
			pt: WEL_POINT
		do
				-- If a pick/drag and drop is currently executing then
				-- we are now cancelling it. We do not want the default
				-- processing to be carried out on `Current'. i.e. if this is
				-- happening in a list, cancelling over an item would have
				-- selected the item.
			if pnd_item_source /= Void or parent_is_pnd_source then
				disable_default_processing
			end
			create pt.make (x_pos, y_pos)
			pt := client_to_screen (x_pos, y_pos)
			if
				not (item_is_pnd_source and not is_pnd_in_transport and not
				is_dnd_in_transport) or (item_is_pnd_source and then attached pnd_item_source as l_pnd_item_source and then not
				l_pnd_item_source.is_pnd_in_transport and then not
				l_pnd_item_source.is_dnd_in_transport)
			then
				if application_imp.pointer_button_press_actions_internal /= Void then
					application_imp.pointer_button_press_actions.call ([attached_interface, 1, pt.x, pt.y])
				end
				if attached pointer_button_press_actions_internal as l_actions then
						-- The above `if' statement was added as an extra at a later date
						-- and is not incorporated into the main if to avoid the
						-- possibility of breaking something. Julian.
					l_actions.call
						([x_pos, y_pos, 1, 0.0, 0.0, 0.0, pt.x, pt.y])
				end
				press_actions_called := True
			end
			if attached_interface.is_dockable then
				pt := client_to_screen (x_pos, y_pos)
				dragable_press (x_pos, y_pos,
				1,
				pt.x, pt.y)
			end
			internal_propagate_pointer_press (keys, x_pos, y_pos, 1)
			press_actions_called := False
		end

	on_left_button_up (keys, x_pos, y_pos: INTEGER)
			-- Wmlbuttonup message
		local
			pt: WEL_POINT
			tool_bar: detachable EV_TOOL_BAR_IMP
		do
			create pt.make (x_pos, y_pos)
			pt := client_to_screen (x_pos, y_pos)
			if item_is_dockable_source then
				tool_bar ?= Current
				if tool_bar /= Void then
					tool_bar.end_dragable (x_pos, y_pos, 1, 0, 0, 0, pt.x, pt.y)
				end
			elseif item_is_pnd_source and then attached pnd_item_source as l_pnd_item_source then
				l_pnd_item_source.check_drag_and_drop_release (x_pos, y_pos)
			elseif parent_is_pnd_source then
				check_drag_and_drop_release (x_pos, y_pos)
				parent_is_pnd_source := False
			else
				check_dragable_release (x_pos, y_pos)
			end
			if application_imp.pointer_button_release_actions_internal /= Void then
				application_imp.pointer_button_release_actions.call ([attached_interface, 1, pt.x, pt.y])
			end
			if attached pointer_button_release_actions_internal as l_actions then
				l_actions.call ([x_pos, y_pos, 1, 0.0, 0.0, 0.0, pt.x, pt.y])
			end
		end

	on_left_button_double_click (keys, x_pos, y_pos: INTEGER)
			-- Executed when the right button is double clicked.
		do
			button_double_click_received (keys, x_pos, y_pos, 1)
		end

	on_middle_button_double_click (keys, x_pos, y_pos: INTEGER)
			-- Executed when the right button is double clicked.
		do
			button_double_click_received (keys, x_pos, y_pos, 2)
		end

	on_right_button_double_click (keys, x_pos, y_pos: INTEGER)
			-- Executed when the right button is double clicked.
		do
			button_double_click_received (keys, x_pos, y_pos, 3)
		end

	button_double_click_received (keys, x_pos, y_pos, a_button: INTEGER)
			-- Handle a double click from button `a_button'.
		local
			pt: WEL_POINT
		do
			create pt.make (x_pos, y_pos)
				-- Assign the screen coordinates of the click to `pt'
			pt := client_to_screen (x_pos, y_pos)
				-- Propagate the double click event to the appropriate item.
			internal_propagate_pointer_double_press
				(keys, x_pos, y_pos, a_button)
			if application_imp.pointer_double_press_actions_internal /= Void then
				application_imp.pointer_double_press_actions.call ([attached_interface, a_button, pt.x, pt.y])
			end
			if attached pointer_double_press_actions_internal as l_pointer_double_press_actions then
					-- Call pointer_double_press_actions on `Current'.
				l_pointer_double_press_actions.call
					([x_pos, y_pos, a_button, 0.0, 0.0, 0.0, pt.x, pt.y])
			end
		end

	client_to_screen (x_pos, y_pos: INTEGER): WEL_POINT
		deferred
		end

	internal_propagate_pointer_press (keys, x_pos, y_pos, button: INTEGER)
		deferred
		end

	internal_propagate_pointer_double_press (
		keys, x_pos, y_pos, button: INTEGER)
		deferred
		end

	find_item_at_position (x_pos, y_pos: INTEGER): detachable EV_ITEM_IMP
			-- `Result' is item at pixel position `x_pos', `y_pos'.
		deferred
		end

	screen_x: INTEGER
			-- Horizontal offset of `Current' relative to screen.
		deferred
		end

	screen_y: INTEGER
			-- Vertical offset of `Current' relative to screen.
		deferred
		end

	dragable_press (a_x, a_y, a_button, a_screen_x, a_screen_y: INTEGER)
			-- Process `a_button' to start/stop the drag/pick and
			-- drop mechanism.
		deferred
		end

	check_dragable_release (x_pos, y_pos: INTEGER)
			-- End transport if in drag and drop.
		deferred
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_WIDGET note option: stable attribute end;

feature {EV_PICK_AND_DROPABLE_ITEM_IMP} -- Status report

	call_press_event: BOOLEAN
			-- Should we call the press event or ignore it due to the
			-- pick and drop?
			--| For example, if you start a pick and drop in an EV_LIST, move
			--| the mouse over an item and cancel the pick and drop with the
			--| left button, we do not want the pointer_button_press_actions
			--| to be called for that item as we are not pressing the item but
			--| cancelling the PND instead.

	discard_press_event
			-- Assign `True' to `call_press_event'.
		do
			call_press_event := False
		end

	keep_press_event
			-- Assign `True' to `call_press_event'.
		do
			call_press_event := True
		end

	parent_is_pnd_source : BOOLEAN
			-- PND started in the widget.

	pnd_item_source: detachable EV_PICK_AND_DROPABLE_ITEM_IMP
			-- PND source if PND started in an item.

	item_is_pnd_source: BOOLEAN
		-- PND started in an item.

	item_is_dockable_source: BOOLEAN

	set_item_source (source: detachable EV_PICK_AND_DROPABLE_ITEM_IMP)
			-- Assign `source' to `pnd_item_source'
		do
			pnd_item_source := source
		end

	set_parent_source_true
			-- Assign `True' to `parent_is_pnd_source'.
		do
			parent_is_pnd_source := True
		end

	set_parent_source_false
			-- Assign `False' to `parent_is_pnd_source'.
		do
			parent_is_pnd_source := False
		end

	set_item_source_true
			-- Assign `True' to `item_is_pnd_source'.
		do
			item_is_pnd_source := True
		end

	set_item_source_false
			-- Assign `False' to `item_is_pnd_source'.
		do
			item_is_pnd_source := False
		end

feature {EV_PICK_AND_DROPABLE_ITEM_IMP} -- Deferred

	disable_default_processing
			-- Disable default window processing.
		deferred
		end


	top_level_window_imp: detachable EV_WINDOW_IMP
		deferred
		end

	set_pointer_style (c: EV_POINTER_STYLE)
		deferred
		end

	set_capture
			-- Grab user input.
			-- Works only on current windows thread.
		deferred
		end

	release_capture
			-- Release user input.
			-- Works only on current windows thread.
		deferred
		end

	set_heavy_capture
			-- Grab user input.
			-- Works on all windows threads.
		deferred
		end

	release_heavy_capture
			-- Release user input
			-- Works on all windows threads.
		deferred
		end

	pointer_button_press_actions_internal: detachable EV_POINTER_BUTTON_ACTION_SEQUENCE
			-- Implementation of once per object `pointer_button_press_actions'.
		deferred
		end

	pointer_button_release_actions_internal: detachable EV_POINTER_BUTTON_ACTION_SEQUENCE
			-- Implementation of once per object `pointer_button_release_actions'.
		deferred
		end

	pointer_double_press_actions_internal: detachable EV_POINTER_BUTTON_ACTION_SEQUENCE
			-- Implementation of once per object `pointer_double_press_actions'. is
		deferred
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_PICK_AND_DROPABLE_ITEM_HOLDER_IMP












