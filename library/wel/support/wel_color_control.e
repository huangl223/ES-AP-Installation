note
	description: "Common type for several control which%
				% backgound and foreground colors can be%
				% changed"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2008-12-29 20:27:11 +0000 (Mon, 29 Dec 2008) $"
	revision: "$Revision: 76420 $"

deferred class
	WEL_COLOR_CONTROL

inherit
	WEL_COLOR_CONSTANTS

feature -- Access

	foreground_color: WEL_COLOR_REF
			-- foreground color used for the text of the
			-- control
		require
			exists: exists
		deferred
		ensure
			foreground_color_not_void: Result /= Void
		end

	background_color: WEL_COLOR_REF
			-- Background color used for the background of the
			-- control
		require
			exists: exists
		deferred
		ensure
			background_color_not_void: Result /= Void
		end

feature -- Status report

	exists: BOOLEAN
			-- Does the control exists ?
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




end -- class WEL_COLOR_CONTROL

