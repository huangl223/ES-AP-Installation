note

	description:
		"EiffelVision text component, gtk implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	id: "$Id: ev_text_component_imp.e 99192 2016-09-27 15:50:48Z manus $"
	date: "$Date: 2016-09-27 15:50:48 +0000 (Tue, 27 Sep 2016) $"
	revision: "$Revision: 99192 $"

deferred class
	EV_TEXT_COMPONENT_IMP

inherit
	EV_TEXT_COMPONENT_I
		redefine
			interface
		end

	EV_PRIMITIVE_IMP
		redefine
			interface,
			make,
			foreground_color_pointer
		end

feature -- Initialization

	make
			-- Initialize `Current'.
		do
			set_minimum_width_in_characters (4)
				-- Set default width to 4 characters, as on Windows.
			Precursor {EV_PRIMITIVE_IMP}
		end

feature {EV_INTERMEDIARY_ROUTINES} -- Implementation

	on_change_actions
			-- The text has been changed by the user.
		deferred
		end

feature -- Resizing

	set_minimum_width_in_characters (nb: INTEGER)
			-- Make `nb' characters visible on one line.
		do
			set_minimum_width (nb * maximum_character_width)
				-- 10 = size of handle
		end

	maximum_character_width: INTEGER
			-- Maximum width of a single character in `Current'.
		do
			Result := font.string_width (once "W")
		end

	font: EV_FONT
			-- Current font displayed by widget. (This can be removed if text component is made fontable)
		deferred
		end

feature {NONE} -- Implementation

	foreground_color_pointer: POINTER
			-- Pointer to fg color for `a_widget'.
		do
			Result := {GTK}.gtk_style_struct_text (
				{GTK}.gtk_rc_get_style (visual_widget)
			)
		end

feature {EV_ANY, EV_ANY_I} -- Implementation		

	interface: detachable EV_TEXT_COMPONENT note option: stable attribute end;

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

end -- class EV_TEXT_COMPONENT_IMP
