note
	description: "A dialog have a drop down shadow. Now the shadow effect it's only supported on Windows Xp."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "dialog, dialogue, popup, window, shadow"
	date: "$Date: 2017-05-03 15:56:14 +0000 (Wed, 03 May 2017) $"
	revision: "$Revision: 100317 $"

class
	EV_SHADOW_DIALOG

obsolete
	"Use EV_POPUP_WINDOW instead [2017-05-31]"

inherit
	EV_POPUP_WINDOW

create
	default_create

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

end
