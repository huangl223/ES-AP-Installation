note
	description: "EiffelVision tool-bar dropdown button, mswindows implementation."
	date: "$Date: 2013-05-20 23:15:17 +0000 (Mon, 20 May 2013) $"
	revision: "$Revision: 92557 $"

class
	EV_TOOL_BAR_DROP_DOWN_BUTTON_IMP

inherit
	EV_TOOL_BAR_DROP_DOWN_BUTTON_I
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

	interface: detachable EV_TOOL_BAR_DROP_DOWN_BUTTON note option: stable attribute end
			-- Tool bar drop down button bridge.

end
