note
	description: "Eiffel Vision tree item. GTK+ implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2009-06-11 05:52:23 +0000 (Thu, 11 Jun 2009) $"
	revision: "$Revision: 79207 $"

class
	EV_TREE_ITEM_IMP

inherit
	EV_TREE_ITEM_I
		undefine
			reset_pebble_function
		redefine
			interface
		end

	EV_TREE_NODE_IMP
		redefine
			interface
		end

create
	make

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_TREE_ITEM note option: stable attribute end;

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

end -- class EV_TREE_ITEM_IMP
