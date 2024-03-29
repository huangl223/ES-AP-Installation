note
	description: "GTK implementation for SD_DEPENDENCY_CHECKER."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2013-05-20 23:15:17 +0000 (Mon, 20 May 2013) $"
	revision: "$Revision: 92557 $"

class
	SD_DEPENDENCY_CHECKER_IMP

inherit
	SD_DEPENDENCY_CHECKER

	EV_ANY_HANDLER

	EV_SHARED_APPLICATION

feature -- Command

	check_dependency (a_parent_window: EV_WINDOW)
			-- Redefine
		do
		end

	is_solaris_cde: BOOLEAN
			-- Redefine
		do
			if attached {EV_APPLICATION_IMP} ev_application.implementation as l_imp then
				-- For Solaris CDE, window manager name is `unknown',  it should be `Dtwin' although.
				-- For Solaris JDS (Gnome), window manager name is `Metacity'
				-- For Ubuntu Gnome, window manager name is `Metacity'
				-- For Ubuntu KDE, window manager name is `KWin'
				Result := l_imp.window_manager_name.is_equal ("unknown")
			end
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
