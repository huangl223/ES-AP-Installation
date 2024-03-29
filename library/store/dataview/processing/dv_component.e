note
	description: "Component that has to be activated."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2008-12-29 20:27:11 +0000 (Mon, 29 Dec 2008) $"
	revision: "$Revision: 76420 $"

deferred class
	DV_COMPONENT

feature -- Initialization

	activate
			-- Activate component.
		require
			can_be_activated: can_be_activated
		deferred
		ensure
			is_activated: is_activated
		end

feature -- Status report

	can_be_activated: BOOLEAN
			-- Can the component be activated?
		deferred
		end

	is_activated: BOOLEAN
			-- Is component activated?
		deferred
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





end -- class DV_COMPONENT


