note
	description: "Gtk implementation of SD_WINDOW."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2013-05-20 23:15:17 +0000 (Mon, 20 May 2013) $"
	revision: "$Revision: 92557 $"

class
	SD_WINDOW_IMP

inherit
	EV_WINDOW_IMP
		redefine
			make
		end

create
	make

feature {NONE} -- Initlization

	make
			-- Redefine
		do
			Precursor;
			-- Don't show window tab in system task bar.
			{GTK}.gtk_window_set_skip_taskbar_hint (c_object, True)
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
