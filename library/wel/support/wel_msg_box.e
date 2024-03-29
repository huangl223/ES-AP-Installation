note
	description: "Interface on the MessageBox function."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2011-01-13 23:53:42 +0000 (Thu, 13 Jan 2011) $"
	revision: "$Revision: 85350 $"

class
	WEL_MSG_BOX

inherit
	WEL_MB_CONSTANTS
		export
			{NONE} all
			{WEL_MSG_BOX} Mb_usericon
		end

	WEL_LANGUAGE_CONSTANTS
		export
 			{NONE} all
		end

	WEL_BIT_OPERATIONS

create
	make

feature -- Basic operations

	make
		-- initialize language
		do
			language := LANG_ENGLISH
			sublanguage := SUBLANG_ENGLISH_US
		end

	information_message_box (a_window: detachable WEL_WINDOW; a_text, a_title: READABLE_STRING_GENERAL)
			-- Show an information message box with message `a_text'
			-- and caption `a_title'
		require
			text_not_void: a_text /= Void
			title_not_void: a_title /= Void
		local
			a_msgboxparams: WEL_MSGBOXPARAMS
		do
			create a_msgboxparams.make_basic (a_window, a_text, a_title, Mb_iconinformation + Mb_ok, language, sublanguage)
			message_box_result := cwin_message_box_indirect (a_msgboxparams.item)
		end

	warning_message_box (a_window: detachable WEL_WINDOW; a_text, a_title: READABLE_STRING_GENERAL)
			-- Show a warning message box with message `a_text'
			-- and caption `a_title'
		require
			text_not_void: a_text /= Void
			title_not_void: a_title /= Void
		local
			a_msgboxparams: WEL_MSGBOXPARAMS
		do
			create a_msgboxparams.make_basic (a_window, a_text, a_title, Mb_iconwarning + Mb_ok, language, sublanguage)
			message_box_result := cwin_message_box_indirect (a_msgboxparams.item)
		end

	error_message_box (a_window: detachable WEL_WINDOW; a_text, a_title: READABLE_STRING_GENERAL)
			-- Show an error message box with message `a_text'
			-- and caption `a_title'
		require
 			text_not_void: a_text /= Void
 			title_not_void: a_title /= Void
 		local
 			a_msgboxparams: WEL_MSGBOXPARAMS
 		do
 			create a_msgboxparams.make_basic (a_window, a_text, a_title, Mb_iconerror + Mb_ok, language, sublanguage)
 			message_box_result := cwin_message_box_indirect (a_msgboxparams.item)
		end

	question_message_box (a_window: detachable WEL_WINDOW; a_text, a_title: READABLE_STRING_GENERAL)
			-- Show a question message box with message `a_text'
			-- and caption `a_title'
		require
			text_not_void: a_text /= Void
			title_not_void: a_title /= Void
		local
			a_msgboxparams: WEL_MSGBOXPARAMS
		do
			create a_msgboxparams.make_basic (a_window, a_text, a_title, Mb_iconquestion + Mb_yesno, language, sublanguage)
			message_box_result := cwin_message_box_indirect (a_msgboxparams.item)
		end

	basic_message_box (a_window: detachable WEL_WINDOW; a_text, a_title: READABLE_STRING_GENERAL; a_style: INTEGER)
			-- Show a basic message box with `a_text' inside and
			-- `a_title' using `a_style'. Basic means `a_style' should not contain
			-- the flag `MB_USERICON'.
			-- See class WEL_MB_CONSTANTS for `a_style' value.
		require
			basic_message_box: basic_msg_box (a_style)
			text_not_void: a_text /= Void
			title_not_void: a_title /= Void
		local
			a_msgboxparams: WEL_MSGBOXPARAMS
		do
			create a_msgboxparams.make_basic (a_window, a_text, a_title, a_style, language, sublanguage)
			message_box_result := cwin_message_box_indirect (a_msgboxparams.item)
		end

	user_icon_message_box (a_window: detachable WEL_WINDOW; a_text, a_title: READABLE_STRING_GENERAL; a_style, an_id: INTEGER)
			-- Show a message box with a user icon `an_id',
			-- `a_text' inside and `a_title' using `a_style'.
			-- the flag `MB_USERICON' must be present in `a_style'.
			-- See class WEL_MB_CONSTANTS for `a_style' value.
		require
			user_message_box: not basic_msg_box (a_style)
			text_not_void: a_text /= Void
			title_not_void: a_title /= Void
		local
			a_msgboxparams: WEL_MSGBOXPARAMS
		do
			create a_msgboxparams.make_by_id (a_window, a_text, a_title, a_style, an_id, language, sublanguage)
			message_box_result := cwin_message_box_indirect (a_msgboxparams.item)
		end

	set_language (a_language_id, a_sublanguage_id: INTEGER)
			-- set language to a_language_id
			-- and sublanguage to a_sublanguage_id
		require
			valid_langid: a_language_id > 0
			valid_sublangid: a_sublanguage_id > 0
		do
			language := a_language_id
			sublanguage := a_sublanguage_id
		ensure
			language_set: language = a_language_id
			sublanguage_set: sublanguage = a_sublanguage_id
		end

feature -- Status report

	message_box_result: INTEGER
			-- Last result for all `xxx_message_box' routines.
			-- See class WEL_ID_CONSTANTS for values.

	language: INTEGER
			-- Actual language for "push buttons"

	sublanguage: INTEGER
			-- Sublanguage of language for "push buttons"

feature -- Implementation

	basic_msg_box (a_style: INTEGER): BOOLEAN
			-- does `a_style' contain the flag `Mb_usericon'?
		do
			Result := ((a_style // Mb_usericon) = ((a_style // (Mb_usericon*2))*2))
		end

feature {NONE} -- Externals

	cwin_message_box_indirect (a_msgboxparams: POINTER): INTEGER
		external
			"C [macro <wel.h>] (LPMSGBOXPARAMS): EIF_INTEGER"
		alias
			"MessageBoxIndirect"
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




end -- class WEL_MESSAGE_BOX

