note
	description: "Objects that represent an EV_TITLED_WINDOW.%
		%The original version of this class was generated by EiffelBuild."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2009-08-13 07:53:17 +0000 (Thu, 13 Aug 2009) $"
	revision: "$Revision: 80230 $"

class
	SD_TOOL_BAR_CONTAINER

inherit
	SD_TOOL_BAR_CONTAINER_IMP

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization
		do
				-- Create all widgets.
			create top
			create l_ev_horizontal_box_1
			create left
			create center
			create right
			create bottom

			default_create
		end

	user_initialization
			-- Called by `initialize'.
			-- Any custom user initialization that
			-- could not be performed in `initialize',
			-- (due to regeneration of implementation class)
			-- can be added here.
		do
		end

feature {NONE} -- Implementation



note
	library:	"SmartDocking: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"






end -- class SD_TOOL_BAR_CONTAINER

