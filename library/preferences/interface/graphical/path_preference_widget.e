﻿note
	description	: "[
			Default widget for viewing and editing preferences represented a PATH preference.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2018-01-26 07:51:54 +0000 (Fri, 26 Jan 2018) $"
	revision: "$Revision: 101309 $"

class
	PATH_PREFERENCE_WIDGET

inherit
	PREFERENCE_WIDGET
		redefine
			change_item_widget,
			update_changes,
			refresh
		end

create
	make_with_preference

feature -- Access

	change_item_widget: EV_GRID_EDITABLE_ITEM
			-- Widget to change the value of this preference.

	graphical_type: STRING
			-- Graphical type identifier
		do
			Result := "PATH"
		end

feature -- Status Setting

	show
			-- Show the widget in its editable state
		do
			activate
		end

feature {NONE} -- Command

	update_changes
			-- Update the changes made in `change_item_widget' to `preference'.
		do
			preference.set_value_from_string (change_item_widget.text)
			Precursor {PREFERENCE_WIDGET}
		end

	refresh
			-- Refresh
		do
			if attached {PATH_PREFERENCE} preference as p32 then
				change_item_widget.set_text (p32.value.name)
			else
				change_item_widget.set_text (preference.text_value)
			end
		end

feature {NONE} -- Implementation

	build_change_item_widget
			-- Create and setup `change_item_widget'.
		do
			create change_item_widget
			change_item_widget.deactivate_actions.extend (agent update_changes)
			change_item_widget.set_text (preference.text_value)
			change_item_widget.pointer_button_press_actions.extend
				(agent (x, y, b: INTEGER_32; x_tilt, y_tilt, pressure: REAL_64; screen_x, screen_y: INTEGER_32) do activate end)
		end

	activate
			-- Activate the text
		do
			change_item_widget.activate
			change_item_widget.set_text_validation_agent (agent validate_preference_text)
			if attached change_item_widget.text_field as tf and then not tf.text.is_empty then
				tf.select_all
			end
		end

    validate_preference_text (a_text: STRING_32): BOOLEAN
            -- Validate `a_text'.  Disallow input if text is not a path
        do
			Result := preference.valid_value_string (a_text)
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
