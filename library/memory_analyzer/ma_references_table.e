note
	description: "Objects represent mappings of addresses. [referrer, referee]"
	date: "$Date: 2017-05-03 08:43:46 +0000 (Wed, 03 May 2017) $"
	revision: "$Revision: 100308 $"

class
	MA_REFERENCES_TABLE [G -> HASHABLE, H -> HASHABLE]

create
	make

feature {NONE} -- Initialization

	make (a_referee_count: INTEGER)
			-- Init with `a_referee_count'
		do
			create relations.make (a_referee_count)
		end

feature -- Access

	references_by_referee (a_referee: H): HASH_TABLE [TUPLE [referee: H; data: detachable ANY], G]
			-- All relations by referee.
		require
			a_referee_not_void: a_referee /= Void
		do
			Result := relations.item (a_referee)
			if Result = Void then
				create Result.make (0)
			end
		ensure
			Result_not_void: Result /= Void
		end

	referee_count: INTEGER
			-- Count for referees
		do
			Result := relations.count
		end

	count: INTEGER
			-- Count for all references.
		local
			l_relations: like relations
		do
			from
				l_relations := relations
				l_relations.start
			until
				l_relations.after
			loop
				Result := Result + l_relations.item_for_iteration.count
				l_relations.forth
			end
		end

feature -- Element change

	extend (a_referrer: G; a_referee: H; data: detachable ANY)
			-- Add new relations
		require
			a_referrer_not_void: a_referrer /= Void
			a_referee_not_void: a_referee /= Void
		local
			l_hash: detachable like references_by_referee
		do
			l_hash := relations.item (a_referee)
			if l_hash = Void then
				create l_hash.make (20)
					-- Here we prevent extending pairs exsited or with equivalent key and value.
				relations.force (l_hash, a_referee)
			end
			l_hash.force ([a_referee, data], a_referrer)
		end

feature -- Removal

	remove (a_referrer: G; a_referee: H)
			-- Remove relation between `'a_referrer' and `a_referee'.
		require
			a_referrer_not_void: a_referrer /= Void
			a_referee_not_void: a_referee /= Void
		do
			if
				attached relations.item (a_referee) as l_hash
			then
				l_hash.remove (a_referrer)
				if l_hash.is_empty then
					relations.remove (a_referee)
				end
			end
		end

feature {NONE} -- Implementation

	relations: HASH_TABLE [like references_by_referee, H];

note
	copyright:	"Copyright (c) 1984-2017, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
