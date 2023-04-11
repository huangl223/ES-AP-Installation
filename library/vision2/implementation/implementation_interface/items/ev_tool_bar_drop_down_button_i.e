note
	description:
		"Eiffel Vision tool bar dropdown button. Implementation interface."
	date: "$Date: 2013-05-20 23:15:17 +0000 (Mon, 20 May 2013) $"
	revision: "$Revision: 92557 $"

deferred class
	EV_TOOL_BAR_DROP_DOWN_BUTTON_I

inherit
	EV_TOOL_BAR_BUTTON_I
		redefine
			interface
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_TOOL_BAR_DROP_DOWN_BUTTON note option: stable attribute end;
			-- Provides a common user interface to possibly dependent
			-- functionality implemented by `Current'.

end
