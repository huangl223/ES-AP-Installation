note
	description: "A model for a graph node"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2010-12-08 16:55:59 +0000 (Wed, 08 Dec 2010) $"
	revision: "$Revision: 85085 $"

class
	EG_NODE

inherit
	EG_LINKABLE
		redefine
			default_create
		end

create
	default_create

feature {NONE} -- Initialization

	default_create
			-- Create a EG_NODE
		do
			Precursor {EG_LINKABLE}
		end

note
	copyright:	"Copyright (c) 1984-2010, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class EG_NODE

