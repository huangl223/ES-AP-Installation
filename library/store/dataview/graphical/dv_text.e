note
	description: "Text field or text area."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2019-08-26 15:54:41 +0000 (Mon, 26 Aug 2019) $"
	revision: "$Revision: 103422 $"

class
	DV_TEXT

inherit
	EV_TEXT

	DV_SENSITIVE_STRING
		undefine
			default_create,
			copy
		end

feature -- Access

	value: STRING_32
			-- Text area value.
		do
			Result := text
		end

feature -- Basic operations

	set_value (a_text: STRING)
			-- Set display string to `a_text'.
		do
			if a_text /= Void and then not a_text.is_empty then
				a_text.prune_all (Carriage_return)
				set_text (a_text)
			else
				remove_text
			end
		end

	request_sensitive
			-- Request display sensitive.
		do
			if not is_locked then
				enable_sensitive
			end
		end

	request_insensitive
			-- Request display insensitive.
		do
			if not is_locked then
				disable_sensitive
			end
		end

	lock_sensitiveness
			-- Lock display string sensitiveness.
		do
			is_locked := True
		end

	unlock_sensitiveness
			-- Unlock display string sensitiveness.
		do
			is_locked := False
		end

feature -- Status report

	is_locked: BOOLEAN
			-- Is label sensitiveness locked?

feature {NONE} -- Implementation

	Carriage_return: CHARACTER = '%R';
			-- Carriage return character.

note
	copyright:	"Copyright (c) 1984-2019, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class DV_TEXT


