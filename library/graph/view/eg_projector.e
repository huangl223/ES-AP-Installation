note
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2010-12-08 16:55:59 +0000 (Wed, 08 Dec 2010) $"
	revision: "$Revision: 85085 $"

class
	EG_PROJECTOR

inherit
	EV_MODEL_BUFFER_PROJECTOR
		redefine
			world,
			full_project,
			project
		end

create
	make, make_with_buffer

feature -- Access

	world: EG_FIGURE_WORLD
		-- <Precursor>

feature -- Display updates

	full_project
			-- Project entire area.
		do
			world.update
			Precursor
		end

	project
			-- Make a standard projection of world on device.
		do
			world.update
			Precursor
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




end -- class EG_PROJECTOR

