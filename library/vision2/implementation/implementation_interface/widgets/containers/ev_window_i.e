note
	description: "Eiffel Vision window. Implementation interface."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2014-05-16 04:58:04 +0000 (Fri, 16 May 2014) $"
	revision: "$Revision: 95082 $"

deferred class
	EV_WINDOW_I

inherit
	EV_CELL_I
		redefine
			interface,
			update_for_pick_and_drop
		end

	EV_POSITIONABLE_I
		redefine
			interface
		end

	EV_WINDOW_ACTION_SEQUENCES_I

feature -- Access

	upper_bar: EV_VERTICAL_BOX
			-- Room at top of `Current'. (Example use: toolbars.)
			-- Positioned below menu bar.

	lower_bar: EV_VERTICAL_BOX
			-- Room at bottom of `Current'. (Example use: statusbar.)

	maximum_width: INTEGER
			-- Maximum width that `Current' can take.
		deferred
		end

	maximum_height: INTEGER
			-- Maximum height that `Current' can take.
		deferred
		end

	internal_maximum_width: INTEGER
			-- Maximum width that `Current' can take.
			--| Because the minimum width of `Current' can
			--| be determined by the width of it's child,
			--| regardless of the maximum_width assigned,
			--| if the maximum_width is less than the
			--| minimum_width, we return the minimum_width.
		do
			Result := maximum_width
			if Result < minimum_width then
				Result := minimum_width
			end
		end

	internal_maximum_height: INTEGER
			-- Maximum height that `Current' can take.
			--| Because the minimum height of `Current' can
			--| be determined by the height of it's child,
			--| regardless of the maximum_size assigned,
			--| if the maximum_height is less than the
			--| minimum_height, we return the minimum_height.
		do
			Result := maximum_height
			if Result < minimum_height then
				Result := minimum_height
			end
		end

	title: STRING_32
			-- Application name to be displayed by the window manager.
		deferred
		end

	user_can_resize: BOOLEAN
			-- Can the user resize?

	has (v: like item): BOOLEAN
			-- Does structure include `v'?
		do
			if v /= Void then
				Result := item = v or else
					lower_bar = v or else
					upper_bar = v
			end
		end

	menu_bar: detachable EV_MENU_BAR
			-- Horizontal bar at top of client area that contains menu's.
		deferred
		end

	is_border_enabled: BOOLEAN
			-- Is a border displayed around `Current'?
			-- Always return `True' if `user_can_resize'.
		do
			Result := internal_is_border_enabled or else user_can_resize
		end

	accelerator_list: EV_ACCELERATOR_LIST
			-- Key combination shortcuts associated with this window.
		do
			if accelerators_internal = Void then
				create accelerators_internal
				accelerators_internal.compare_objects
			end
			Result := accelerators_internal
		end

feature {EV_WINDOW} -- Accelerators

	connect_accelerator (an_accel: EV_ACCELERATOR)
			-- Connect key combination `an_accel' to this window.
		deferred
		end

	disconnect_accelerator (an_accel: EV_ACCELERATOR)
			-- Disconnect key combination `an_accel' from this window.
		deferred
		end

feature -- Status setting

	disable_user_resize
			-- Forbid the resize of the window.
		deferred
		end

	enable_user_resize
			-- Allow the resize of the window.
		deferred
		end

	forbid_resize
			-- Forbid the resize of the window.
		deferred
		end

	allow_resize
			-- Allow the resize of the window.
		deferred
		end

	set_maximum_width (value: INTEGER)
			-- Make `value' the new `maximum_width'.
		require
			large_enough: value >= 0
		deferred
		ensure
			maximum_width_set: maximum_width = value
		end

	set_maximum_height (value: INTEGER)
			-- Make `value' the new `maximum_height'.
		require
			large_enough: value >= 0
		deferred
		ensure
			maximum_height_set: maximum_height = value
		end

	set_maximum_size (mw, mh: INTEGER)
			-- Make `mw' the new minimum_width and `mh' the new
			-- minimum_height.
		require
			valid_width: mw >= minimum_width
			valid_height: mh >= minimum_height
		do
			set_maximum_width (mw)
			set_maximum_height (mh)
		end

	set_title (txt : READABLE_STRING_GENERAL)
			-- Make `txt' the new title.
		require
			valid_title: txt /= Void
		deferred
		end

	set_menu_bar (a_menu_bar: EV_MENU_BAR)
			-- Set `menu_bar' to `a_menu_bar'.
		require
			no_menu_bar_assigned: menu_bar = Void
			a_menu_bar_not_void: a_menu_bar /= Void
		deferred
		ensure
			assigned: menu_bar = a_menu_bar
		end

	remove_menu_bar
			-- Set `menu_bar' to `Void'.
		deferred
		ensure
			menu_bar_void: menu_bar = Void
		end

	lock_update
			-- Lock updates for this window on certain platforms until
			-- `unlock_update' is called.
		do
			(create {EV_ENVIRONMENT}).implementation.application_i.set_locked_window (interface)
		end

	unlock_update
			-- Unlock updates for this window on certain platforms.
		do
			(create {EV_ENVIRONMENT}).implementation.application_i.set_locked_window (Void)
		end

	enable_border
			-- Ensure a border is displayed around `Current'
			-- and set `internal_is_border_enabled' to `True'.
		do
			internal_is_border_enabled := True
			internal_enable_border
		ensure
			is_border_enabled: is_border_enabled
		end

	disable_border
			-- Ensure no border is displayed around `Current'
			-- and set `internal_is_border_enabled' to `False'.
		do
			internal_is_border_enabled := False
			internal_disable_border
		ensure
			border_disabled: not user_can_resize implies not is_border_enabled
		end

	show_relative_to_window (a_parent: EV_WINDOW)
			-- Show `Current' with respect to `a_parent'.
		deferred
		end

feature {EV_ANY_I} -- Access

	accel_list: HASH_TABLE [EV_ACCELERATOR, INTEGER_32]
		-- Lookup table for accelerator access.

feature {NONE} -- Implementation

	internal_disable_border
			-- Ensure no border is displayed around `Current'.
		deferred
		end

	internal_enable_border
			-- Ensure a border is displayed around `Current'.
		deferred
		end

	internal_is_border_enabled: BOOLEAN

feature {EV_ANY_I} -- Implementation

	accelerators_internal: detachable EV_ACCELERATOR_LIST
		note
			option: stable
		attribute
		end

	update_for_pick_and_drop (starting: BOOLEAN)
			-- Pick and drop status has changed so notify `item_imp'.
		do
			Precursor (starting)
			upper_bar.implementation.update_for_pick_and_drop (starting)
			lower_bar.implementation.update_for_pick_and_drop (starting)
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_WINDOW note option: stable attribute end;

note
	copyright:	"Copyright (c) 1984-2014, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class EV_WINDOW_I











