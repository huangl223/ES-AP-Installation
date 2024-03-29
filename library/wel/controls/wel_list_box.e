note
	description: "Contains a list of strings from which the user can %
		%select. Common ancestor of WEL_SINGLE_SELECTION_LIST_BOX and %
		%WEL_MULTIPLE_SELECTION_LIST_BOX."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2015-08-19 00:59:46 +0000 (Wed, 19 Aug 2015) $"
	revision: "$Revision: 97833 $"

deferred class
	WEL_LIST_BOX

inherit
	WEL_CONTROL
		redefine
			process_notification
		end

	WEL_LBN_CONSTANTS
		export
			{NONE} all
		end

	WEL_LB_CONSTANTS
		export
			{NONE} all
		end

	WEL_COLOR_CONTROL

feature {NONE} -- Initialization

	make (a_parent: WEL_WINDOW; a_x, a_y, a_width, a_height, an_id: INTEGER)
			-- Make a list box
		require
			a_parent_not_void: a_parent /= Void
			a_parent_exists: a_parent.exists
		do
			internal_window_make (a_parent, Void,
				default_style, a_x, a_y, a_width, a_height,
				an_id, default_pointer)
			id := an_id
		ensure
			parent_set: parent = a_parent
			exists: exists
			id_set: id = an_id
		end

feature -- Access

	strings: ARRAY [STRING_32]
			-- Strings contained in the list box
		require
			exists: exists
		local
			i: INTEGER
		do
			create Result.make_filled ({STRING_32} "", 0, count - 1)
			from
				i := Result.lower
			until
				i = Result.count
			loop
				Result.put (i_th_text (i), i)
				i := i + 1
			end
		ensure
			result_not_void: Result /= Void
			count_ok: Result.count = count
		end

	i_th_text (i: INTEGER): STRING_32
			-- Text at the zero-based index `i'
		require
			exists: exists
			i_large_enough: i >= 0
			i_small_enough: i < count
		local
			a_wel_string: WEL_STRING
		do
			create Result.make (i_th_text_length (i))
			Result.fill_blank
			create a_wel_string.make (Result)
			{WEL_API}.send_message (item, Lb_gettext, to_wparam (i), a_wel_string.item)
			Result := a_wel_string.string
		ensure
			result_exists: Result /= Void
			same_result_as_strings: Result.same_string (strings.item (i))
		end

	i_th_text_length (i: INTEGER): INTEGER
			-- Length text at the zero-based index `i'
		require
			exists: exists
			i_large_enough: i >= 0
			i_small_enough: i < count
		do
			Result := {WEL_API}.send_message_result_integer (item, Lb_gettextlen,
				to_wparam (i), to_lparam (0))
		ensure
			positive_result: Result >= 0
			same_result_as_strings: Result = strings.item (i).count
		end

	foreground_color: WEL_COLOR_REF
			-- foreground color used for the text of the
			-- control
			-- Can be redefined by the user
		do
			create Result.make_system (Color_windowtext)
		end

	background_color: WEL_COLOR_REF
			-- Background color used for the background of the
			-- control
			-- Can be redefined by the user
		do
			create Result.make_system (Color_window)
		end

feature -- Element change

	add_string (a_string: READABLE_STRING_GENERAL)
			-- Add `a_string' in the list box.
			-- If the list box does not have the
			-- `Lbs_sort' style, `a_string' is added
			-- to the end of the list otherwise it is
			-- inserted into the list and the list is
			-- sorted.
		require
			exists: exists
			a_string_not_void: a_string /= Void
		local
			a_wel_string: WEL_STRING
		do
			create a_wel_string.make (a_string)
			{WEL_API}.send_message (item, Lb_addstring, to_wparam (0), a_wel_string.item)
		ensure
			count_increased: count = old count + 1
		end

	insert_string_at (a_string: READABLE_STRING_GENERAL; index: INTEGER)
			-- Add `a_string' at the zero-based `index'
		require
			exists: exists
			a_string_not_void: a_string /= Void
			index_large_enough: index >= 0
			index_small_enough: index <= count
		local
			a_wel_string: WEL_STRING
		do
			create a_wel_string.make (a_string)
			{WEL_API}.send_message (item, Lb_insertstring, to_wparam (index), a_wel_string.item)
		ensure
			count_increased: count = old count + 1
		end

	delete_string (index: INTEGER)
			-- Delete the item at the zero-based `index'
		require
			exists: exists
			index_large_enough: index >= 0
			index_small_enough: index < count
		do
			{WEL_API}.send_message (item, Lb_deletestring, to_wparam (index), to_lparam (0))
		ensure
			count_decreased: count = old count - 1
		end

	add_files (attribut: INTEGER; files: READABLE_STRING_GENERAL)
			-- Add `files' to the list box. `files' may contain
			-- wildcards (?*). See class WEL_DDL_CONSTANTS for
			-- `attribut' values.
		require
			exists: exists
			files_not_void: files /= Void
		local
			a_wel_string: WEL_STRING
		do
			create a_wel_string.make (files)
			{WEL_API}.send_message (item, Lb_dir, to_wparam (attribut), a_wel_string.item)
		end

	reset_content
			-- Reset the content of the list.
		require
			exists: exists
		do
			{WEL_API}.send_message (item, Lb_resetcontent, to_wparam (0), to_lparam (0))
		ensure
			empty: count = 0
		end

feature -- Status setting

	set_top_index (index: INTEGER)
			-- Ensure that the zero-based `index'
			-- in the list box is visible.
		require
			exists: exists
			index_large_enough: index >= 0
			index_small_enough: index < count
		do
			{WEL_API}.send_message (item, Lb_settopindex, to_wparam (index), to_lparam (0))
		ensure
			index_visible: top_index <= index
		end

	select_item (index: INTEGER)
			-- Select item at the zero-based `index'.
		require
			exists: exists
			index_small_enough: index < count
			index_large_enough: index >= 0
		deferred
		ensure
			is_selected: is_selected (index)
		end

	set_horizontal_extent (a_width: INTEGER)
			-- Set the width, in pixels, by which a list box can
			-- be scrolled horizontally.
		require
			exists: exists
			positive_width: width >= 0
		do
			{WEL_API}.send_message (item, Lb_sethorizontalextent, to_wparam (a_width), to_lparam (0))
		ensure
			horizontal_extent_set: horizontal_extent = a_width
		end

feature -- Status report

	selected: BOOLEAN
			-- Is an item selected?
		require
			exists: exists
		deferred
		end

	top_index: INTEGER
			-- Index of the first visible item
		require
			exists: exists
		do
			Result := {WEL_API}.send_message_result_integer (item, Lb_gettopindex,
				to_wparam (0), to_lparam (0))
		ensure
			result_large_enough: Result >= 0
			result_small_enough: Result <= count
		end

	is_selected (index: INTEGER): BOOLEAN
			-- Is item at position `index' selected?
		require
			exists: exists
			index_large_enough: index >= 0
			index_small_enough: index < count
		do
			Result := {WEL_API}.send_message_result_integer (item, Lb_getsel,
				to_wparam (index), to_lparam (0)) > 0
		end

	item_height: INTEGER
			-- Height of an item
		require
			exists: exists
		local
			dc: WEL_CLIENT_DC
			tm: WEL_TEXT_METRIC
		do
			create dc.make (Current)
			dc.get
			create tm.make (dc)
			dc.release
			Result := tm.height
		ensure
			positive_result: Result >= 0
		end

	horizontal_extent: INTEGER
			-- Width, in pixels, by which the list box can be
			-- scrolled horizontally
		require
			exists: exists
			has_horizontal_scroll_bar: has_horizontal_scroll_bar
		do
			Result := {WEL_API}.send_message_result_integer (item,
				Lb_gethorizontalextent, to_wparam (0), to_lparam (0))
		ensure
			positive_result: Result >= 0
		end

feature -- Basic operations

	find_string (index: INTEGER; a_string: READABLE_STRING_GENERAL): INTEGER
			-- Find the first string that contains the
			-- prefix `a_string'. `index' specifies the
			-- zero-based index of the item before the first
			-- item to be searched.
			-- if `index' = -1 then the search begins on the first item.
			-- Returns -1 if the search was unsuccessful.
		require
			exists: exists
			index_large_enough: index >= -1
			index_small_enough: index < count
			a_string_not_void: a_string /= Void
		local
			a_wel_string: WEL_STRING
		do
			create a_wel_string.make (a_string)
			Result := {WEL_API}.send_message_result_integer (item,
				Lb_findstring, to_wparam (index), a_wel_string.item)
		end

	find_string_exact (index: INTEGER; a_string: READABLE_STRING_GENERAL): INTEGER
			-- Find the first string that matches `a_string'.
			-- `index' specifies the zero-based index of the
			-- item before the first item to be searched.
			-- if `index' = -1 then the search begins on the first item.
			-- Returns -1 if the search was unsuccessful.
		require
			exists: exists
			index_large_enough: index >= -1
			index_small_enough: index < count
			a_string_not_void: a_string /= Void
		local
			a_wel_string: WEL_STRING
		do
			create a_wel_string.make (a_string)
			Result := {WEL_API}.send_message_result_integer (item,
				Lb_findstringexact, to_wparam (index), a_wel_string.item)
		end

feature -- Measurement

	count: INTEGER
			-- Number of lines
		require
			exists: exists
		do
			Result := {WEL_API}.send_message_result_integer (item,
				Lb_getcount, to_wparam (0), to_lparam (0))
		ensure
			positive_result: Result >= 0
		end

feature -- Notifications

	on_lbn_selchange
			-- The selection is about to change
		require
			exists: exists
		do
		end

	on_lbn_errspace
			-- Cannot allocate enough memory
			-- to meet a specific request
		require
			exists: exists
		do
		end

	on_lbn_dblclk
			-- Double click on a string
		require
			exists: exists
		do
		end

	on_lbn_selcancel
			-- Cancel the selection
		require
			exists: exists
		do
		end

	on_lbn_setfocus
			-- Receive the keyboard focus
		require
			exists: exists
		do
		end

	on_lbn_killfocus
			-- Lose the keyboard focus
		require
			exists: exists
		do
		end

feature {NONE} -- Implementation

	process_notification (notification_code: INTEGER)
		do
			if notification_code = Lbn_selchange then
				on_lbn_selchange
			elseif notification_code = Lbn_dblclk then
				on_lbn_dblclk
			elseif notification_code = Lbn_errspace then
				on_lbn_errspace
			elseif notification_code = Lbn_selcancel then
				on_lbn_selcancel
			elseif notification_code = Lbn_killfocus then
				on_lbn_killfocus
			elseif notification_code = Lbn_setfocus then
				on_lbn_setfocus
			else
				default_process_notification (notification_code)
			end
		end

	class_name: STRING_32
			-- Window class name to create
		once
			Result := {STRING_32} "LISTBOX"
		end

invariant
	consistent_count: exists and then selected implies count > 0

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




end -- class WEL_LIST_BOX

