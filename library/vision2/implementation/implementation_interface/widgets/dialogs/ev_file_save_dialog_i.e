note
	description: "Eiffel Vision file save dialog."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2013-01-13 18:35:47 +0000 (Sun, 13 Jan 2013) $"
	revision: "$Revision: 90528 $"

deferred class
	EV_FILE_SAVE_DIALOG_I

inherit
	EV_FILE_DIALOG_I
		redefine
			internal_accept
		end

feature {NONE} -- Implementation

	internal_accept: IMMUTABLE_STRING_32
			-- The text of the "ok" type button of `Current'.
			-- e.g. not the cancel button.
			-- See comment in EV_STANDARD_DIALOG_I.
		do
			Result := ev_save
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




end -- class EV_FILE_SAVE_DIALOG_I

