﻿note
	description: "A button of which the paint operation must be defined by %
		%the developer."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2018-12-18 10:46:58 +0000 (Tue, 18 Dec 2018) $"
	revision: "$Revision: 102623 $"

class
	WEL_OWNER_DRAW_BUTTON

inherit
	WEL_BUTTON

	WEL_BS_CONSTANTS
		export
			{NONE} all
		end

create
	make,
	make_by_id

feature {NONE} -- Implementation

	default_style: INTEGER
			-- Default style used to create the control.
		once
			Result := Ws_visible + Ws_child + Ws_group +
				Ws_tabstop + Bs_ownerdraw
		end

note
	copyright:	"Copyright (c) 1984-2018, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
