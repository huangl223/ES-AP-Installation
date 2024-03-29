note
	description:
		"Eiffel Vision progress bar. Mswindows implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2017-03-27 17:23:22 +0000 (Mon, 27 Mar 2017) $"
	revision: "$Revision: 100056 $"

deferred class
	EV_PROGRESS_BAR_IMP

inherit
	EV_PROGRESS_BAR_I
		redefine
			interface
		end

	EV_GAUGE_IMP
		undefine
			valid_maximum
		redefine
			interface,
			make
		end

	WEL_PROGRESS_BAR
		rename
			make as wel_make,
			parent as wel_parent,
			set_parent as wel_set_parent,
			destroy as wel_destroy,
			position as value,
			shown as is_displayed,
			set_position as wel_set_value,
			height as wel_height,
			width as wel_width,
			enabled as is_sensitive,
			item as wel_item,
			set_step as wel_set_step,
			set_range as wel_set_range,
			x as x_position,
			y as y_position,
			move as wel_move,
			move_and_resize as wel_move_and_resize,
			resize as wel_resize,
			has_capture as wel_has_capture
		undefine
			set_width,
			set_height,
			on_left_button_down,
			on_middle_button_down,
			on_right_button_down,
			on_left_button_up,
			on_middle_button_up,
			on_right_button_up,
			on_left_button_double_click,
			on_middle_button_double_click,
			on_right_button_double_click,
			on_mouse_move,
			on_mouse_wheel,
			on_set_focus,
			on_desactivate,
			on_kill_focus,
			on_key_down,
			on_key_up,
			on_char,
			on_set_cursor,
			default_style,
			show,
			hide,
			on_size,
			x_position,
			y_position,
			on_sys_key_down,
			on_sys_key_up,
			default_process_message,
			on_getdlgcode,
			on_wm_dropfiles
		redefine
			wel_set_step
		end

	WEL_PBS_CONSTANTS
		export
			{NONE} all
		end

	WEL_WINDOWS_VERSION
		export
			{NONE} all
		end


feature {NONE} -- Initialization

	old_make (an_interface: attached like interface)
			-- Create `Current'.
		do
			assign_interface (an_interface)
		end

	make
		do
			wel_make (default_parent, 0, 0, 0, 0, -1)
			Precursor {EV_GAUGE_IMP}
			disable_tabable_from
			disable_tabable_to
		end

feature -- Access

	step: INTEGER
			-- Step value of `Current'.

	leap: INTEGER
			-- Leap value of `Current'.

feature -- Status report

	is_segmented: BOOLEAN
			-- Is display segmented?
		do
			Result := not flag_set (style, Pbs_smooth)
		end

feature -- Status setting

	enable_segmentation
			-- Display `Current' with segments.
			-- Only works with Win95+IE3 or above.
		local
			new_style: INTEGER
				-- The new style of `Current'.
		do
			if not is_segmented then
				-- No need to enable segmentation if already segmented.
				if comctl32_version >= version_470 then
					-- Pbs_smooth is only available starting with
					-- Common Controls version 4.70 (Shipped with IE3).
					-- If we have an older version, we do nothing.
					new_style := clear_flag (style, Pbs_smooth)
						-- Remove `Pbs_smooth' from the style of `Current'.
					recreate_current (new_style)
				end
			end
		end

	disable_segmentation
			-- Display `Current' without segments.
			-- Only works with Win95+IE3 or above.
		local
				new_style: INTEGER
					-- The new style of `Current'.
		do
			if is_segmented then
				-- No need to disable segmentation if not already segmented.
				if comctl32_version >= version_470 then
					-- Pbs_smooth is only available starting with
					-- Common Controls version 4.70 (Shipped with IE3).
					-- If we have an older version, we do nothing.
					new_style := set_flag (style, Pbs_smooth)
						-- Add the style `Pbs_smooth' to `Current'.
					recreate_current (new_style)
				end
			end
		end

	recreate_current (a_new_style: INTEGER)
			-- Re create `Current' with `a_new_style'.
		local
			wel_imp: detachable WEL_WINDOW
			old_x, old_y, old_height, old_width, old_step, old_leap, old_value,
			old_minimum, old_maximum: INTEGER
				-- As we have to destroy the WEL control, we must store
				-- all the attributes within these variables so the control
				-- can be completely restored.
		do
			wel_imp := wel_parent
			old_x := x_position
			old_y := y_position
			old_width := width
			old_height := height
			old_value := value
			old_step := step
			old_leap := leap
			old_minimum := value_range.lower
			old_maximum := value_range.upper
				-- All attributes now stored.

			wel_destroy
				-- Destroy the actual control.
			internal_window_make (wel_imp, Void, a_new_style, old_x, old_y,
				old_width, old_height, -1, default_pointer)
				-- Create a new control.

			value_range.resize (old_minimum, old_maximum)
			set_value (old_value)
			wel_set_leap (old_leap)
			wel_set_step (old_step)
				-- Previous attributes have now been restored.
		end

	wel_set_step (a_step: INTEGER)
			-- Set `step ' to `a_step'.
		do
			Precursor (a_step)
			step := a_step
		end

feature {NONE} -- Implementation

	wel_set_leap (a_leap: INTEGER)
		do
			leap := a_leap
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_PROGRESS_BAR note option: stable attribute end;

note
	copyright:	"Copyright (c) 1984-2017, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class EV_PROGRESS_BAR_IMP
