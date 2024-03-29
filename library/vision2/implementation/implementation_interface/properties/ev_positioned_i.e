note
	description:
		"Eiffel Vision positioned, implementation interface.%N%
		%See bridge pattern notes in ev_any.e"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2019-03-21 10:31:08 +0000 (Thu, 21 Mar 2019) $"
	revision: "$Revision: 102994 $"

deferred class
	EV_POSITIONED_I

inherit
	EV_ANY_I
		redefine
			interface
		end

feature -- Measurement

	x_position: INTEGER
			-- Horizontal offset relative to parent `x_position' in pixels.
		deferred
		end

	y_position: INTEGER
			-- Vertical offset relative to parent `y_position' in pixels.
		deferred
		end

	screen_x: INTEGER
			-- Horizontal offset relative to screen.
		deferred
		end

	screen_y: INTEGER
			-- Vertical offset relative to screen.
		deferred
		end

	width: INTEGER
			-- Horizontal size in pixels.
		deferred
		end

	height: INTEGER
			-- Vertical size in pixels.
		deferred
		end

	minimum_width: INTEGER
			-- Minimum horizontal size in pixels.
		deferred
		end

	minimum_height: INTEGER
			-- Minimum vertical size in pixels.
		deferred
		end

	dpi: NATURAL
			-- Window dpi.
		do
			Result := {EV_MONITOR_DPI_DETECTOR_IMP}.dpi
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_POSITIONED note option: stable attribute end;
		-- Provides a common user interface to platform dependent functionality
		-- implemented by `Current'.
		-- (See bridge pattern notes in ev_any.e)

invariant
	minimum_width_positive_or_zero: is_usable implies minimum_width >= 0
	minimum_height_positive_or_zero: is_usable implies minimum_height >= 0

note
	copyright:	"Copyright (c) 1984-2019, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class EV_POSITIONED_I









