note
	description:
		"Projection to a Printer."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "printer, output, projector"
	date: "$Date: 2016-07-29 13:57:19 +0000 (Fri, 29 Jul 2016) $"
	revision: "$Revision: 99063 $"

deferred class
	EV_MODEL_PRINT_PROJECTOR_I

inherit
	EV_ANY_I
		redefine
			interface
		end

feature -- Basic operations

	project
			-- Make a standard projection of the world on the device.
		deferred
		end

	draw_grid (a_world: EV_MODEL_WORLD)
			-- Draw the grid on the canvas.
		deferred
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_MODEL_PRINT_PROJECTOR note option: stable attribute end;

note
	copyright:	"Copyright (c) 1984-2016, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class EV_MODEL_PRINT_PROJECTOR_I





