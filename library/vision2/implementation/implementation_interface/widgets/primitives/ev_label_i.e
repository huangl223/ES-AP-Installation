note
	description:
		"Eiffel Vision label. Implementation interface."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2011-08-09 19:46:45 +0000 (Tue, 09 Aug 2011) $"
	revision: "$Revision: 86973 $"

deferred class
	EV_LABEL_I

inherit
	EV_PRIMITIVE_I
		redefine
			interface
		end

	EV_TEXT_ALIGNABLE_I
		redefine
			interface
		end

	EV_FONTABLE_I
		redefine
			interface
		end

--feature -- Element change
--
--	set_angle (a_angle: REAL) is
--			-- Set counter-clockwise rotation of text from horizontal plane.
--			-- `a_angle' is expressed in radians.
--		deferred
--		ensure
--			angle_set: a_angle = angle
--		end
--
--feature -- Access
--
--	angle: REAL is
--			-- Amount text is rotated counter-clockwise from horizontal plane in radians.
--			-- Default is 0
--		deferred
--		end

feature -- Status Setting

	align_text_top
			-- Set vertical text alignment of current label to top.
		deferred
		end

	align_text_vertical_center
			-- Set text alignment of current label to be in the center vertically.
		deferred
		end

	align_text_bottom
			-- Set vertical text alignment of current label to bottom.
		deferred
		end

feature {EV_ANY, EV_ANY_I} -- implementation

	interface: detachable EV_LABEL note option: stable attribute end;
			-- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'

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




end --class EV_LABEL_I









