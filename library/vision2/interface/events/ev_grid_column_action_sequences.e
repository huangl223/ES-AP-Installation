note
	description: "Objects that represent action sequences for EV_GRID_COLUMN."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2016-09-27 15:50:48 +0000 (Tue, 27 Sep 2016) $"
	revision: "$Revision: 99192 $"

deferred class
	EV_GRID_COLUMN_ACTION_SEQUENCES

inherit
	EV_ACTION_SEQUENCES

feature -- Access

	select_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions to be performed when `Current' is selected.
		do
			Result := implementation.select_actions
		ensure
			result_not_void: Result /= Void
		end

	deselect_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions to be performed when `Current' is deselected.
		do
			Result := implementation.deselect_actions
		ensure
			result_not_void: Result /= Void
		end

feature {NONE} -- Implementation

	implementation: EV_GRID_COLUMN_ACTION_SEQUENCES_I
		deferred
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




end







