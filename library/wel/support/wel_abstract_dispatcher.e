﻿note
	description: "Receives and dispatch the Windows messages to the Eiffel objects."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2020-05-19 14:50:38 +0000 (Tue, 19 May 2020) $"
	revision: "$Revision: 104274 $"

deferred class
	WEL_ABSTRACT_DISPATCHER

inherit
	WEL_WINDOWS_ROUTINES
		export
			{NONE} all
		end

	WEL_DIALOG_MANAGER
		export
			{NONE} all
		end

	WEL_DATA_TYPE
		export
			{NONE} all
		end

	WEL_WM_CONSTANTS
		export
			{NONE} all
		end

	WEL_EN_CONSTANTS
		-- debug

	EXCEPTION_MANAGER_FACTORY
		export
			{NONE} all
		end

	WEL_RESIZING_SUPPORT
		export
			{NONE} all
		end

feature {NONE} -- Initialization

	make
		do
				-- We ensure creation of the `silly_window' before any other WEL operation
				-- are taking place.
			silly_window.do_nothing
		end

feature -- Settings

	set_exception_callback (an_action: like exception_callback)
			-- Set `exception_callback' with `an_action'.
		do
			exception_callback := an_action
		ensure
			exception_callback_set: exception_callback = an_action
		end

feature {NONE} -- Implementation: Access

	exception_callback: detachable PROCEDURE [EXCEPTION]
			-- Action being executed when an exception occurs during

feature {NONE} -- Implementation

	frozen window_procedure (hwnd: POINTER; msg: INTEGER; wparam, lparam: POINTER): POINTER
			-- Window messages dispatcher routine
		local
			window: detachable WEL_WINDOW
			returned_value: POINTER
			has_return_value: BOOLEAN
			need_decrement: BOOLEAN
			retried: BOOLEAN
			l_callback: like exception_callback
		do
			if not retried then
				window := window_of_item (hwnd)
				if window /= Void then
					if window.exists then
						debug ("win_dispatcher")
							print ("After look at windows table ")
							print (window.generating_type)
							io.put_new_line
						end
						window.increment_level
						need_decrement := True

						Result := window.process_message (hwnd, msg, wparam, lparam)
							--| Store `message_return_value' and `has_return_value' for later
							--| use, since `call_default_window_procedure' can reset their value.
						if
							window.has_return_value
						then
							returned_value := window.message_return_value
							has_return_value := window.has_return_value
						end

						if window.default_processing then
							Result := window.call_default_window_procedure (hwnd, msg, wparam, lparam)
						end

						if has_return_value then
							Result := returned_value
						end

						window.decrement_level
						need_decrement := False
					else
						Result := window.call_default_window_procedure (hwnd, msg, wparam, lparam)
					end
				else
					Result := cwin_def_window_proc (hwnd, msg, wparam, lparam)
				end
			else
					-- Something wrong occurred here, perform default action
				Result := cwin_def_window_proc (hwnd, msg, wparam, lparam)
					-- And call `exception_callback' if it is set
				l_callback := exception_callback
				if l_callback /= Void then
					l_callback.call ([new_exception])
				end
			end
		rescue
			if window /= Void and then need_decrement then
				window.decrement_level
				need_decrement := False
			end
			retried := True
			retry
		end

	frozen dialog_procedure (hwnd: POINTER; msg: INTEGER; wparam, lparam: POINTER): POINTER
			-- Dialog box messages dispatcher routine
		local
			window: detachable WEL_WINDOW
			need_decrement: BOOLEAN
			retried: BOOLEAN
			l_callback: like exception_callback
		do
			if not retried then
				debug ("dlg_dispatcher")
					io.put_string ("in dlg_proc ")
					io.put_string_32 (hwnd.out)
					io.put_character (' ')
					io.put_integer (msg)
					io.put_character (' ')
					io.put_boolean (msg = Wm_initdialog)
					io.put_new_line
				end
				if msg = Wm_initdialog then
					window := new_dialog
					if window /= Void then
						new_dialog_cell.put (Void)
						window.increment_level
						need_decrement := True

						-- Special case for the message
						-- Wm_initdialog. We set the hwnd value
						-- to the object because this value
						-- was unknown until now.
						--| Since it is not possible to check
						--| if `set_focus' from WEL_WINDOW has been
						--| called, Result is set to `1'.
						--| As a result, any call to `set_focus' in
						--| `setup_dialog' from WEL_DIALOG is useless.
						window.set_item (hwnd)
						window.register_current_window
						Result := window.process_message (hwnd, msg, wparam, lparam)
						window.decrement_level
						need_decrement := False
					end
					Result := to_lresult (1)
				else
					window := window_of_item (hwnd)
					if window /= Void and then window.exists then
						window.increment_level
						need_decrement := True
						window.process_message (hwnd, msg, wparam, lparam).do_nothing
						if window.has_return_value then
							Result := window.message_return_value
						else
							if not window.default_processing then
								Result := to_lresult (1)
							else
								Result := to_lresult (0)
							end
						end
						window.decrement_level
						need_decrement := False
					end
				end
			else
					-- Something wrong occurred here, perform default action
				Result := to_lresult (0)
					-- And call `exception_callback' if it is set
				l_callback := exception_callback
				if l_callback /= Void then
					l_callback.call ([new_exception])
				end
			end
		rescue
			if window /= Void and then need_decrement then
				window.decrement_level
				need_decrement := False
			end
			retried := True
			retry
		end

	new_exception: EXCEPTION
			-- New exception object representating the last exception caught in Current.
		require
			exception_manager.last_exception /= Void
		do
			Result := exception_manager.last_exception
			check from_precondition : attached Result then end
		end

feature {NONE} -- Externals

	cwin_def_window_proc (hwnd: POINTER; msg: INTEGER; wparam, lparam: POINTER): POINTER
			-- SDK DefWindowProc
		external
			"C [macro <windows.h>] (HWND, UINT, WPARAM, LPARAM): LRESULT"
		alias
			"DefWindowProc"
		end

note
	copyright:	"Copyright (c) 1984-2020, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class WEL_ABSTRACT_DISPATCHER
