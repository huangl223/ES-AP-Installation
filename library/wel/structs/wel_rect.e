note
	description: "Defines the coordinates of the upper-left and %
		%lower-right corners of a rectangle."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2009-03-23 20:11:05 +0000 (Mon, 23 Mar 2009) $"
	revision: "$Revision: 77858 $"

class
	WEL_RECT

inherit
	WEL_STRUCTURE
		rename
			make as structure_make
		export
			{ANY} is_equal, copy, clone
		redefine
			is_equal
		end

create
	make,
	make_by_pointer,
	make_client,
	make_window,
	make_client_from_pointer,
	make_window_from_pointer

feature {NONE} -- Initialization

	make (a_left, a_top, a_right, a_bottom: INTEGER)
			-- Make a rectangle and set `left', `top',
			-- `right', `bottom' with `a_left', `a_top',
			-- `a_right', `a_bottom'
		do
			structure_make
			set_rect (a_left, a_top, a_right, a_bottom)
		ensure
			left_set: left = a_left
			top_set: top = a_top
			right_set: right = a_right
			bottom_set: bottom = a_bottom
		end

	make_client (window: WEL_WINDOW)
			-- Make a client rectangle with `window'
		require
			window_not_void: window /= Void
			window_exists: window.exists
		do
			structure_make
			cwin_get_client_rect (window.item, item)
		ensure
			left_equal_zero: left = 0
			top_equal_zero: top = 0
			client_rect_set: is_equal (window.client_rect)
		end

	make_window (window: WEL_WINDOW)
			-- Make a window rectangle with `window'
			-- (absolute position)
		require
			window_not_void: window /= Void
			window_exists: window.exists
		do
			structure_make
			cwin_get_window_rect (window.item, item)
		ensure
			window_rect_set: is_equal (window.window_rect)
		end

	make_client_from_pointer (a_hwnd: POINTER)
			-- Make a client rectangle with `a_hwnd'
		require
			hwnd_valid: a_hwnd /= default_pointer
		do
			structure_make
			cwin_get_client_rect (a_hwnd, item)
		ensure
			left_equal_zero: left = 0
			top_equal_zero: top = 0
		end

	make_window_from_pointer (a_hwnd: POINTER)
			-- Make a window rectangle with `window'
			-- (absolute position)
		require
			hwnd_valid: a_hwnd /= default_pointer
		do
			structure_make
			cwin_get_window_rect (a_hwnd, item)
		end

feature -- Access

	left, x: INTEGER
			-- Position of the left border
		require
			exists: exists
		do
			Result := cwel_rect_get_left (item)
		end

	top, y: INTEGER
			-- Position of the top border
		require
			exists: exists
		do
			Result := cwel_rect_get_top (item)
		end

	right: INTEGER
			-- Position of the right border
		require
			exists: exists
		do
			Result := cwel_rect_get_right (item)
		end

	bottom: INTEGER
			-- Position of the bottom border
		require
			exists: exists
		do
			Result := cwel_rect_get_bottom (item)
		end

	width: INTEGER
			-- Width of current rect
		require
			exists: exists
		do
			Result := (right - left).abs
		end

	height: INTEGER
			-- Height of current rect
		require
			exists: exists
		do
			Result := (bottom - top).abs
		end

feature -- Element change

	set_rect (a_left, a_top, a_right, a_bottom: INTEGER)
			-- Quick set of `left', `top', `right', `bottom'
			-- with `a_left', `a_top', `a_right', `a_bottom'
			-- respectively.
		require
			exists: exists
		do
			cwin_set_rect (item, a_left, a_top, a_right, a_bottom)
		ensure
			left_set: left = a_left
			top_set: top = a_top
			right_set: right = a_right
			bottom_set: bottom = a_bottom
		end

	set_left (a_left: INTEGER)
			-- Set `left' with `a_left'
		require
			exists: exists
		do
			cwel_rect_set_left (item, a_left)
		ensure
			left_set: left = a_left
		end

	set_top (a_top: INTEGER)
			-- Set `top' with `a_top'
		require
			exists: exists
		do
			cwel_rect_set_top (item, a_top)
		ensure
			top_set: top = a_top
		end

	set_right (a_right: INTEGER)
			-- Set `right' with `a_right'
		require
			exists: exists
		do
			cwel_rect_set_right (item, a_right)
		ensure
			right_set: right = a_right
		end

	set_bottom (a_bottom: INTEGER)
			-- Set `bottom' with `a_bottom'
		require
			exists: exists
		do
			cwel_rect_set_bottom (item, a_bottom)
		ensure
			bottom_set: bottom = a_bottom
		end

feature -- Basic operations

	offset (a_x, a_y: INTEGER)
			-- Moves the rectangle by the specified
			-- offsets `a_x' and `a_y'.
		require
			exists: exists
		do
			cwin_offset_rect (item, a_x, a_y)
		ensure
			x_set: x = old x + a_x
			y_set: y = old y + a_y
			right_set: right = old right + a_x
			bottom_set: bottom = old bottom + a_y
		end

	inflate (a_x, a_y: INTEGER)
			-- Inflate the rectangle by `a_x' and `a_y'.
			-- Positive values increase the width and height,
			-- and negative values decrease them.
		require
			exists: exists
		do
			cwin_inflate_rect (item, a_x, a_y)
		ensure
			left_set: left = old left - a_x
			top_set: top = old top - a_x
			right_set: right = old right + a_y
			bottom_set: bottom = old bottom + a_y
		end

	union (rect1, rect2: WEL_RECT)
			-- Set the current rectangle by the smallest
			-- rectangle that contains both source
			-- rectangles `rect1' and `rect2'.
		require
			exists: exists
			rect1_not_void: rect1 /= Void
			rect1_exists: rect1.exists
			rect2_not_void: rect2 /= Void
			rect2_exists: rect2.exists
		do
			cwin_union_rect (item, rect1.item, rect2.item)
		end

	subtract (rect1, rect2: WEL_RECT)
			-- Set the current rectangle by subtracting
			-- `rect2' from `rect1'.
		require
			exists: exists
			rect1_not_void: rect1 /= Void
			rect1_exists: rect1.exists
			rect2_not_void: rect2 /= Void
			rect2_exists: rect2.exists
		do
			cwin_subtract_rect (item, rect1.item, rect2.item)
		end

	intersect (rect1, rect2: WEL_RECT)
			-- Calculates the intersection of `rect1'
			-- and `rect2'. If `rect1' and `rect2' do not
			-- intersect then `empty' becomes True.
		require
			exists: exists
			rect1_not_void: rect1 /= Void
			rect1_exists: rect1.exists
			rect2_not_void: rect2 /= Void
			rect2_exists: rect2.exists
		do
			cwin_intersect_rect (item, rect1.item, rect2.item)
		end

feature -- Status report

	empty: BOOLEAN
			-- Is it empty?
			-- A rectangle is empty if the coordinate of the right
			-- side is less than or equal to the coordinate
			-- of the left side, or the coordinate of the bottom
			-- side is less than or equal to the coordinate of
			-- the top side.
		require
			exists: exists
		do
			Result := cwin_is_rect_empty (item)
		end

	point_in (point: WEL_POINT): BOOLEAN
			-- Is `point' in the rectangle?
		require
			exists: exists
			point_not_void: point /= Void
			point_exists: point.exists
		do
			Result := cwin_pt_in_rect (item, point.item)
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN
			-- Is `Current' equal to `other'?
		do
			Result := cwin_equal_rect (item, other.item)
		end

feature -- Measurement

	structure_size: INTEGER
			-- Size to allocate (in bytes)
		once
			Result := c_size_of_rect
		end

feature {NONE} -- Externals

	c_size_of_rect: INTEGER
		external
			"C [macro <rect.h>]"
		alias
			"sizeof (RECT)"
		end

	cwel_rect_set_left (ptr: POINTER; value: INTEGER)
		external
			"C [struct <rect.h>] (RECT, LONG)"
		alias
			"left"
		end

	cwel_rect_set_top (ptr: POINTER; value: INTEGER)
		external
			"C [struct <rect.h>] (RECT, LONG)"
		alias
			"top"
		end

	cwel_rect_set_right (ptr: POINTER; value: INTEGER)
		external
			"C [struct <rect.h>] (RECT, LONG)"
		alias
			"right"
		end

	cwel_rect_set_bottom (ptr: POINTER; value: INTEGER)
		external
			"C [struct <rect.h>] (RECT, LONG)"
		alias
			"bottom"
		end

	cwel_rect_get_left (ptr: POINTER): INTEGER
		external
			"C [struct <rect.h>] (RECT): EIF_INTEGER"
		alias
			"left"
		end

	cwel_rect_get_top (ptr: POINTER): INTEGER
		external
			"C [struct <rect.h>] (RECT): EIF_INTEGER"
		alias
			"top"
		end

	cwel_rect_get_right (ptr: POINTER): INTEGER
		external
			"C [struct <rect.h>] (RECT): EIF_INTEGER"
		alias
			"right"
		end

	cwel_rect_get_bottom (ptr: POINTER): INTEGER
		external
			"C [struct <rect.h>] (RECT): EIF_INTEGER"
		alias
			"bottom"
		end

	cwin_set_rect (ptr: POINTER; a_left, a_top, a_right,
			a_bottom: INTEGER)
			-- SDK SetRect
		external
			"C [macro <wel.h>] (RECT *, int, int, int, int)"
		alias
			"SetRect"
		end

	cwin_get_window_rect (hwnd, ptr: POINTER)
			-- SDK GetWindowRect
		external
			"C [macro <wel.h>] (HWND, RECT *)"
		alias
			"GetWindowRect"
		end

	cwin_get_client_rect (hwnd, ptr: POINTER)
			-- SDK GetClientRect
		external
			"C [macro <wel.h>] (HWND, RECT *)"
		alias
			"GetClientRect"
		end

	cwin_is_rect_empty (ptr: POINTER): BOOLEAN
			-- SDK IsRectEmpty
		external
			"C [macro <wel.h>] (RECT *): EIF_BOOLEAN"
		alias
			"IsRectEmpty"
		end

	cwin_pt_in_rect (ptr, point: POINTER): BOOLEAN
			-- SDK PtInRect
			--| Special case since the second parameter is a POINT
			--| and not a POINT *. So a macro is used.
		external
			"C [macro <rect.h>]"
		end

	cwin_offset_rect (ptr: POINTER; a_x, a_y: INTEGER)
			-- SDK OffsetRect
		external
			"C [macro <wel.h>] (RECT *, int, int)"
		alias
			"OffsetRect"
		end

	cwin_inflate_rect (ptr: POINTER; a_x, a_y: INTEGER)
			-- SDK InflateRect
		external
			"C [macro <wel.h>] (RECT *, int, int)"
		alias
			"InflateRect"
		end

	cwin_union_rect (ptr, rect1, rect2: POINTER)
			-- SDK UnionRect
		external
			"C [macro <wel.h>] (RECT *, RECT *, RECT *)"
		alias
			"UnionRect"
		end

	cwin_subtract_rect (ptr, rect1, rect2: POINTER)
			-- SDK SubtractRect
		external
			"C [macro <wel.h>] (RECT *, RECT *, RECT *)"
		alias
			"SubtractRect"
		end

	cwin_intersect_rect (ptr, rect1, rect2: POINTER)
			-- SDK IntersectRect
		external
			"C [macro <wel.h>] (RECT *, RECT *, RECT *)"
		alias
			"IntersectRect"
		end

	cwin_equal_rect (rect1, rect2: POINTER): BOOLEAN
			-- SDK EqualRect
		external
			"C [macro <wel.h>] (RECT *, RECT *): EIF_BOOLEAN"
		alias
			"EqualRect"
		end

invariant
	positive_width: exists implies width >= 0
	positive_height: exists implies height >= 0

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

end
