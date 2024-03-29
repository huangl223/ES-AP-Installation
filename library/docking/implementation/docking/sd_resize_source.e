note
	description: "SD_ZONE  want to be resized by user should inherit this."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2008-12-29 20:27:11 +0000 (Mon, 29 Dec 2008) $"
	revision: "$Revision: 76420 $"

deferred class
	SD_RESIZE_SOURCE

feature -- Resize stuffs.

	start_resize_operation (a_bar: SD_RESIZE_BAR; a_screen_boundary: EV_RECTANGLE)
			-- Things to do when start resize operation.
		require
			a_bar_not_void: a_bar /= Void
			a_screen_boundary_not_void: a_screen_boundary /= Void
		deferred
		end

	end_resize_operation (a_bar: SD_RESIZE_BAR; a_delta: INTEGER)
			-- Things to do when end resize operation. Normally should resize the widget size.
		require
			a_bar_not_void: a_bar /= Void
		deferred
		end
note
	library:	"SmartDocking: Library of reusable components for Eiffel."
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
