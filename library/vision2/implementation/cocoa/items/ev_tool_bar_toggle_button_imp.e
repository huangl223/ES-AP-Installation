note
	description: "EiffelVision toggle tool bar, Cocoa implementations."
	copyright:	"Copyright (c) 2009, Daniel Furrer"
	date: "$Date: 2013-05-20 23:15:17 +0000 (Mon, 20 May 2013) $"
	revision: "$Revision: 92557 $"

class
	EV_TOOL_BAR_TOGGLE_BUTTON_IMP

inherit
	EV_TOOL_BAR_TOGGLE_BUTTON_I
		redefine
			interface
		end

	EV_TOOL_BAR_BUTTON_IMP
		redefine
			interface,
			make
		end

create
	make

feature -- Initialization

	make
			-- Create a Cocoa toggle button.
		do
			Precursor {EV_TOOL_BAR_BUTTON_IMP}
			button.set_button_type ({NS_BUTTON}.push_on_push_off_button)
			cocoa_view := button
		end

feature -- Status setting

	disable_select
			-- Unselect `Current'.
		do
			if is_selected then
				is_selected := False
				button.set_state ({NS_CELL}.off_state)
				if attached select_actions_internal as l_actions then
					l_actions.call (Void)
				end
			end
		end

	enable_select
			-- Select `Current'.
		do
			if not is_selected then
				is_selected := True
				button.set_state ({NS_CELL}.on_state)
				if attached select_actions_internal as l_actions then
					l_actions.call (Void)
				end
			end
		end

feature -- Status report

	is_selected: BOOLEAN
			-- Is `Current' selected.

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_TOOL_BAR_TOGGLE_BUTTON note option: stable attribute end;

end -- class EV_TOOL_BAR_TOGGLE_BUTTON_IMP
