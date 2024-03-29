﻿note
	description:
		"[
			Item for use in EV_MENU.

			Note:
			Single ampersands in text are not shown in the actual
			widget. If you need an ampersand in your text,
			use && instead. The character following the & may
			be a shortcut to this widget (combined with Alt)
			&File -> File (Alt+F = shortcut)
			Fish && Chips -> Fish & Chips (no shortcut).
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "menu, item, dropdown, popup"
	date: "$Date: 2018-12-18 11:03:05 +0000 (Tue, 18 Dec 2018) $"
	revision: "$Revision: 102624 $"

class
	EV_MENU_ITEM

inherit
	EV_ITEM
		redefine
			implementation,
			is_in_default_state,
			default_identifier_name
		end

	EV_TEXTABLE
		undefine
			initialize
		redefine
			implementation,
			is_in_default_state
		end

	EV_SENSITIVE
		undefine
			initialize
		redefine
			implementation,
			is_in_default_state,
			default_identifier_name
		end

	EV_MENU_ITEM_ACTION_SEQUENCES

create
	default_create,
	make_with_text,
	make_with_text_and_action

feature {NONE} -- Initialization

	make_with_text_and_action
		(a_text: READABLE_STRING_GENERAL; an_action: PROCEDURE)
			-- Create with 'a_text' and `an_action' in `select_actions'.
		require
			text_not_void: a_text /= Void
			an_action_not_void: an_action /= Void
		do
			default_create
			set_text (a_text)
			select_actions.extend (an_action)
		ensure
			text_assigned: text.same_string_general (a_text)
			select_actions_has_an_action: select_actions.has (an_action)
		end

feature -- Access

	default_identifier_name: STRING_32
			-- Default name if no other name is set.
		local
			i: INTEGER
		do
			if text.is_empty then
				Result := Precursor {EV_ITEM}
			else
				Result := text.twin
				Result.prune_all ('&')
				Result.prune_all ('.')
				i := Result.index_of ('%T', 1)
				if i > 0 then
					Result.keep_head (i-1)
				end
				Result.to_lower
			end
		end

feature -- Obsolete

	align_text_left
			-- Display text left aligned
		obsolete "Was not implemented on all platforms. [2017-05-31]"
		require
			not_destroyed: not is_destroyed
		do
		end

	align_text_center
			-- Display text center aligned
		obsolete "Was not implemented on all platforms. [2017-05-31]"
		require
			not_destroyed: not is_destroyed
		do
		end

	align_text_right
			-- Display text right aligned
		obsolete "Was not implemented on all platforms. [2017-05-31]"
		require
			not_destroyed: not is_destroyed
		do
		end

feature {NONE} -- Contract support

	is_in_default_state: BOOLEAN
			-- Is `Current' in its default state?
		do
			Result := Precursor {EV_ITEM} and Precursor {EV_TEXTABLE} and
				Precursor {EV_SENSITIVE}
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	implementation: EV_MENU_ITEM_I
			-- Responsible for interaction with native graphics toolkit.

feature {NONE} -- Implementation

	create_implementation
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_MENU_ITEM_IMP} implementation.make
		end

note
	copyright: "Copyright (c) 1984-2018, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
