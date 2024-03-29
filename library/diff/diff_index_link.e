note
	description: "This are objects that are used internaly by the diff algorithm to store a list of indices that are a match."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2013-05-20 23:15:17 +0000 (Mon, 20 May 2013) $"
	revision: "$Revision: 92557 $"

class
	DIFF_INDEX_LINK

create
	make

feature {NONE} -- Initialization

	make (a_link: detachable DIFF_INDEX_LINK; a_src: INTEGER; a_dst: INTEGER)
			-- Create the element
		do
			next := a_link
			index_src := a_src
			index_dst := a_dst
		end


feature -- Access

	index_src: INTEGER
			-- The source index of the link.

	index_dst: INTEGER
			-- The destination index of the link.

	next: detachable DIFF_INDEX_LINK;
			-- The next link (or void if none)

note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
