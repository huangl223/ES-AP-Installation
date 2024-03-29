note
	description: "Device context used during a Wm_paint message."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2009-01-25 02:01:47 +0000 (Sun, 25 Jan 2009) $"
	revision: "$Revision: 76831 $"

class
	WEL_PAINT_DC

inherit
	WEL_DISPLAY_DC
		rename
			make_by_pointer as simple_make_by_pointer
		redefine
			destroy_item
		end

create
	make,
	make_by_pointer

feature {NONE} -- Initialization

	make (a_window: WEL_WINDOW)
			-- Makes a DC associated with `a_window'
		require
			a_window_not_void: a_window /= Void
			a_window_exists: a_window.exists
		do
			window := a_window
			hwindow := a_window.item
			create paint_struct.make
		ensure
			window_set: window = a_window
		end

	make_by_pointer (a_window: WEL_WINDOW; a_pointer: POINTER)
			-- Makes a DC associated with `a_pointer' and `a_window'
		require
			a_window_not_void: a_window /= Void
			a_window_exists: a_window.exists
		do
			window := a_window
			hwindow := a_window.item
			simple_make_by_pointer (a_pointer)
			create paint_struct.make
		ensure
			window_set: window = a_window
		end

feature -- Access

	window: WEL_WINDOW
			-- Window associated to the paint dc

	paint_struct: WEL_PAINT_STRUCT
			-- Information about the Wm_paint message

feature -- Basic operations

	get
			-- Get the device context
		do
			item := cwin_begin_paint (hwindow, paint_struct.item)
		end

	release, quick_release
			-- Release the device context
		local
			a_default_pointer: POINTER
		do
			cwin_end_paint (hwindow, paint_struct.item)
			item := a_default_pointer
		end

feature {NONE} -- Implementation

	hwindow: POINTER
			-- Window handle associated with the device context

feature {NONE} -- Removal

	destroy_item
			-- Delete the current device context.
		local
			a_default_pointer: POINTER
		do
				-- Protect the call to DeleteDC, because `destroy_item' can
				-- be called by the GC so without assertions.
			if item /= a_default_pointer then
				unselect_all
				cwin_end_paint (hwindow, paint_struct.item)
				item := a_default_pointer
			end
		end

feature {NONE} -- Externals

	cwin_begin_paint (hwnd, a_paint_struct: POINTER): POINTER
			-- SDK BeginPaint
		external
			"C [macro <wel.h>] (HWND, PAINTSTRUCT *): EIF_POINTER"
		alias
			"BeginPaint"
		end

	cwin_end_paint (hwnd, a_paint_struct: POINTER)
			-- SDK EndPaint
		external
			"C [macro <wel.h>] (HWND, PAINTSTRUCT *)"
		alias
			"EndPaint"
		end

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




end -- class WEL_PAINT_DC

