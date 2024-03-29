﻿note
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2018-01-22 13:07:09 +0000 (Mon, 22 Jan 2018) $"
	revision: "$Revision: 101256 $"

deferred class
	EV_WEL_CONTROL_WINDOW

inherit
	WEL_CONTROL_WINDOW
		rename
			make as wel_make,
			parent as wel_parent,
			set_parent as wel_set_parent,
			shown as is_displayed,
			font as wel_font,
			set_font as wel_set_font,
			destroy as wel_destroy,
			width as wel_width,
			height as wel_height,
			enabled as is_sensitive,
			item as wel_item,
			move as wel_move,
			resize as wel_resize,
			move_and_resize as wel_move_and_resize,
			x as x_position,
			y as y_position,
			has_capture as wel_has_capture
		undefine
			set_width,
			set_height,
			on_mouse_move,
			on_left_button_down,
			on_middle_button_down,
			on_right_button_down,
			on_left_button_up,
			on_middle_button_up,
			on_right_button_up,
			on_left_button_double_click,
			on_middle_button_double_click,
			on_right_button_double_click,
			on_key_up,
			on_mouse_wheel,
			on_set_focus,
			on_kill_focus,
			on_desactivate,
			on_set_cursor,
			on_paint,
			on_key_down,
			on_char,
			show,
			hide,
			on_size,
			x_position,
			y_position,
			on_sys_key_up,
			default_process_message
		redefine
			class_style
		end

feature {NONE} -- Implementation

	class_style: INTEGER
			-- Standard style used to create the window class.
			-- Can be redefined to return a user-defined style.
		once
			Result := Cs_dblclks
		end

	cwin_get_next_dlgtabitem (hdlg, hctl: POINTER; previous: BOOLEAN): POINTER
			-- SDK GetNextDlgTabItem
		do
			Result := {WEL_CONTROL}.c_cwin_get_next_dlgtabitem (hdlg, hctl, previous)
		end

note
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
