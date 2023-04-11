note
	description: "EiffelVision popup window, Cocoa implementation"
	author: "Daniel Furrer"
	date: "$Date: 2013-05-20 23:15:17 +0000 (Mon, 20 May 2013) $"
	revision: "$Revision: 92557 $"

class
	EV_POPUP_WINDOW_IMP

inherit
	EV_POPUP_WINDOW_I
		undefine
			propagate_background_color,
			propagate_foreground_color,
			lock_update,
			unlock_update
		redefine
			interface
		end

	EV_WINDOW_IMP
		rename
			has_shadow as has_shadow_cocoa
		redefine
			interface,
			make
		end

create
	make,
	initialize_with_shadow

feature -- Implementation

	make
		do
			Precursor {EV_WINDOW_IMP}
			disable_border
			disable_user_resize
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_POPUP_WINDOW note option: stable attribute end;
			-- Provides a common user interface to possibly dependent
			-- functionality implemented by `Current'.

end -- class EV_POPUP_WINDOW_IMP
