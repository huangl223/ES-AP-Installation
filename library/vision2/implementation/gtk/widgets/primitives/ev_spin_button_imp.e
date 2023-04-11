note
	description: "Eiffel Vision spin button. GTK+ Implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2017-03-27 20:31:29 +0000 (Mon, 27 Mar 2017) $"
	revision: "$Revision: 100058 $"

class
	EV_SPIN_BUTTON_IMP

inherit
	EV_SPIN_BUTTON_I
		undefine
			hide_border,
			return_actions
		redefine
			interface
		end

	EV_GAUGE_IMP
		undefine
			visual_widget,
			on_key_event,
			on_focus_changed,
			needs_event_box,
			background_color_pointer,
			foreground_color_pointer
		redefine
			interface,
			make,
			old_make
		end

	EV_TEXT_FIELD_IMP
		rename
			change_actions as text_change_actions,
			change_actions_internal as text_change_actions_internal
		redefine
			old_make,
			interface,
			make,
			set_text,
			new_entry_widget
		end

create
	make

feature {NONE} -- Implementation

	old_make (an_interface: attached like interface)
			-- Create the spin button.
		do
			assign_interface (an_interface)
		end

	make
			-- Create and initialize `Current'.
		do
			Precursor {EV_TEXT_FIELD_IMP}
			Precursor {EV_GAUGE_IMP}
		end

feature {NONE} -- Implementation

	set_text (a_text: READABLE_STRING_GENERAL)
			-- Assign `a_text' to `text'.
		do
			Precursor {EV_TEXT_FIELD_IMP} (a_text)
				-- Make sure the spin button updates the internal value
			{GTK}.gtk_spin_button_update (entry_widget)
		end

	new_entry_widget: POINTER
			-- <Precursor>
		do
			Result := {GTK}.gtk_spin_button_new (adjustment, 0, 0)
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_SPIN_BUTTON note option: stable attribute end;

note
	copyright:	"Copyright (c) 1984-2017, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class EV_SPIN_BUTTON_IMP
