note
	description: "Eiffel Vision password field. Cocoa implementation."
	author: "Daniel Furrer"
	date: "$Date: 2013-05-20 23:15:17 +0000 (Mon, 20 May 2013) $"
	revision: "$Revision: 92557 $"

class
	EV_PASSWORD_FIELD_IMP

inherit
	EV_PASSWORD_FIELD_I
		undefine
			hide_border
		redefine
			interface
		end

	EV_TEXT_FIELD_IMP
		redefine
			make,
			interface
		end

create
	make

feature {NONE} -- Initialization


	make
			-- Create Textfield on a user_pane
		do
			create {NS_SECURE_TEXT_FIELD}text_field.make
			cocoa_view := text_field
			Precursor {EV_TEXT_FIELD_IMP}
			set_is_initialized (True)
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_PASSWORD_FIELD note option: stable attribute end;

end -- class EV_PASSWORD_FIELD_IMP
