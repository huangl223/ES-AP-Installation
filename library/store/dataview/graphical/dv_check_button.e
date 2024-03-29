note
	description: "Check button."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2008-12-29 20:27:11 +0000 (Mon, 29 Dec 2008) $"
	revision: "$Revision: 76420 $"

class
	DV_CHECK_BUTTON

inherit
	EV_CHECK_BUTTON

	DV_SENSITIVE_CHECK
		rename
			enable_checked as enable_select,
			disable_checked as disable_select
		undefine
			default_create,
			copy
		end

create
	make_with_text

feature -- Access

	checked: BOOLEAN
			-- Boolean value held.
		do
			Result := is_selected
		end

feature -- Basic operations

	request_sensitive
			-- Request display sensitive.
		do
			enable_sensitive
		end

	request_insensitive
			-- Request display insensitive.
		do
			disable_sensitive
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





end -- class DV_CHECK_BUTTON


