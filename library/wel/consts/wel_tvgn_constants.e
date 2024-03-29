note
	description: "Tree view selection type constants."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2008-12-29 20:27:11 +0000 (Mon, 29 Dec 2008) $"
	revision: "$Revision: 76420 $"

class
	WEL_TVGN_CONSTANTS

feature -- Access

	Tvgn_caret: INTEGER = 9
			-- Sets the selection to the given item or retrieves
			-- the currently selected item.
			--
			-- Declared in Windows as TVGN_CARET

	Tvgn_child: INTEGER = 4
			-- Retrieves the first child item.
			-- (the hitem parameter must be Void)
			--
			-- Declared in Windows as TVGN_CHILD

	Tvgn_drophilite: INTEGER = 8
			-- Redraws the given item in the style used to indicate
			-- the target of a drag and drop operation or retrieves
			-- the item that is the target of a drag and drop
			-- operation.
			--
			-- Declared in Windows as TVGN_DROPHILITE

	Tvgn_firstvisible: INTEGER = 5
			-- Scrolls the tree view vertically so that the given
			-- item is the first visible item or retrieves the
			-- first visible item.
			--
			-- Declared in Windows as TVGN_FIRSTVISIBLE

	Tvgn_next: INTEGER = 1
			-- Retrieves the next siblings item.
			--
			-- Declared in Windows as TVGN_NEXT

	Tvgn_nextvisible: INTEGER = 6
			-- Retrieves the next visible item.
			--
			-- Declared in Windows as TVGN_NEXTVISIBLE

	Tvgn_parent: INTEGER = 3
			-- Retrieves the parent of the specified item.
			--
			-- Declared in Windows as TVGN_PARENT

	Tvgn_previous: INTEGER = 2
			-- Retrieves the previous siblings item.
			--
			-- Declared in Windows as TVGN_PREVIOUS

	Tvgn_previousvisible: INTEGER = 7
			-- Retrieves the previous visible item.
			--
			-- Declared in Windows as TVGN_PREVIOUSVISIBLE

	Tvgn_root: INTEGER = 0;
			-- Retrieves the top-most or very-first item
			-- of the tree-view control.
			--
			-- Declared in Windows as TVGN_ROOT

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




end -- class WEL_TVGN_CONSTANTS

