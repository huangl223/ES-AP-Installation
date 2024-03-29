note
	description: "This class creates a message information object %
		%corresponding to a given message."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2009-01-25 02:01:47 +0000 (Sun, 25 Jan 2009) $"
	revision: "$Revision: 76831 $"

class
	WEL_MESSAGE_INFORMATION_CREATOR

inherit
	ANY

	WEL_WM_CONSTANTS
		export
			{NONE} all
		end

create
	make

feature -- Initialization

	make (window: WEL_WINDOW; message: INTEGER; wparam, lparam: POINTER)
			-- Make `message_information' corresponding to
			-- `message' by using `wparam' and `lparam'.
		require
			window_not_void: window /= Void
			positive_message: message >= 0
		local
			l_message: like message_information
		do
			if message = Wm_size then
				create {WEL_SIZE_MESSAGE} l_message.make (window, message, wparam, lparam)
			elseif message = Wm_move then
				create {WEL_MOVE_MESSAGE} l_message.make (window, message, wparam, lparam)
			elseif message = Wm_command then
				create {WEL_COMMAND_MESSAGE} l_message.make (window, message, wparam, lparam)
			elseif message = Wm_syscommand then
				create {WEL_SYSTEM_COMMAND_MESSAGE} l_message.make (window, message, wparam, lparam)
			elseif message = Wm_timer then
				create {WEL_TIMER_MESSAGE} l_message.make (window, message, wparam, lparam)
			elseif message = Wm_showwindow then
				create {WEL_SHOW_WINDOW_MESSAGE} l_message.make (window, message, wparam, lparam)
			elseif message = Wm_menuselect then
				create {WEL_MENU_SELECT_MESSAGE} l_message.make (window, message, wparam, lparam)
			elseif message = Wm_windowposchanged or
				message = Wm_windowposchanging then
				create {WEL_WINDOW_POSITION_MESSAGE} l_message.make (window, message, wparam, lparam)
			elseif message = Wm_notify then
				create {WEL_NOTIFY_MESSAGE} l_message.make (window, message, wparam, lparam)
			elseif
				message = Wm_char or
				message = Wm_syschar or
				message = Wm_keydown or
				message = Wm_keyup or
				message = Wm_syskeydown or
				message = Wm_syskeyup
			then
				create {WEL_KEY_MESSAGE} l_message.make (window, message, wparam, lparam)
			elseif
				message = Wm_mousemove or
				message = Wm_lbuttondown or
				message = Wm_mbuttondown or
				message = Wm_rbuttondown or
				message = Wm_lbuttonup or
				message = Wm_mbuttonup or
				message = Wm_rbuttonup or
				message = Wm_lbuttondblclk or
				message = Wm_mbuttondblclk or
				message = Wm_rbuttondblclk
			then
				create {WEL_MOUSE_MESSAGE} l_message.make (window, message, wparam, lparam)
			else
				-- `message' is not handled by WEL.
				-- Let's create a generic message object.
				create l_message.make (window, message, wparam, lparam)
			end
			message_information := l_message
		end

feature -- Access

	message_information: WEL_MESSAGE_INFORMATION;
			-- Information about `message'.

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




end -- class WEL_MESSAGE_INFORMATION_CREATOR

