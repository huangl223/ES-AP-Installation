note
	description: "Tree view style (TVS) constants."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2008-12-29 20:27:11 +0000 (Mon, 29 Dec 2008) $"
	revision: "$Revision: 76420 $"

class
	WEL_TVS_CONSTANTS

feature -- Access

	Tvs_hasbuttons: INTEGER = 1
			-- Displays plus (+) and minus (-) buttons next to
			-- parent items. The user clicks the buttons to expand
			-- or collapse a parent item's list of child items. To
			-- include buttons with items at the root of the tree
			-- view, Tvs_linesatroot must also be specified.
			--
			-- Declared in Windows as TVS_HASBUTTONS

	Tvs_haslines: INTEGER = 2
			-- Uses lines to show the hierarchy of items.
			--
			-- Declared in Windows as TVS_HASLINES

	Tvs_linesatroot: INTEGER = 4
			-- Uses lines to link items at the root of the
			-- tree-view control. This value is ignored if
			-- Tvs_haslines is not also specified.
			--
			-- Declared in Windows as TVS_LINESATROOT

	Tvs_editlabels: INTEGER = 8
			-- Allows the user to edit the labels of tree-view
			-- items.
			--
			-- Declared in Windows as TVS_EDITLABELS

	Tvs_disabledragdrop: INTEGER = 16
			-- Prevents the tree-view control from sending
			-- Tvn_begindrag notification messages.
			--
			-- Declared in Windows as TVS_DISABLEDRAGDROP

	Tvs_showselalways: INTEGER = 32
			-- Causes a selected item to remain selected when the
			-- tree-view control loses focus.
			--
			-- Declared in Windows as TVS_SHOWSELALWAYS
			
	Tvs_checkboxes: INTEGER = 256
			-- Enables a check box for ech item contained.
			--
			-- Declared in Windows as TVS_CHECKBOXES
	

	Tvs_infotip: INTEGER = 2048;
			-- Declared in Windows as TVS_INFOTIP

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




end -- class WEL_TVS_CONSTANTS

