note
	description: "Observer for UNDO_REDO_STACK"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2013-11-20 01:34:28 +0000 (Wed, 20 Nov 2013) $"
	revision: "$Revision: 93466 $"

deferred class
	UNDO_REDO_OBSERVER

feature -- Updates

	on_changed
			-- Undo/redo stack has just changed.
		do
		end

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




end -- class UNDO_REDO_OBSERVER
