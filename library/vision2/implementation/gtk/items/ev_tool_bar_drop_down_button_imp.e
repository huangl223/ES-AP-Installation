note
	description: "Objects that ..."
	author: ""
	date: "$Date: 2016-09-27 15:50:48 +0000 (Tue, 27 Sep 2016) $"
	revision: "$Revision: 99192 $"

class
	EV_TOOL_BAR_DROP_DOWN_BUTTON_IMP

inherit
	EV_TOOL_BAR_DROP_DOWN_BUTTON_I
		undefine
			init_select_actions
		redefine
			interface
		end

	EV_TOOL_BAR_BUTTON_IMP
		redefine
			interface
		end

create
	make

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_TOOL_BAR_DROP_DOWN_BUTTON note option: stable attribute end;

note
	copyright:	"Copyright (c) 1984-2014, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- EV_TOOL_BAR_DROP_DOWN_BUTTON_IMP
