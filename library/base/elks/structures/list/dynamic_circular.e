note
	description: "Dynamically modifiable circular chains"
	library: "Free implementation of ELKS library"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	names: dynamic_circular, ring, sequence;
	access: index, cursor, membership;
	contents: generic;
	date: "$Date: 2018-11-13 12:58:34 +0000 (Tue, 13 Nov 2018) $"
	revision: "$Revision: 102449 $"

deferred class DYNAMIC_CIRCULAR [G] inherit

	CIRCULAR [G]
		undefine
			prune, prune_all
		end

	DYNAMIC_CHAIN [G]
		undefine
			valid_cursor_index,
			search, first, last,
			finish, start, move, go_i_th,
			off, exhausted
		redefine
			duplicate
		end

feature -- Duplication

	duplicate (n: INTEGER): like Current
			-- Copy of sub-chain beginning at current position
			-- and having min (`n', `count') items.
		obsolete
			"[
				Create a new container explicitly using `make_from_iterable` if available.
				Otherwise, replace a call to the feature with code that creates and initializes container.
				[2018-11-30]
			]"
		local
			pos: CURSOR
			to_be_removed, counter: INTEGER
		do
			from
				Result := new_chain
				pos := cursor
				to_be_removed := count.min (n)
			until
				counter = to_be_removed
			loop
				Result.extend (item)
				forth
				counter := counter + 1
			end
			go_to (pos)
		end

note
	copyright: "Copyright (c) 1984-2018, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
