note
	description:
		"Comparators for characters"
	legal: "See notice at end of class."

	status: "See notice at end of class."
	date: "$Date: 2009-05-06 15:19:03 +0000 (Wed, 06 May 2009) $"
	revision: "$Revision: 78525 $"

deferred class
	COMPARATOR

feature -- Access

	character_set: STRING
			-- Character set represented by comparator
		deferred
		end

	contains (c: CHARACTER): BOOLEAN
			-- Does comparator contain `c'?
		deferred
		end

invariant

	no_empty_comparator: character_set /= Void and then
			not character_set.is_empty

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




end -- class COMPARATOR

