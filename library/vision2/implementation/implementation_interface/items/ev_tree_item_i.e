note
	description:
		"EiffelVision tree item. Implementation interface."
	legal: "See notice at end of class.";
	status: "See notice at end of class."
	date: "$Date: 2009-06-04 00:11:49 +0000 (Thu, 04 Jun 2009) $";
	revision: "$Revision: 79073 $"

deferred class
	EV_TREE_ITEM_I

inherit
	EV_TREE_NODE_I
		redefine
			interface
		end

	EV_TREE_NODE_LIST_I
		redefine
			interface
		end

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




end -- class EV_TREE_ITEM_I









