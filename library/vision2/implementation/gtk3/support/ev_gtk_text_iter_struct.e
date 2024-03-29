note
	description: 
		"GtkTextIter Struct helper class"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	id: "$Id: ev_gtk_text_iter_struct.e 86788 2011-06-24 18:34:20Z king $"
	date: "$Date: 2011-06-24 18:34:20 +0000 (Fri, 24 Jun 2011) $"
	revision: "$Revision: 86788 $"

class
	EV_GTK_TEXT_ITER_STRUCT

inherit
	MEMORY_STRUCTURE
	
create
	make

feature -- Externals

	frozen structure_size: INTEGER
		external
			"C [macro <ev_gtk.h>]"
		alias
			"sizeof(GtkTextIter)"
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




end -- EV_GTK_TEXT_ITER_STRUCT

