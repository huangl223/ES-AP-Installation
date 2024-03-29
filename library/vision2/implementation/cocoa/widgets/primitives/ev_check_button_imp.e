note
	description: "EiffelVision check button, Cocoa implementation."
	author:	"Daniel Furrer"
	id: "$Id: ev_check_button_imp.e 92557 2013-05-20 23:15:17Z manus $";
	date: "$Date: 2013-05-20 23:15:17 +0000 (Mon, 20 May 2013) $";
	revision: "$Revision: 92557 $"

class
	EV_CHECK_BUTTON_IMP

inherit
	EV_CHECK_BUTTON_I
		redefine
			interface
		end

	EV_TOGGLE_BUTTON_IMP
		undefine
			default_alignment
		redefine
			make,
			interface,
			accommodate_text
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize 'Current'
		do
			Precursor {EV_TOGGLE_BUTTON_IMP}
			set_bezel_style ({NS_BUTTON}.rounded_bezel_style)
			set_button_type ({NS_BUTTON}.switch_button)

			align_text_left
		end

	accommodate_text (a_text: READABLE_STRING_GENERAL)
			-- Change internal minimum size to make `a_text' fit.
		local
			t: TUPLE [width: INTEGER; height: INTEGER]
			a_width, a_height: INTEGER
		do
			t := font.string_size (a_text)
			a_width := t.width
			a_height := t.height
			internal_set_minimum_size (a_width.abs + 25, a_height.abs + 5)
		end

feature {EV_ANY, EV_ANY_I}

	interface: detachable EV_CHECK_BUTTON note option: stable attribute end;

end -- class EV_CHECK_BUTTON_IMP
