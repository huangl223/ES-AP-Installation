note
	description: "Action sequences for EV_CHECKABLE_TREE_I"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2016-09-27 15:50:48 +0000 (Tue, 27 Sep 2016) $"
	revision: "$Revision: 99192 $"

deferred class
	EV_CHECKABLE_TREE_ACTION_SEQUENCES_I

feature -- Event handling

	check_actions: EV_TREE_ITEM_CHECK_ACTION_SEQUENCE
			-- Actions to be performed when an item is checked.
		do
			if attached check_actions_internal as l_result then
				Result := l_result
			else
				create Result
				check_actions_internal := Result
			end
		ensure
			not_void: Result /= Void
		end

feature {EV_ANY_I} -- Implementation

	check_actions_internal: detachable EV_TREE_ITEM_CHECK_ACTION_SEQUENCE
			-- Implementation of once per object `check_actions'.
		note
			option: stable
		attribute
		end

feature -- Event handling

	uncheck_actions: EV_TREE_ITEM_CHECK_ACTION_SEQUENCE
			-- Actions to be performed when an item is unchecked.
		do
			if attached uncheck_actions_internal as l_result then
				Result := l_result
			else
				create Result
				uncheck_actions_internal := Result
			end
		ensure
			not_void: Result /= Void
		end

feature {EV_ANY_I} -- Implementation

	uncheck_actions_internal: detachable EV_TREE_ITEM_CHECK_ACTION_SEQUENCE
			-- Implementation of once per object `uncheck_actions'.
		note
			option: stable
		attribute
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




end -- class EV_CHECKABLE_TREE_ACTION_SEQUENCES_I












