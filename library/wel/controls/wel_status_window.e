note
	description: "[
		A window containing one or several parts which can
		display text or can be owner drawn.
		
		Note: The common controls dll (WEL_COMMON_CONTROLS_DLL) needs to
		be loaded to use this control.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2015-08-19 00:59:46 +0000 (Wed, 19 Aug 2015) $"
	revision: "$Revision: 97833 $"

class
	WEL_STATUS_WINDOW

inherit
	WEL_CONTROL
		redefine
			set_text,
			text,
			text_substring,
			text_length
		end

	WEL_STATUS_WINDOW_CONSTANTS
		export
			{NONE} all
		end

	WEL_SBT_CONSTANTS
		export
			{NONE} all
		end

	WEL_WORD_OPERATIONS
		export
			{NONE} all
		end

create
	make,
	make_by_id

feature {NONE} -- Initialization

	make (a_parent: WEL_WINDOW; an_id: INTEGER)
			-- Create a status window with `a_parent' as parent and
			-- `an_id' as id.
		require
			a_parent_not_void: a_parent /= Void
			a_parent_exists: a_parent.exists
		do
			internal_window_make (a_parent, Void, default_style,
				0, 0, 0, 0, an_id, default_pointer)
			id := an_id
		ensure
			exists: exists
			parent_set: parent = a_parent
			id_set: id = an_id
		end

feature -- Status report

	number_of_parts: INTEGER
			-- Current number of parts
		require
			exists: exists
		do
			Result := {WEL_API}.send_message_result_integer (item, Sb_getparts,
				to_wparam (0), to_lparam (0))
		ensure
			positive_result: Result > 0
		end

	text_for_part (index: INTEGER): STRING_32
			-- Text for the part identified by the zero-based
			-- `index'.
		require
			exists: exists
			index_small_enough: index < number_of_parts
			index_large_enough: index >= 0
		local
			a_wel_string: WEL_STRING
			nb: INTEGER
		do
			create Result.make (text_length_for_part (index))
			Result.fill_blank
			create a_wel_string.make (Result)
			nb := {WEL_API}.send_message_result_integer (item,
				Sb_gettext, to_wparam (index), a_wel_string.item)
			Result := a_wel_string.string
			Result.keep_head (nb)
		ensure
			result_not_void: Result /= Void
			consistent_count: Result.count =
				text_length_for_part (index)
		end

	text_length_for_part (index: INTEGER): INTEGER
			-- Length of the text in the part identified by the
			-- zero-based `index'.
		require
			exists: exists
			index_small_enough: index < number_of_parts
			index_large_enough: index >= 0
		do
			Result := cwin_lo_word ({WEL_API}.send_message_result (item,
				Sb_gettextlength, to_wparam (index), to_lparam (0)))
		ensure
			positive_result: Result >= 0
		end

	text_style_for_part (index: INTEGER): INTEGER
			-- Style of the text in the part identified by the
			-- zero-based `index'
		require
			exists: exists
			index_small_enough: index < number_of_parts
			index_large_enough: index >= 0
		do
			Result := cwin_hi_word ({WEL_API}.send_message_result (item,
				Sb_gettextlength, to_wparam (index), to_lparam (0)))
		ensure
			positive_result: Result >= 0
		end

	rect_for_part (index: INTEGER): WEL_RECT
			-- Rectangle for a part identified by the
			-- zero-based `index'.
		require
			exists: exists
			index_small_enough: index < number_of_parts
			index_large_enough: index >= 0
		do
			create Result.make (0, 0, 0, 0)
			{WEL_API}.send_message (item, Sb_getrect, to_wparam (index), Result.item)
		ensure
			result_not_void: Result /= Void
		end

	edges: ARRAY [INTEGER]
			-- Zero-based integer array which contains
			-- all the edges currently present.
		require
			exists: exists
		local
			a: WEL_INTEGER_ARRAY
		do
			create Result.make_filled (0, 0, number_of_parts - 1)
			create a.make (Result)
			{WEL_API}.send_message (item, Sb_getparts, to_wparam (number_of_parts), a.item)
			Result := a.to_array (0)
		ensure
			result_not_void: Result /= Void
			consistent_count: Result.count = number_of_parts
		end

	horizontal_border_width: INTEGER
			-- Width of the horizontal border
		require
			exists: exists
		do
			Result := status_window_borders (0)
		ensure
			positive_result: Result > 0
		end

	vertical_border_width: INTEGER
			-- Width of the vertical border
		require
			exists: exists
		do
			Result := status_window_borders (1)
		ensure
			positive_result: Result > 0
		end

	width_between_rectangles: INTEGER
			-- Width between the rectangles
		require
			exists: exists
		do
			Result := status_window_borders (2)
		ensure
			positive_result: Result > 0
		end

feature -- Basic operations

	reposition
			-- Reposition the window according to the parent.
			-- This function needs to be called in the
			-- `on_size' routine of the parent.
		require
			exists: exists
		do
			{WEL_API}.send_message (item, Wm_size, to_wparam (0), to_lparam (0))
		end

feature -- Element change

	set_simple_mode
			-- Switch to simple mode.
		require
			exists: exists
		do
			{WEL_API}.send_message (item, Sb_simple, to_wparam (1), to_lparam (0))
		end

	set_multiple_mode
			-- Switch to multiple parts mode.
		require
			exists: exists
		do
			{WEL_API}.send_message (item, Sb_simple, to_wparam (0), to_lparam (0))
		end

	set_simple_text (a_text: READABLE_STRING_GENERAL)
			-- Set `a_text' for the simple mode
		require
			exists: exists
			a_text_not_void: a_text /= Void
		local
			a_wel_string: WEL_STRING
		do
			create a_wel_string.make (a_text)
			{WEL_API}.send_message (item, Sb_settext, to_wparam (Simple_part), a_wel_string.item)
		end

	set_simple_text_with_style (a_text: READABLE_STRING_GENERAL; a_style: INTEGER)
			-- Set the text `a_text' with style `a_style' for a part
			-- identified by `Simple_part'.
			-- See class WEL_SBT_CONSTANTS for `a_style' values.
		require
			exists: exists
			a_text_not_void: a_text /= Void
		local
			a_wel_string: WEL_STRING
		do
			create a_wel_string.make (a_text)
			{WEL_API}.send_message (item, Sb_settext,
				to_wparam (Simple_part + a_style), a_wel_string.item)
		end

	set_parts (a_edges: ARRAY [INTEGER])
			-- Set the parts for a multiple parts status window
			-- according to the edged defined in `a_edges'.
			-- If an element is -1, the position of the right edge
			-- for that part extends to the right edge of the
			-- window.
		require
			exists: exists
			a_edges_not_void: a_edges /= Void
			count_large_enough: a_edges.count > 0
			count_small_enough: a_edges.count < 255
		local
			a: WEL_INTEGER_ARRAY
		do
			create a.make (a_edges)
			{WEL_API}.send_message (item, Sb_setparts, to_wparam (a_edges.count), a.item)
		ensure
			edges_set: edges.same_items (a_edges)
		end

	set_text_part (index: INTEGER; a_text: READABLE_STRING_GENERAL)
			-- Set the text for a part identified by the
			-- zero-based `index'.
		require
			exists: exists
			index_small_enough: index < number_of_parts
			index_large_enough: index >= 0
			a_text_not_void: a_text /= Void
		local
			a_wel_string: WEL_STRING
		do
			create a_wel_string.make (a_text)
			{WEL_API}.send_message (item, Sb_settext, to_wparam (index), a_wel_string.item)
		ensure
			text_set: a_text.same_string (text_for_part (index))
		end

	set_text_part_with_style (index: INTEGER; a_text: READABLE_STRING_GENERAL;
			a_style: INTEGER)
			-- Set the text for a part identified by the
			-- zero-based `index'.
			-- See class WEL_SBT_CONSTANTS for `a_style' values.
		require
			exists: exists
			index_small_enough: index < number_of_parts
			index_large_enough: index >= 0
			a_text_not_void: a_text /= Void
		local
			a_wel_string: WEL_STRING
		do
			create a_wel_string.make (a_text)
			{WEL_API}.send_message (item, Sb_settext, to_wparam (index + a_style), a_wel_string.item)
		ensure
			text_set: a_text.same_string (text_for_part (index))
			style_is_set: a_style = text_style_for_part (index)
		end

	set_part_owner_drawn (index, value, a_style: INTEGER)
			-- Set a part identified by the zero-based `index' to
			-- be owner drawn using `a_style' as extended style.
			-- `value' will be present in the `on_draw_item'
			-- routine of the `parent' as `item_data' in class
			-- WEL_DRAW_ITEM_STRUCT.
			-- See class WEL_SBT_CONSTANTS for `a_style' values.
		require
			exists: exists
			index_small_enough: index < number_of_parts
			index_large_enough: index >= 0
		do
			{WEL_API}.send_message (item, Sb_settext,
				to_wparam (index + Sbt_ownerdraw + a_style), to_lparam (value))
		ensure
			style_is_set: text_style_for_part (index) =
				Sbt_ownerdraw + a_style
		end

	set_minimum_height (a_height: INTEGER)
			-- Set the minimun height with `a_height' in pixels.
			-- To let the change take effect, call
			-- the `reposition' procedure.
		require
			exists: exists
			minimum_height: a_height >= 2 * vertical_border_width
		do
			{WEL_API}.send_message (item, Sb_setminheight, to_wparam (a_height), to_lparam (0))
		end

feature {NONE} -- Implementation

	Simple_part: INTEGER = 255
			-- Identifies the simple part

	status_window_borders (index: INTEGER): INTEGER
			-- Information about status window borders
		require
			exists: exists
			index_small_enough: index <= 2
			index_large_enough: index >= 0
		local
			a: WEL_INTEGER_ARRAY
			borders: ARRAY [INTEGER]
		do
			create borders.make_filled (0, 0, 2)
			create a.make (borders)
			{WEL_API}.send_message (item, Sb_getborders, to_wparam (0), a.item)
			Result := a.to_array (0).item (index)
		ensure
			positive_result: Result > 0
		end

	class_name: STRING_32
			-- Window class name to create
		once
			Result := (create {WEL_STRING}.share_from_pointer (cwin_status_window_class)).string
		end

	default_style: INTEGER
			-- Default style used to create the control
		once
			Result := Ws_visible + Ws_child + Sbars_sizegrip
		end

feature {NONE} -- Inapplicable

	set_text (a_text: detachable READABLE_STRING_GENERAL)
			-- Set the window text.
		do
		end

	text: STRING_32
			-- Window text
		do
			create Result.make_empty
		end

	text_substring (nb: INTEGER): WEL_STRING
			-- <Precursor>
		do
			create Result.make_empty (0)
		end

	text_length: INTEGER
			-- Length of text
		do
		end

feature {NONE} -- Externals

	cwin_status_window_class: POINTER
		external
			"C [macro <cctrl.h>] : EIF_POINTER"
		alias
			"STATUSCLASSNAME"
		end

	Sbars_sizegrip: INTEGER
			-- Style to draw the size grip.
		external
			"C [macro <cctrl.h>]"
		alias
			"SBARS_SIZEGRIP"
		end

note
	copyright:	"Copyright (c) 1984-2015, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class WEL_STATUS_WINDOW

