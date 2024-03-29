note
	description: "Abstract notions of window which can accept children."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2013-05-30 20:53:24 +0000 (Thu, 30 May 2013) $"
	revision: "$Revision: 92652 $"

deferred class
	WEL_COMPOSITE_WINDOW

inherit
	WEL_WINDOW
		redefine
			minimal_width,
			minimal_height,
			move_and_resize,
			process_message,
			on_getdlgcode,
			on_wm_destroy,
			on_wm_notify,
			destroy
		end

	WEL_GW_CONSTANTS
		export
			{NONE} all
		end

	WEL_WM_CTLCOLOR_CONSTANTS
		export
			{NONE} all
		end

	WEL_ICON_CONSTANTS
		export
			{NONE} all
		end

	WEL_SHARED_FONTS
		export
			{NONE} all
		end

	WEL_SYSTEM_COLORS
		export
			{NONE} all
		end

feature -- Access

	children: LIST [WEL_WINDOW]
			-- Construct a linear representation of children.
		require
			exists: exists
		local
			l_enumerator: WEL_WINDOW_ENUMERATOR
		do
			create l_enumerator
			Result := l_enumerator.enumerate (Current)
		ensure
			result_not_void: Result /= Void
		end

	menu: WEL_MENU
			-- Associated menu
		require
			exists: exists
			has_menu: has_menu
		do
			create Result.make_by_pointer (cwin_get_menu (item))
		ensure
			result_not_void: Result /= Void
		end

	system_menu: WEL_MENU
			-- Associated system menu
		require
			exists: exists
			has_system_menu: has_system_menu
		do
			create Result.make_by_pointer (cwin_get_system_menu (item, False))
		ensure
			result_not_void: Result /= Void
		end

	scroller: detachable WEL_SCROLLER
			-- Scroller object for processing scroll messages.

feature -- Status report

	closeable: BOOLEAN
			-- Can the user close the window?
			-- Yes by default.
		do
			Result := True
		end

	has_menu: BOOLEAN
			-- Does the window have a menu?
		require
			exists: exists
		do
			Result := cwin_get_menu (item) /= default_pointer
		end

	has_system_menu: BOOLEAN
			-- Does the window have a system menu?
		require
			exists: exists
		do
			Result := cwin_get_system_menu (item, False) /=
				default_pointer
		end

	minimal_width: INTEGER
			-- Minimal width allowed for the window
		do
			Result := window_minimum_width
		end

	minimal_height: INTEGER
			-- Minimal height allowed for the window
		do
			Result := window_minimum_height
		end

	horizontal_position: INTEGER
			-- Current position of the horizontal scroll box
		require
			exists: exists
			scroller_exists: scroller /= Void
		do
				-- Per precondition
			if attached scroller as l_scroller then
				Result := l_scroller.horizontal_position
			end
		ensure
			result_small_enough: Result <= maximal_horizontal_position
			result_large_enough: Result >= minimal_horizontal_position
		end

	vertical_position: INTEGER
			-- Current position of the vertical scroll box
		require
			exists: exists
			scroller_exists: scroller /= Void
		do
				-- Per precondition
			if attached scroller as l_scroller then
				Result := l_scroller.vertical_position
			end
		ensure
			result_small_enough: Result <= maximal_vertical_position
			result_large_enough: Result >= minimal_vertical_position
		end

	maximal_horizontal_position: INTEGER
			-- Maxium position of the horizontal scroll box
		require
			exists: exists
			scroller_exists: scroller /= Void
		do
				-- Per precondition
			if attached scroller as l_scroller then
				Result := l_scroller.maximal_horizontal_position
			end
		ensure
			result_large_enough: Result >= minimal_horizontal_position
		end

	maximal_vertical_position: INTEGER
			-- Maxium position of the vertical scroll box
		require
			exists: exists
			scroller_exists: scroller /= Void
		do
				-- Per precondition
			if attached scroller as l_scroller then
				Result := l_scroller.maximal_vertical_position
			end
		ensure
			result_large_enough: Result >= minimal_vertical_position
		end

	minimal_horizontal_position: INTEGER
			-- Minimum position of the horizontal scroll box
		require
			exists: exists
			scroller_exists: scroller /= Void
		do
				-- Per precondition
			if attached scroller as l_scroller then
				Result := l_scroller.minimal_horizontal_position
			end
		ensure
			result_small_enough: Result <= maximal_horizontal_position
		end

	minimal_vertical_position: INTEGER
			-- Minimum position of the vertical scroll box
		require
			exists: exists
			scroller_exists: scroller /= Void
		do
				-- Per precondition
			if attached scroller as l_scroller then
				Result := l_scroller.minimal_vertical_position
			end
		ensure
			result_small_enough: Result <= maximal_vertical_position
		end

	child_window_from_point (point: WEL_POINT): POINTER
			-- `Result' is pointer to child window as position `point'.
			-- Only checks children and their children and returns a child even
			-- if over a HTTRANSPARENT area of the child. Corresponds to
			-- the ChildWindowFromPoint Windows API call.
		require
			point_not_void: point /= Void
			point_exists: point.exists
		do
			Result := cwin_child_window_from_point (item, point.item)
		end

feature -- Status setting

	set_menu (a_menu: WEL_MENU)
			-- Set `menu' with `a_menu'.
		require
			exists: exists
			a_menu_not_void: a_menu /= Void
			a_menu_exists: a_menu.exists
		local
			l_result: INTEGER
		do
			l_result := {WEL_API}.set_menu (item, a_menu.item)
			check l_result /= 0 end
		ensure
			has_menu: has_menu
			menu_set: menu.item = a_menu.item
		end

	unset_menu
			-- Unset the current menu associated to the window.
		require
			exists: exists
		local
			l_result: INTEGER
		do
			l_result := {WEL_API}.set_menu (item, default_pointer)
			check l_result /= 0 end
		ensure
			menu_unset: not has_menu
		end

	set_icon (a_small_icon: WEL_ICON; a_big_icon: WEL_ICON)
			-- Set the small (16x16) and the normal (32x32) icon for this window.
			--
			-- Note: Set `a_small_icon' to Void to remove the small icon and
			--       `a_big_icon' to Void to remove the big icon.
		do
			if a_small_icon /= Void then
				{WEL_API}.send_message (item, Wm_seticon, {WEL_DATA_TYPE}.to_wparam (Icon_small), a_small_icon.item)
			else
				{WEL_API}.send_message (item, Wm_seticon, {WEL_DATA_TYPE}.to_wparam (Icon_small), {WEL_DATA_TYPE}.to_lparam (0))
			end

			if a_big_icon /= Void then
				{WEL_API}.send_message (item, Wm_seticon, {WEL_DATA_TYPE}.to_wparam (Icon_big), a_big_icon.item)
			else
				{WEL_API}.send_message (item, Wm_seticon, {WEL_DATA_TYPE}.to_wparam (Icon_big), {WEL_DATA_TYPE}.to_lparam (0))
			end
		end

	set_horizontal_position (position: INTEGER)
			-- Set `horizontal_position' with `position'.
		require
			exists: exists
			scroller_exists: scroller /= Void
			position_small_enough: attached scroller as l_scroller_var and then
				l_scroller_var.valid_maximal_horizontal_position (position)
			position_large_enough: position >= minimal_horizontal_position
		do
			if attached scroller as l_scroller then
				l_scroller.set_horizontal_position (position)
			end
		ensure
			horizontal_position_set: horizontal_position = position
		end

	set_vertical_position (position: INTEGER)
			-- Set `vertical_position' with `position'.
		require
			exists: exists
			scroller_exists: scroller /= Void
			position_small_enough: attached scroller as l_scroller_var and then
				l_scroller_var.valid_maximal_vertical_position (position)
			position_large_enough: position >= minimal_vertical_position
		do
			if attached scroller as l_scroller then
				l_scroller.set_vertical_position (position)
			end
		ensure
			vertical_position_set: vertical_position = position
		end

	set_horizontal_range (minimum, maximum: INTEGER)
			-- Set `minimal_horizontal_position' and
			-- `maximal_horizontal_position' with `minimum' and
			-- `maximum'.
		require
			exists: exists
			scroller_exists: scroller /= Void
			consistent_range: minimum <= maximum
		do
				-- Per precondition
			if attached scroller as l_scroller then
				l_scroller.set_horizontal_range (minimum, maximum)
			end
		ensure
			minimal_horizontal_position_set: minimal_horizontal_position =
				minimum
			maximal_horizontal_position_set: maximal_horizontal_position =
				maximum
		end

	set_vertical_range (minimum, maximum: INTEGER)
			-- Set `minimal_vertical_position' and
			-- `maximal_vertical_position' with `minimum' and
			-- `maximum'.
		require
			exists: exists
			scroller_exists: scroller /= Void
			consistent_range: minimum <= maximum
		do
				-- Per precondition
			if attached scroller as l_scroller then
				l_scroller.set_vertical_range (minimum, maximum)
			end
		ensure
			minimal_vertical_position_set: minimal_vertical_position =
				minimum
			maximal_vertical_position_set: maximal_vertical_position =
				maximum
		end

	horizontal_update (inc, position: INTEGER)
			-- Update the window and the horizontal scroll box with
			-- `inc' and `position'.
		require
			exists: exists
			scroller_not_void: scroller /= Void
			position_small_enough: attached scroller as l_scroller and then
				l_scroller.valid_maximal_horizontal_position (position)
			position_large_enough: position >= minimal_horizontal_position
		do
			scroll (inc, 0)
			set_horizontal_position (position)
			update
		ensure
			horizontal_position_set: horizontal_position = position
		end

	vertical_update (inc, position: INTEGER)
			-- Update the window and the vertical scroll box with
			-- `inc' and `position'.
		require
			exists: exists
			scroller_not_void: scroller /= Void
			position_small_enough: attached scroller as l_scroller and then
				l_scroller.valid_maximal_vertical_position (position)
			position_large_enough: position >= minimal_vertical_position
		do
			scroll (0, inc)
			set_vertical_position (position)
			update
		ensure
			vertical_position_set: vertical_position = position
		end

feature -- Basic operations

	destroy
			-- Destroy the window and quit the application
			-- if `Current' is the application's main window.
		do
			Precursor {WEL_WINDOW}
			if application_main_window.is_application_main_window (Current) then
				cwin_post_quit_message (0)
			end
		end

	draw_menu
			-- Draw the menu bar associated with the window.
		require
			exists: exists
			has_menu: has_menu
		do
			cwin_draw_menu_bar (item)
		end

	move_absolute (a_x, a_y: INTEGER)
			-- Move the window to `a_x', `a_y' absolute position.
		require
			exists: exists
		local
			point: WEL_POINT
			l_parent: like parent
		do
			l_parent := parent
			if l_parent /= Void then
				create point.make (a_x, a_y)
				point.screen_to_client (l_parent)
				move (point.x, point.y)
			else
				move (a_x, a_y)
			end
		end

	move_and_resize (a_x, a_y, a_width, a_height: INTEGER; repaint: BOOLEAN)
			-- Move the window to `a_x', `a_y' position and
			-- resize it with `a_width', `a_height'.
		local
			point: WEL_POINT
			l_parent: like parent
		do
			l_parent := parent
			if l_parent = Void then
				move_absolute (a_x, a_y)
				resize (a_width, a_height)
				if repaint then
					invalidate
				end
			else
				create point.make (a_x, a_y)
				point.client_to_screen (l_parent)
				Precursor {WEL_WINDOW} (point.x, point.y, a_width, a_height, repaint)
			end
		end

feature {NONE}-- Messages

	notify (control: WEL_CONTROL; notify_code: INTEGER)
			-- A `notify_code' is received for `control'.
		require
			exists: exists
			control_not_void: control /= Void
			control_exists: control.exists
		do
		end

	on_control_command (control: WEL_CONTROL)
			-- A command has been received from `control'.
		require
			exists: exists
			control_not_void: control /= Void
			control_exists: control.exists
		do
		end

	on_control_id_command (control_id: INTEGER)
			-- A command has been received from `control_id'.
		require
			exists: exists
		do
		end

	on_sys_command (a_command, x_pos, y_pos: INTEGER)
			-- Wm_syscommand message.
			-- This message is sent when the user selects a command
			-- from the system menu or when the user selects the
			-- Maximize or Minimize button.
			-- See class WEL_SC_CONSTANTS for `a_command' values.
			-- `x_pos' and `y_pos' specify the x and y coordinates
			-- of the cursor.
		require
			exists: exists
		do
		end

	on_accelerator_command (accelerator_id: INTEGER)
			-- The `acelerator_id' has been activated.
		require
			exists: exists
		do
		end

	on_menu_select (menu_item, flags: INTEGER; a_menu: detachable WEL_MENU)
			-- The `menu_item' from `a_menu' is currently
			-- highlighted by the selection bar. `flags'
			-- indicates the state of `a_menu'.
			-- The selection does not mean that the user has
			-- choosen the option, the option is just highlighted.
		require
			exists: exists
		do
		end

	on_paint (paint_dc: WEL_PAINT_DC; invalid_rect: WEL_RECT)
			-- Wm_paint message.
			-- May be redefined to paint something on
			-- the `paint_dc'. `invalid_rect' defines
			-- the invalid rectangle of the client area that
			-- needs to be repainted.
		require
			exists: exists
			paint_dc_not_void: paint_dc /= Void
			paint_dc_exists: paint_dc.exists
			invalid_rect_not_void: invalid_rect /= Void
			invalid_rect_exists: invalid_rect.exists
		do
		end

	on_vertical_scroll_control (scroll_code, position: INTEGER;
			bar: WEL_BAR)
			-- Vertical scroll is received with a
			-- `scroll_code' type. See class WEL_SB_CONSTANTS
			-- for `scroll_code' values. `position' is the new
			-- scrollbox position. `bar' indicates the scrollbar
			-- or trackbar control activated.
		require
			exists: exists
			bar_not_void: bar /= Void
			bar_exists: bar.exists
		do
		end

	on_horizontal_scroll_control (scroll_code, position: INTEGER;
			bar: WEL_BAR)
			-- Horizontal scroll is received with a
			-- `scroll_code' type. See class WEL_SB_CONSTANTS
			-- for `scroll_code' values. `position' is the new
			-- scrollbox position. `bar' indicates the scroll bar
			-- or track bar control activated.
		require
			exists: exists
			bar_not_void: bar /= Void
			bar_exists: bar.exists
		do
		end

	on_vertical_scroll (scroll_code, position: INTEGER)
			-- Vertical scroll is received with a
			-- `scroll_code' type. See class WEL_SB_CONSTANTS for
			-- `scroll_code' values. `position' is the new
			-- scrollbox position.
		require
			exists: exists
		local
			l_scroller: like scroller
		do
			l_scroller := scroller
			if l_scroller /= Void then
				l_scroller.on_vertical_scroll (scroll_code,
					position)
			end
		end

	on_horizontal_scroll (scroll_code, position: INTEGER)
			-- Horizontal scroll is received with a
			-- `scroll_code' type. See class WEL_SB_CONSTANTS for
			-- `scroll_code' values. `position' is the new
			-- scrollbox position.
		require
			exists: exists
		local
			l_scroller: like scroller
		do
			l_scroller := scroller
			if l_scroller /= Void then
				l_scroller.on_horizontal_scroll (scroll_code,
					position)
			end
		end

	on_draw_item (control_id: POINTER; draw_item: WEL_DRAW_ITEM_STRUCT)
			-- Wm_drawitem message.
			-- A owner-draw control identified by `control_id' has
			-- been changed and must be drawn. `draw_item' contains
			-- information about the item to be drawn and the type
			-- of drawing required.
		require
			exists: exists
			draw_item_not_void: draw_item /= Void
			draw_item_exists: draw_item.exists
		do
		end

	on_color_control (control: WEL_COLOR_CONTROL; paint_dc: WEL_PAINT_DC)
			-- Wm_ctlcolorstatic, Wm_ctlcoloredit, Wm_ctlcolorlistbox
			-- and Wm_ctlcolorscrollbar messages.
			-- To change its default colors, the color-control `control'
			-- needs :
			-- 1. a background color and a foreground color to be selected
			--    in the `paint_dc',
			-- 2. a backgound brush to be returned to the system.
 		require
			exists: exists
			control_not_void: control /= Void
			control_exists: control.exists
			paint_dc_not_void: paint_dc /= Void
			paint_dc_exists: paint_dc.exists
		do
				-- Typical implementation:
				-- paint_dc.set_text_color (control.foreground_color)
				-- paint_dc.set_background_color (control.background_color)
				-- create brush.make_solid (control.background_color)
				-- set_message_return_value (brush.item)
				-- disable_default_processing
		end

	on_get_min_max_info (min_max_info: WEL_MIN_MAX_INFO)
			-- Wm_getminmaxinfo message.
			-- The size or position of the window is about to
			-- change. An application can change `min_max_info' to
			-- override the window's default maximized size and
			-- position, or its default minimum or maximum tracking
			-- size.
		require
			exists: exists
			min_max_info_not_void: min_max_info /= Void
			min_max_info_exists: min_max_info.exists
		do
		end

	on_palette_is_changing (window: detachable WEL_WINDOW)
			-- Wm_paletteischanging.
			-- Inform that an application is going to realize its
			-- logical palette. `window' identifies the window
			-- that is going to realize its logical palette.
		require
			exists: exists
		do
		end

	on_palette_changed (window: detachable WEL_WINDOW)
			-- Wm_palettechanged message.
			-- This message is sent after the window with the
			-- keyboard focus has realized its logical palette.
			-- `window' identifies the window that caused the
			-- system palette to change.
		require
			exists: exists
		do
		end

	on_query_new_palette
			-- Wm_querrynewpalette message.
			-- Inform an application that is about to receive the
			-- keyboard focus, giving the application an opportunity
			-- to realize its logical palette when it receives the
			-- focus. If the window realizes its logical palette,
			-- it must return True; otherwise it must return False.
			-- (False by default)
		require
			exists: exists
		do
		end

	on_getdlgcode
			-- Called when window receives WM_GETDLGCODE message.
		do
			set_message_return_value (to_lresult ({WEL_DLGC_CONSTANTS}.dlgc_want_all_keys))
		end

feature {WEL_MENU} -- Messages

	on_menu_command (menu_id: INTEGER)
			-- The `menu_id' has been choosen from the menu.
		require
			exists: exists
		do
		end

feature {NONE} -- Implementation

	on_wm_notify (wparam, lparam: POINTER)
			-- Wm_notify message
		local
			info: WEL_NMHDR
		do
			create info.make_by_pointer (lparam)
			on_notify (wparam.to_integer_32, info)
			if attached {WEL_CONTROL} info.window_from as control and then control.exists then
				control.increment_level
				control.process_notification_info (info)
				if control.has_return_value then
					set_message_return_value (control.message_return_value)
				end
				control.decrement_level
			end
		end

	on_wm_command (wparam, lparam: POINTER)
			-- Wm_command message.
			-- Dispatch a Wm_command message to
			-- `on_wm_control_id_command', `on_control_command'
			-- `on_menu_command', or `on_accelerator_command'.
		require
			exists: exists
		local
			control_id: INTEGER
			hwnd_control: POINTER
			notify_code: INTEGER
		do
			control_id := cwin_get_wm_command_id (wparam, lparam)
			hwnd_control := cwin_get_wm_command_hwnd (wparam, lparam)
			notify_code := cwin_get_wm_command_cmd (wparam, lparam)
			if hwnd_control /= default_pointer then
				-- Message comes from a control
				on_wm_control_id_command (control_id)
				if is_window (hwnd_control) then
					if attached {WEL_CONTROL} window_of_item (hwnd_control) as control then
						if exists and then control.exists then
							on_control_command (control)
						end
						if exists and then control.exists then
							notify (control, notify_code)
						end
						if control.exists then
							control.process_notification (notify_code)
						end
					end
				end
			elseif notify_code = 0 then
				-- Message comes from a menu
				on_wm_menu_command (control_id)
			elseif notify_code = 1 then
				-- Message comes from an accelerator
				on_accelerator_command (control_id)
			end
		end

	on_wm_control_id_command (control_id: INTEGER)
			-- Wm_command from a `control_id'.
		require
			exists: exists
		do
			on_control_id_command (control_id)
		end

	on_wm_menu_command (menu_id: INTEGER)
			-- Wm_command from a `menu_id'.
		require
			exists: exists
		do
			on_menu_command (menu_id)
		end

	on_wm_menu_select (wparam, lparam: POINTER)
			-- Wm_menuselect message.
		require
			exists: exists
		local
			p: POINTER
			a_menu: WEL_MENU
		do
			p := cwin_get_wm_menuselect_hmenu (wparam, lparam)
			if p /= default_pointer then
				create a_menu.make_by_pointer (p)
				on_menu_select (cwin_get_wm_menuselect_cmd (wparam, lparam),
					cwin_get_wm_menuselect_flags (wparam, lparam), a_menu)
			else
				on_menu_select (cwin_get_wm_menuselect_cmd (wparam, lparam),
					cwin_get_wm_menuselect_flags (wparam, lparam), Void)
			end
		end

	on_wm_paint (wparam: POINTER)
			-- Wm_paint message.
			-- A WEL_DC and WEL_PAINT_STRUCT are created and
			-- passed to the `on_paint' routine.
			-- To be more efficient when the windows does not
			-- need to paint something, this routine can be
			-- redefined to do nothing (eg. The object creation are
			-- useless).
		require
			exists: exists
		local
			paint_dc: WEL_PAINT_DC
			l_scroller: like scroller
		do
			create paint_dc.make_by_pointer (Current, wparam)
			paint_dc.get
			l_scroller := scroller
			if l_scroller /= Void then
				paint_dc.set_viewport_origin (-l_scroller.horizontal_position,
					-l_scroller.vertical_position)
			end
			on_paint (paint_dc, paint_dc.paint_struct.rect_paint)
			paint_dc.release
		end

	on_wm_vscroll (wparam, lparam: POINTER)
			-- Wm_vscroll message.
		require
			exists: exists
		local
			p: POINTER
		do
			p := cwin_get_wm_vscroll_hwnd (wparam, lparam)
			if p /= default_pointer then
				if
					attached {WEL_BAR} window_of_item (p) as l_bar and then
					l_bar.exists
				then
					-- The message comes from a scroll bar control
					on_vertical_scroll_control (cwin_get_wm_vscroll_code (wparam, lparam),
						cwin_get_wm_vscroll_pos (wparam, lparam), l_bar)
				end
			else
				-- The message comes from a window scroll bar
				on_vertical_scroll (cwin_get_wm_vscroll_code (wparam, lparam),
					cwin_get_wm_vscroll_pos (wparam, lparam))
			end
		end

	on_wm_hscroll (wparam, lparam: POINTER)
			-- Wm_hscroll message.
		require
			exists: exists
		local
			p: POINTER
		do
			p := cwin_get_wm_hscroll_hwnd (wparam, lparam)
			if p /= default_pointer then
				if
					attached {WEL_BAR} window_of_item (p) as l_bar and then
					l_bar.exists
				then
					-- The message comes from a scroll bar control
					on_horizontal_scroll_control (cwin_get_wm_hscroll_code (wparam, lparam),
						cwin_get_wm_hscroll_pos (wparam, lparam), l_bar)
				end
			else
				-- The message comes from a window scroll bar
				on_horizontal_scroll (cwin_get_wm_hscroll_code (wparam, lparam),
					cwin_get_wm_hscroll_pos (wparam, lparam))
			end
		end

	on_wm_draw_item (wparam, lparam: POINTER)
			-- Wm_drawitem message
		require
			exists: exists
		local
			di: WEL_DRAW_ITEM_STRUCT
		do
			create di.make_by_pointer (lparam)
			on_draw_item (wparam, di)
		end

	on_wm_get_min_max_info (lparam: POINTER)
			-- Wm_getminmaxinfo message
		require
			exists: exists
		local
			mmi: WEL_MIN_MAX_INFO
		do
			create mmi.make_by_pointer (lparam)
			on_get_min_max_info (mmi)
		end

	on_wm_ctlcolor (wparam, lparam: POINTER)
			-- Common routine for Wm_ctlcolor messages.
		require
			exists: exists
		local
			hwnd_control: POINTER
			paint_dc: WEL_PAINT_DC
		do
			hwnd_control := cwin_get_wm_command_hwnd (wparam, lparam)
			if
				hwnd_control /= default_pointer and then
				attached {WEL_COLOR_CONTROL} window_of_item (hwnd_control) as control and then
				control.exists
			then
				create paint_dc.make_by_pointer (Current, wparam)
				on_color_control (control, paint_dc)
			end
		end

	on_wm_close
			-- Wm_close message.
			-- If `closeable' is False further processing is halted.
		require
			exists: exists
		do
			set_default_processing (closeable)
		end

	on_wm_destroy
			-- Wm_destroy message.
			-- Quit the application if `Current' is the
			-- application's main window.
		do
			on_destroy
			if application_main_window.is_application_main_window (Current) then
				cwin_post_quit_message (0)
			end
		end

	on_wm_setting_change
			-- Wm_settingchange message
			-- Update the system fonts.
		do
				-- Invalidate the fonts
			menu_font_cell.put (Void)
			message_font_cell.put (Void)
			status_font_cell.put (Void)
			caption_font_cell.put (Void)
			small_caption_font_cell.put (Void)
		end

	on_wm_syscolor_change
			-- Wm_syscolorchange message
			-- Update the system colors.
		local
			child_wnd: LIST [WEL_WINDOW]
		do
				-- Invalidate the colors
			system_color_scrollbar_cell.put (Void)
			system_color_background_cell.put (Void)
			system_color_activecaption_cell.put (Void)
			system_color_inactivecaption_cell.put (Void)
			system_color_menu_cell.put (Void)
			system_color_window_cell.put (Void)
			system_color_windowframe_cell.put (Void)
			system_color_menutext_cell.put (Void)
			system_color_windowtext_cell.put (Void)
			system_color_captiontext_cell.put (Void)
			system_color_activeborder_cell.put (Void)
			system_color_inactiveborder_cell.put (Void)
			system_color_appworkspace_cell.put (Void)
			system_color_highlight_cell.put (Void)
			system_color_highlighttext_cell.put (Void)
			system_color_btnface_cell.put (Void)
			system_color_btnshadow_cell.put (Void)
			system_color_graytext_cell.put (Void)
			system_color_btntext_cell.put (Void)
			system_color_inactivecaptiontext_cell.put (Void)
			system_color_btnhighlight_cell.put (Void)

			 -- Propagate the message to the children
			child_wnd := children
			from
				child_wnd.start
			until
				child_wnd.after
			loop
				if attached {WEL_CONTROL} child_wnd.item as control then
					{WEL_API}.send_message (child_wnd.item.item, Wm_syscolorchange, {WEL_DATA_TYPE}.to_wparam (0), {WEL_DATA_TYPE}.to_lparam (0))
				end
				child_wnd.forth
			end
		end

	application_main_window: WEL_APPLICATION_MAIN_WINDOW
			-- Once object used by `on_wm_destroy' to test if `Current'
			-- is the application's main window.
		once
			create Result
		ensure
			result_not_void: Result /= Void
		end

feature {WEL_DISPATCHER}

	frozen composite_process_message, process_message (hwnd: POINTER;
			msg: INTEGER; wparam, lparam: POINTER): POINTER
		local
			called: BOOLEAN
			l_message: detachable WEL_COMMAND_EXEC
			l_commands: like commands
		do
			inspect msg
			when Wm_paint then
				on_wm_paint (wparam)
			when Wm_ctlcolorstatic then
				on_wm_ctlcolor (wparam, lparam)
			when Wm_ctlcoloredit then
				on_wm_ctlcolor (wparam, lparam)
			when Wm_ctlcolorlistbox then
				on_wm_ctlcolor (wparam, lparam)
			when Wm_ctlcolorscrollbar then
				on_wm_ctlcolor (wparam, lparam)
			when Wm_ctlcolorbtn then
				on_wm_ctlcolor (wparam, lparam)
			when Wm_command then
				on_wm_command (wparam, lparam)
			when Wm_syscommand then
				on_sys_command (wparam.to_integer_32, cwin_lo_word (lparam), cwin_hi_word (lparam))
			when Wm_menuselect then
				on_wm_menu_select (wparam, lparam)
			when Wm_vscroll then
				on_wm_vscroll (wparam, lparam)
			when Wm_hscroll then
				on_wm_hscroll (wparam, lparam)
			when Wm_drawitem then
				on_wm_draw_item (wparam, lparam)
			when Wm_getminmaxinfo then
				on_wm_get_min_max_info (lparam)
			when Wm_paletteischanging then
				on_palette_is_changing (window_of_item (wparam))
			when Wm_palettechanged then
				on_palette_changed (window_of_item (wparam))
			when Wm_querynewpalette then
				on_query_new_palette
			when Wm_settingchange then
				on_wm_setting_change
			when Wm_syscolorchange then
				on_wm_syscolor_change
			when Wm_close then
				on_wm_close
			else
				called := True
				-- Call the `process_message' routine of the
				-- parent class.
				Result := window_process_message (hwnd, msg, wparam, lparam)
			end
			if not called then
				l_commands := commands
				if l_commands /= Void and then commands_enabled and then l_commands.has (msg) then
					l_message := l_commands.item (msg)
						-- Per checking.
					check l_message_attached: l_message /= Void then end
					l_message.execute (Current, msg, wparam, lparam)
				end
			end
		end

feature {NONE} -- Externals

	cwin_draw_menu_bar (hwnd: POINTER)
			-- SDK DrawMenuBar
		external
			"C [macro <wel.h>] (HWND)"
		alias
			"DrawMenuBar"
		end

	cwin_get_menu (hwnd: POINTER): POINTER
			-- SDK GetMenu
		external
			"C [macro <wel.h>] (HWND): EIF_POINTER"
		alias
			"GetMenu"
		end

	cwin_get_system_menu (hwnd: POINTER; revert: BOOLEAN): POINTER
			-- SDK GetSystemMenu
		external
			"C [macro <wel.h>] (HWND, BOOL): EIF_POINTER"
		alias
			"GetSystemMenu"
		end

	cwin_post_quit_message (exit_code: INTEGER)
			-- SDK PostQuitMessage
		external
			"C [macro <wel.h>] (int)"
		alias
			"PostQuitMessage"
		end

	cwin_get_wm_command_id (wparam, lparam: POINTER): INTEGER
		external
			"C [macro <winx.h>] (WPARAM, LPARAM): EIF_INTEGER"
		alias
			"GET_WM_COMMAND_ID"
		end

	cwin_get_wm_command_hwnd (wparam, lparam: POINTER): POINTER
		external
			"C [macro <winx.h>] (WPARAM, LPARAM): EIF_POINTER"
		alias
			"GET_WM_COMMAND_HWND"
		end

	cwin_get_wm_command_cmd (wparam, lparam: POINTER): INTEGER
		external
			"C [macro <winx.h>] (WPARAM, LPARAM): EIF_INTEGER"
		alias
			"GET_WM_COMMAND_CMD"
		end

	cwin_get_wm_menuselect_cmd (wparam, lparam: POINTER): INTEGER
		external
			"C [macro <winx.h>] (WPARAM, LPARAM): EIF_INTEGER"
		alias
			"GET_WM_MENUSELECT_CMD"
		end

	cwin_get_wm_menuselect_flags (wparam, lparam: POINTER): INTEGER
		external
			"C [macro <winx.h>] (WPARAM, LPARAM): EIF_INTEGER"
		alias
			"GET_WM_MENUSELECT_FLAGS"
		end

	cwin_get_wm_menuselect_hmenu (wparam, lparam: POINTER): POINTER
		external
			"C [macro <winx.h>] (WPARAM, LPARAM): EIF_POINTER"
		alias
			"GET_WM_MENUSELECT_HMENU"
		end

	cwin_get_wm_vscroll_code (wparam, lparam: POINTER): INTEGER
		external
			"C [macro <winx.h>] (WPARAM, LPARAM): EIF_INTEGER"
		alias
			"GET_WM_VSCROLL_CODE"
		end

	cwin_get_wm_vscroll_pos (wparam, lparam: POINTER): INTEGER
		external
			"C [macro <winx.h>] (WPARAM, LPARAM): EIF_INTEGER"
		end

	cwin_get_wm_vscroll_hwnd (wparam, lparam: POINTER): POINTER
		external
			"C [macro <winx.h>] (WPARAM, LPARAM): EIF_POINTER"
		alias
			"GET_WM_VSCROLL_HWND"
		end

	cwin_get_wm_hscroll_code (wparam, lparam: POINTER): INTEGER
		external
			"C [macro <winx.h>] (WPARAM, LPARAM): EIF_INTEGER"
		alias
			"GET_WM_HSCROLL_CODE"
		end

	cwin_get_wm_hscroll_pos (wparam, lparam: POINTER): INTEGER
		external
			"C [macro <winx.h>] (WPARAM, LPARAM): EIF_INTEGER"
		end

	cwin_get_wm_hscroll_hwnd (wparam, lparam: POINTER): POINTER
		external
			"C [macro <winx.h>] (WPARAM, LPARAM): EIF_POINTER"
		alias
			"GET_WM_HSCROLL_HWND"
		end

	cwin_child_window_from_point (hwnd: POINTER; point: POINTER): POINTER
		external
			"C inline use <windows.h>"
		alias
			"ChildWindowFromPoint ((HWND) $hwnd, *(POINT *) $point)"
		end

note
	copyright:	"Copyright (c) 1984-2013, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class WEL_COMPOSITE_WINDOW

