note
	description: "Eiffel Vision horizontal scroll bar. GTK+ implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2011-11-23 01:53:16 +0000 (Wed, 23 Nov 2011) $"
	revision: "$Revision: 87964 $"

class
	EV_HORIZONTAL_SCROLL_BAR_IMP

inherit
	EV_HORIZONTAL_SCROLL_BAR_I
		redefine
			interface
		end

	EV_SCROLL_BAR_IMP
		redefine
			interface,
			make
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Create and initialize `Current'
		do
			adjustment_internal := {GTK}.gtk_adjustment_new (0, 0, 100 + 10, 1, 10, 10)
			set_c_object ({GTK}.gtk_hscrollbar_new (adjustment))
			Precursor
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_HORIZONTAL_SCROLL_BAR note option: stable attribute end;

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

end -- class EV_HORIZONTAL_SCROLL_BAR_IMP
