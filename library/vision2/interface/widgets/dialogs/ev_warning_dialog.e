note
	description:
		"EiffelVision warning dialog."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2008-12-29 20:27:11 +0000 (Mon, 29 Dec 2008) $"
	revision: "$Revision: 76420 $"

class
	EV_WARNING_DIALOG

inherit
	EV_MESSAGE_DIALOG
		redefine
			initialize
		end

create
	default_create,
	make_with_text,
	make_with_text_and_actions

feature {NONE} -- Initialization

	initialize
		do
			Precursor {EV_MESSAGE_DIALOG}
			set_title (ev_warning_dialog_title)
			set_pixmap (Default_pixmaps.Warning_pixmap)
			set_icon_pixmap (Default_pixmaps.Warning_pixmap)
			set_buttons (<<ev_ok>>)
			set_default_push_button (button (ev_ok))
			set_default_cancel_button (button (ev_ok))
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




end -- class EV_WARNING_DIALOG

