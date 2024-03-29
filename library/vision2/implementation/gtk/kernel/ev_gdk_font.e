note
	description: "Eiffel Vision GDK font. (for GTK implementation.) %N%
		%Objects that have a reference to a GdkFont, and the fully %N%
		%matched string that it is loaded from."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2013-05-20 23:15:17 +0000 (Mon, 20 May 2013) $"
	revision: "$Revision: 92557 $"

class
	EV_GDK_FONT

create
	make

feature {NONE} -- Initialization

	make (a_full_name: READABLE_STRING_GENERAL)
			-- Initialize.
		require
			a_full_name_not_void: a_full_name /= Void
		do
			full_name := a_full_name.as_string_32
			load
		end

feature {NONE} -- Implementation

	load
			-- Load font specified in `full_name'.
		local
			a_cs: EV_GTK_C_STRING
		do
			a_cs := full_name
			c_object := {GTK}.gdk_font_load (a_cs.item)
		end

	destroy
			-- Unreference font.
		do
			{GTK}.gdk_font_unref (c_object)
		end

feature -- Access

	full_name: STRING_32

	c_object: POINTER;

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




end -- class EV_GDK_FONT

