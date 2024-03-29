note
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date: 2018-01-22 12:53:58 +0000 (Mon, 22 Jan 2018) $"
	revision: "$Revision: 101255 $"

class
	WEL_NOTIFY_ICON_DATA

inherit
	WEL_STRUCTURE
		redefine
			make
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Allocate `item' and initialize `cbSize' field.
		do
			Precursor {WEL_STRUCTURE}
			c_set_cbsize (item, structure_size)
		end

feature -- Access

	window: detachable WEL_WINDOW
			-- Associated window processing messages for Current.

	icon: detachable WEL_ICON
			-- Associated icon displayed in taskbar.

	tooltip_text: STRING_32
			-- Associated tooltip if any.
		require
			exists: exists
			valid_flags: (uflags & {WEL_NIF_CONSTANTS}.nif_icon) = {WEL_NIF_CONSTANTS}.nif_icon
		local
			l_str: WEL_STRING
		do
			create l_str.share_from_pointer_and_count (c_sztip (item), tooltip_text_size)
			Result := l_str.string
		ensure
			tooltip_text_not_void: Result /= Void
		end

	uflags: INTEGER
			-- Flags that indicate which of the other members contain valid data.
			-- This member can be a combination of the following:
			-- NIF_ICON: `icon' is valid.
			-- NIF_MESSAGE: `callback_message' is valid.
			-- NIF_TIP: `tooltip_text' is valid.
			-- NIF_STATE: The dwState and dwStateMask members are valid.
			-- NIF_INFO: Use a balloon ToolTip instead of a standard ToolTip.
			--           The szInfo, uTimeout, szInfoTitle, and dwInfoFlags members are valid.
			-- NIF_GUID: Reserved.
		require
			exists: exists
		do
			Result := c_uflags (item)
		end

	callback_message: INTEGER
		require
			exists: exists
		do
			Result := c_ucallback_message (item)
		end

feature -- Settings

	set_window (a_window: detachable WEL_WINDOW)
			-- Set `window' with `a_window'.
		require
			exists: exists
		do
			window := a_window
			if a_window = Void then
				c_set_hwnd (item, default_pointer)
			else
				c_set_hwnd (item, a_window.item)
			end
		ensure
			window_set: window = a_window
		end

	set_icon (a_icon: detachable WEL_ICON)
			-- Set `icon' with `a_icon'.
		require
			exists: exists
			a_icon_exists: a_icon /= Void implies a_icon.exists
		do
			icon := a_icon
			if a_icon = Void then
				c_set_icon (item, default_pointer)
			else
				c_set_icon (item, a_icon.item)
			end
		ensure
			icon_set: icon = a_icon
		end

	set_tooltip_text (a_str: detachable READABLE_STRING_GENERAL)
			-- Set `a_str' as `tooltip_text'.
		require
			exists: exists
			valid_size: a_str /= Void implies a_str.count < tooltip_text_size
		local
			l_str: WEL_STRING
		do
			create l_str.share_from_pointer_and_count (c_sztip (item), 64)
			if a_str = Void then
				l_str.set_count (0)
			else
				l_str.set_string (a_str)
			end
		ensure
			tooltip_text_set: equal (a_str, tooltip_text)
		end

	set_uflags (a_uflags: INTEGER)
			-- Set `uflags' with `a_uflags'.
		require
			exists: exists
		do
			c_set_uflags (item, a_uflags)
		ensure
			flags_set: uflags = a_uflags
		end

	set_callback_message (a_id: INTEGER)
			-- Set `callback_message' with `a_id'.
		require
			exists: exists
		do
			c_set_ucallback_message (item, a_id)
		ensure
			callback_message_set: callback_message = a_id
		end

feature -- Sizing

	structure_size: INTEGER
			-- Size of NOTIFYICONDATA structure.
		do
			Result := c_structure_size
		end

	tooltip_text_size: INTEGER
			-- Size of tooltip text.
		require
			exists: exists
		do
			Result := c_sztip_size (item)
		ensure
			tooltip_text_size_non_negative: Result >= 0
		end

feature {NONE} -- Implementation: Access

	c_structure_size: INTEGER
			-- Size of NOTIFYICONDATA structure.
		external
			"C inline use <shellapi.h>"
		alias
			"sizeof(NOTIFYICONDATA)"
		end

	c_ucallback_message (a_ptr: POINTER): INTEGER
		external
			"C inline use <shellapi.h>"
		alias
			"((NOTIFYICONDATA *) $a_ptr)->uCallbackMessage"
		end

	c_uflags (a_ptr: POINTER): INTEGER
		external
			"C inline use <shellapi.h>"
		alias
			"((NOTIFYICONDATA *) $a_ptr)->uFlags"
		end

	c_sztip_size (a_ptr: POINTER): INTEGER
		external
			"C inline use <shellapi.h>"
		alias
			"sizeof(((NOTIFYICONDATA *) $a_ptr)->szTip)"
		end

	c_sztip (a_ptr: POINTER): POINTER
		external
			"C inline use <shellapi.h>"
		alias
			"((NOTIFYICONDATA *) $a_ptr)->szTip"
		end

feature {NONE} -- Implementation: Settings

	c_set_cbsize (a_ptr: POINTER; a_size: INTEGER)
		external
			"C inline use <shellapi.h>"
		alias
			"((NOTIFYICONDATA *) $a_ptr)->cbSize = $a_size"
		end

	c_set_hwnd (a_ptr: POINTER; a_hwnd: POINTER)
		external
			"C inline use <shellapi.h>"
		alias
			"((NOTIFYICONDATA *) $a_ptr)->hWnd = $a_hwnd"
		end

	c_set_icon (a_ptr: POINTER; a_icon: POINTER)
		external
			"C inline use <shellapi.h>"
		alias
			"((NOTIFYICONDATA *) $a_ptr)->hIcon = $a_icon"
		end

	c_set_uflags (a_ptr: POINTER; a_flags: INTEGER)
		external
			"C inline use <shellapi.h>"
		alias
			"((NOTIFYICONDATA *) $a_ptr)->uFlags = $a_flags"
		end

	c_set_ucallback_message (a_ptr: POINTER; a_id: INTEGER)
		external
			"C inline use <shellapi.h>"
		alias
			"((NOTIFYICONDATA *) $a_ptr)->uCallbackMessage = $a_id"
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
