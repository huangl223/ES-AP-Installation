note
	description: "Action sequences for EV_DOCKABLE_TARGET."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2016-09-27 15:50:48 +0000 (Tue, 27 Sep 2016) $"
	revision: "$Revision: 99192 $"

deferred class
	EV_DOCKABLE_TARGET_ACTION_SEQUENCES

inherit
	EV_ACTION_SEQUENCES

feature {NONE} -- Implementation

	implementation: EV_DOCKABLE_TARGET_ACTION_SEQUENCES_I
		deferred
		end

feature -- Event handling

	docked_actions: EV_DOCKABLE_SOURCE_ACTION_SEQUENCE
			-- Actions to be performed when a dockable source completes a transport
			-- Fired only if source has been moved, after parenting.
		do
			Result := implementation.docked_actions
		ensure
			not_void: Result /= Void
		end

note
	copyright:	"Copyright (c) 1984-2014, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class EV_DOCKABLE_TARGET_ACTION_SEQUENCES

