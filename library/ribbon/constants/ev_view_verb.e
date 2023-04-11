note
	description: "Constants for UI_VIEWVERB."
	date: "$Date: 2013-05-20 23:15:17 +0000 (Mon, 20 May 2013) $"
	revision: "$Revision: 92557 $"

class
	EV_VIEW_VERB

feature -- Enumeration

	create_: INTEGER = 0
			-- UI_VIEWVERB_CREATE

	destroy: INTEGER = 1
			-- UI_VIEWVERB_DESTROY

	size: INTEGER = 2
			-- UI_VIEWVERB_SIZE

	error: INTEGER = 3
			-- UI_VIEWVERB_ERROR

feature -- Query

	is_valid (a_int: INTEGER): BOOLEAN
			-- If `a_int' valid ?
		do
			Result := a_int = create_ or a_int = destroy or a_int = size or a_int = error
		end

note
	copyright: "Copyright (c) 1984-2011, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
