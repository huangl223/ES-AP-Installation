note 
	description: "EiffelVision font selection dialog, implementation interface."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2008-12-29 20:27:11 +0000 (Mon, 29 Dec 2008) $"
	revision: "$Revision: 76420 $"

deferred class
	EV_FONT_DIALOG_I

inherit
	EV_STANDARD_DIALOG_I

feature -- Access

	font: EV_FONT
			-- Font selected in `Current'.
		require
		deferred
		end

feature -- Element change

	set_font (a_font: EV_FONT)
			-- Assign `a_font' to `font'.
		require
			a_font_not_void: a_font /= Void
		deferred
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




end -- class EV_FONT_DIALOG_I

