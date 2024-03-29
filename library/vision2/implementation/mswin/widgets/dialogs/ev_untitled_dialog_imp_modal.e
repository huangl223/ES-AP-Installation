note
	description: "Eiffel Vision dialog. Mswindows implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2016-01-11 12:49:19 +0000 (Mon, 11 Jan 2016) $"
	revision: "$Revision: 98373 $"

class
	EV_UNTITLED_DIALOG_IMP_MODAL

inherit
	EV_DIALOG_IMP_MODAL
		undefine
			promote_to_dialog_window,
			update_style,
			has_title_bar
		redefine
			interface,
			other_imp,
			common_dialog_imp
		end

	EV_UNTITLED_DIALOG_IMP_COMMON
		undefine
			hide, is_modal, setup_dialog
		redefine
			interface,
			other_imp,
			common_dialog_imp
		end

create
	make_with_dialog_window

feature {EV_DIALOG_I} -- Implementation

	other_imp: detachable EV_UNTITLED_DIALOG_IMP note option: stable attribute end
			-- Previous Implementation if any, Void otherwise.

feature {NONE} -- Implementation

	common_dialog_imp: detachable EV_DIALOG_IMP_MODAL
			-- Dialog implementation type common to all descendents.
		do
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_UNTITLED_DIALOG note option: stable attribute end;
			-- Interface for `Current'.

note
	copyright:	"Copyright (c) 1984-2016, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class EV_DIALOG_IMP_MODAL





