note
	description: "Horizontal box for display elements"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2008-12-29 20:27:11 +0000 (Mon, 29 Dec 2008) $"
	revision: "$Revision: 76420 $"

class
	DV_HORIZONTAL_BOX

inherit
	EV_HORIZONTAL_BOX
		undefine
			extend
		redefine
			implementation
		end

	DV_BOX
		redefine
			implementation
		end

create
	make,
	make_without_borders

feature -- Basic operations

	extend_separator
			-- Add a non-expandable separator to end
			-- of structure.
		local
			sep: EV_VERTICAL_SEPARATOR
		do
			create sep
			extend (sep)
			disable_item_expand (sep)
		end

feature {EV_ANY, EV_ANY_I} -- Implementation
 	
	implementation: EV_HORIZONTAL_BOX_I;
			-- Responsible for interaction with the native graphics toolkit.
	
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





end -- class DV_HORIZONTAL_BOX




