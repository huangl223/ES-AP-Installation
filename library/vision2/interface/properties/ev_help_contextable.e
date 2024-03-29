note
	description:
		"Abstraction for objects that support active help contexts."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "help"
	date: "$Date: 2015-12-17 13:34:17 +0000 (Thu, 17 Dec 2015) $"
	revision: "$Revision: 98279 $"

deferred class
	EV_HELP_CONTEXTABLE

inherit
	EV_ANY
		redefine
			implementation
		end

feature -- Access

	help_context: detachable FUNCTION [EV_HELP_CONTEXT]
			-- Agent that evaluates to help context sent to help engine when help is requested
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.help_context
		ensure
			bridge_ok: Result = implementation.help_context
		end

feature -- Element change

	set_help_context (an_help_context: FUNCTION [EV_HELP_CONTEXT])
			-- Assign `an_help_context' to `help_context'.
		require
			not_destroyed: not is_destroyed
			an_help_context_not_void: an_help_context /= Void
		do
			implementation.set_help_context (an_help_context)
		ensure
			help_context_assigned: attached help_context as l_help_context and then l_help_context.is_equal (an_help_context)
		end

	remove_help_context
			-- Remove key press action associated with `EV_APPLICATION.help_key'.
		require
			not_destroyed: not is_destroyed
			help_context_not_void: help_context /= Void
		do
			implementation.remove_help_context
		ensure
			no_help_context: help_context = Void
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	implementation: EV_HELP_CONTEXTABLE_I;
			-- Responsible for interaction with native graphics toolkit.

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




end -- class EV_HELP_CONTEXTABLE











