note
	description:
		"Closed figures filled with `background_color'."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "figure, atomic, filled, closed"
	date: "$Date: 2015-08-17 23:21:22 +0000 (Mon, 17 Aug 2015) $"
	revision: "$Revision: 97821 $"

deferred class
	EV_MODEL_CLOSED

inherit
	EV_MODEL_ATOMIC

feature -- Access

	background_color: detachable EV_COLOR
			-- Color used to fill `Current'.

feature -- Status report

	is_filled: BOOLEAN
			-- Is this figure filled?
		do
			Result := background_color /= Void
		end

feature -- Status setting

	set_background_color (a_color: EV_COLOR)
			-- Set `background_color' to `a_color'.
		require
			a_color_exists: a_color /= Void
		do
			background_color := a_color
			invalidate
		ensure
			background_color_set: background_color ~ a_color
		end

	remove_background_color
			-- Do not fill this figure.
		do
			background_color := Void
			invalidate
		ensure
			background_color_removed: background_color = Void
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




end -- class EV_MODEL_CLOSED





