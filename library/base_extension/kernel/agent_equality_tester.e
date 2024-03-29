﻿note
	description: "To use comparison facilities but implemented using agents instead."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2017-03-23 21:17:37 +0000 (Thu, 23 Mar 2017) $"
	revision: "$Revision: 100039 $"

class
	AGENT_EQUALITY_TESTER [G]

inherit
	EQUALITY_TESTER [G]
		redefine
			test, is_equal
		end

	PART_COMPARATOR [G]
		redefine
			is_equal
		end

create
	make

feature {NONE} -- Initialization

	make (an_action: like action)
			-- Use `an_action' to compare two elements of type G.
		require
			an_action_not_void: an_action /= Void
		do
			action := an_action
		ensure
			action_set: action = an_action
		end

feature -- Access

	action: FUNCTION [G, G, BOOLEAN]
			-- Action performed to compare two non-void items.

feature -- Status report

	test (v, u: G): BOOLEAN
			-- Are `v' and `u' considered equal?
			-- (Use `equal' by default.)
			--| NOTE: added detachable mark on arguments, when gobo-safe is available
		do
			if v = Void then
				Result := u = Void
			elseif u = Void then
				Result := False
			else
				Result := action.item ([v, u])
			end
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN
		do
			Result := action.is_equal (other.action)
		end

	less_than (u, v: G): BOOLEAN
			-- Is `u' considered less than `v'?
		do
			Result := action.item ([u ,v])
		end

invariant
	action_not_void: action /= Void

note
	copyright:	"Copyright (c) 1984-2017, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
