note
	description:
		"[
			Press dropdown button for use with EV_TOOL_BAR
		]"
	date: "$Date: 2013-05-20 23:15:17 +0000 (Mon, 20 May 2013) $"
	revision: "$Revision: 92557 $"

class
	EV_TOOL_BAR_DROP_DOWN_BUTTON

inherit
	EV_TOOL_BAR_BUTTON
		export
			{ANY} drop_down_actions
		redefine
			create_implementation,
			implementation
		end

create
	default_create,
	make_with_text

feature {EV_ANY, EV_ANY_I} -- Implementation

	implementation: EV_TOOL_BAR_DROP_DOWN_BUTTON_I
			-- Responsible for interaction with native graphics toolkit.

feature {NONE} -- Implementation

	create_implementation
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_TOOL_BAR_DROP_DOWN_BUTTON_IMP} implementation.make
		end

end
