note
	description: "Tables whose keys are integers in a contiguous interval"
	library: "Free implementation of ELKS library"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	names: indexable, access;
	access: index, membership;
	contents: generic;
	date: "$Date: 2012-05-24 04:13:10 +0000 (Thu, 24 May 2012) $"
	revision: "$Revision: 91981 $"

deferred class INDEXABLE [G, H -> INTEGER] inherit

	TABLE [G, INTEGER]
		rename
			valid_key as valid_index,
			force as put
		end

	READABLE_INDEXABLE [G]

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



