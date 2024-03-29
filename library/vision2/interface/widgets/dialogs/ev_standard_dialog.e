note
	description:
		"EiffelVision standard dialog."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "modal, ok, cancel"
	date: "$Date: 2017-05-03 15:56:14 +0000 (Wed, 03 May 2017) $"
	revision: "$Revision: 100317 $"

deferred class
	EV_STANDARD_DIALOG

inherit
	EV_ANY
		redefine
			implementation
		end

	EV_POSITIONABLE
		undefine
			initialize
		redefine
			implementation
		end

	EV_STANDARD_DIALOG_ACTION_SEQUENCES

feature {NONE} -- Initialization

	make_with_title (a_title: READABLE_STRING_GENERAL)
			-- Initialize `Current' and assign `a_title' to `title'.
		require
			a_title_not_void: a_title /= Void
		do
			default_create
			set_title (a_title)
		ensure
				-- On some platform we cannot change the title.
			title_assigned: title.same_string_general (a_title)
			cloned: title /= a_title
		end

feature -- Access

	title: STRING_32
			-- Title of `Current' displayed in title bar.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.title
		ensure
			bridge_ok: Result.is_equal (implementation.title)
			cloned: Result /= implementation.title
		end

	blocking_window: detachable EV_WINDOW
			-- Window `Current' is a transient for.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.blocking_window
		ensure
			bridge_ok: Result = implementation.blocking_window
		end

feature -- Status report

	selected_button: detachable STRING_32
			-- Label of last clicked button.
		obsolete
			"Use `selected_button_name' instead and {EV_DIALOG_NAMES} for comparison. [2017-05-31]"
		require
			not_destroyed: not is_destroyed
		do
			if attached implementation.selected_button as l_button then
				Result := l_button.as_string_32_conversion
			end
		ensure
			bridge_ok: Result /= Void implies (attached implementation.selected_button as l_button and then
				Result.same_string (l_button))
		end

	selected_button_name: detachable IMMUTABLE_STRING_32
			-- Label of last clicked button.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.selected_button
		ensure
			bridge_ok: Result /= Void implies Result = implementation.selected_button
		end

feature -- Status setting

	hide
			-- Request that `Current' not be displayed even when its parent is.
			-- If successful, make `is_show_requested' `False'.
		require
			not_destroyed: not is_destroyed
		do
			implementation.hide
		end

	show_modal_to_window (a_window: EV_WINDOW)
			-- Show and wait until `Current' is closed.
			-- `Current' is shown modal with respect to `a_window'.
		require
			not_destroyed: not is_destroyed
			a_window_not_void: a_window /= Void
			dialog_modeless: blocking_window = Void
		do
			implementation.show_modal_to_window (a_window)
		ensure
				-- When a dialog is displayed modally, execution of code is
				-- halted until the dialog is closed or destroyed. Therefore,
				-- this postcondition will only be executed after the dialog
				-- is closed or destroyed.
			dialog_closed_so_no_blocking_window:
				not is_destroyed implies blocking_window = Void
		end

	set_title (a_title: READABLE_STRING_GENERAL)
			-- Assign `a_title' to `title'.
		require
			not_destroyed: not is_destroyed
			a_title_not_void: a_title /= Void
		do
			implementation.set_title (a_title)
		ensure
			assigned: title.same_string_general (a_title)
			cloned: title /= a_title
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	create_interface_objects
			-- <Precursor>
		do

		end

	implementation: EV_STANDARD_DIALOG_I
		-- Responsible for interaction with native graphics toolkit.

invariant
	title_not_void: is_usable implies title /= Void

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




end -- class EV_STANDARD_DIALOG











