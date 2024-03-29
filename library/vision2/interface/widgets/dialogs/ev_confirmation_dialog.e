note
	description: "EiffelVision confirmation dialog."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2013-05-20 23:15:17 +0000 (Mon, 20 May 2013) $"
	revision: "$Revision: 92557 $"

class
	EV_CONFIRMATION_DIALOG

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
			-- Initialize `Current'.
		do
			Precursor {EV_MESSAGE_DIALOG}
			set_pixmap (Default_pixmaps.Question_pixmap)
			set_icon_pixmap (Default_pixmaps.Question_pixmap)
			set_title (ev_confirmation_dialog_title)
			set_buttons (<<ev_ok, ev_cancel>>)
			set_default_push_button (button (ev_ok))
			set_default_cancel_button (button (ev_cancel))
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




end -- class EV_CONFIRMATION_DIALOG

