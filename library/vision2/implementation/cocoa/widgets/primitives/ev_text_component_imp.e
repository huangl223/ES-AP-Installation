note
	description: "EiffelVision text component, Cocoa implementation."
	author: "Daniel Furrer"
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
			default_key_processing_blocked,
			make,
			set_default_minimum_size
		end

feature -- Initialization

	make
			-- Initialize `Current'.
		do
			set_minimum_width_in_characters (4)
				-- Set default width to 4 characters, as on Windows.
			Precursor {EV_PRIMITIVE_IMP}
			enable_tabable_to
			enable_tabable_from
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

	set_default_minimum_size
			-- Called after creation. Set current size and notify parent.
		do
			internal_set_minimum_size (maximum_character_width * 4, 24)
		end

feature {EV_WINDOW_IMP}

	default_key_processing_blocked (a_key: EV_KEY): BOOLEAN
			--
		do
			-- We don't want to lose focus on up or down keys.
			if a_key.code = {EV_KEY_CONSTANTS}.key_down or else a_key.code = {EV_KEY_CONSTANTS}.key_up then
				Result := True
			end
		end

feature {NONE} -- Implementation

	clipboard_content: STRING_32
			-- `Result' is current clipboard content.
		do
			create Result.make_empty
		end

feature {EV_ANY, EV_ANY_I} -- Implementation		

	interface: detachable EV_TEXT_COMPONENT note option: stable attribute end;

note
	copyright: "Copyright (c) 1984-2014, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end -- class EV_TEXT_COMPONENT_IMP
