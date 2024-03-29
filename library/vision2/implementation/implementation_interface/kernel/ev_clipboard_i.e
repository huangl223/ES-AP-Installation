note
	description: "Objects that allow access to the operating %N%
	%system clipboard."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2011-01-13 23:53:42 +0000 (Thu, 13 Jan 2011) $"
	revision: "$Revision: 85350 $"

deferred class
	EV_CLIPBOARD_I

inherit
	EV_ANY_I
		redefine
			interface
		end

feature -- Access

	has_text: BOOLEAN
			-- Does the clipboard currently contain text?
		deferred
		end

	text: STRING_32
		deferred
		ensure
			Result_not_void: Result /= Void
		end

feature -- Status setting

	set_text (a_text: READABLE_STRING_GENERAL)
			-- Assign `a_text' to clipboard.
		require
			text_not_void: a_text /= Void
		deferred
		ensure
			text_cloned: text.same_string_general (a_text) and then text /= a_text
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_CLIPBOARD note option: stable attribute end;
		-- Provides a common user interface to possibly dependent
		-- functionality implemented by `Current'.

invariant
	not_has_text_implies_text_empty: not has_text implies text.is_empty

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




end -- class EV_CLIPBOARD_I









