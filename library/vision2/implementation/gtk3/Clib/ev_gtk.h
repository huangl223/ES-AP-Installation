/*
indexing
	description: "Include file for gtk and Eiffel runtime features"
	date: "$Date: 2021-07-07 23:52:37 +0000 (Wed, 07 Jul 2021) $"
	revision: "$Revision: 105606 $"
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
*/

#ifndef _EV_GTK_H_INCLUDED_
#define _EV_GTK_H_INCLUDED_

#include <gtk/gtk.h>
#ifdef GDK_WINDOWING_X11
#include <gdk/gdkx.h>
#include <X11/Xlib.h>
#endif

#include <eif_eiffel.h>

#endif
