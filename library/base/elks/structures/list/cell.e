note
	description: "Cells containing an item"
	library: "Free implementation of ELKS library"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	names: cell;
	contents: generic;
	date: "$Date: 2012-07-23 21:02:19 +0000 (Mon, 23 Jul 2012) $"
	revision: "$Revision: 91989 $"

class CELL [G]

create
	put

feature -- Access

	item: G
			-- Content of cell.

feature -- Element change

	put, replace (v: like item)
			-- Make `v' the cell's `item'.
		do
			item := v
		ensure
			item_inserted: item = v
		end

note
	copyright: "Copyright (c) 1984-2012, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
