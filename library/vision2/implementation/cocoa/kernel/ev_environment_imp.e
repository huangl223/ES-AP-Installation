﻿note
	description: "Eiffel Vision Environment. Cocoa implementation."
	author: "Daniel Furrer"
	keywords: "environment, global, system"
	date: "$Date: 2018-01-29 12:23:36 +0000 (Mon, 29 Jan 2018) $"
	revision: "$Revision: 101323 $"

class
	EV_ENVIRONMENT_IMP

inherit
	EV_ENVIRONMENT_I
		export
			{ANY} is_destroyed
		end

	EXECUTION_ENVIRONMENT

create
	make

feature {NONE} -- Initialization

	old_make (an_interface: attached like interface)
			-- Pass `an_interface' to base make.
		do
			assign_interface (an_interface)
		end

	make
			-- No initialization needed.
		do
			set_is_initialized (True)
		end

feature -- Access

	supported_image_formats: LINEAR [STRING_32]
			-- `Result' contains all supported image formats
			-- on current platform, in the form of their three letter extension.
			-- e.g. PNG, BMP, ICO
		once
			Result := create {ARRAYED_LIST [STRING_32]}.make_from_array (<<{STRING_32} "PNG">>)
			Result.compare_objects
		end

	mouse_wheel_scroll_lines: INTEGER
			-- Default number of lines to scroll in response to
			-- a mouse wheel scroll event.
		do
			Result := 3
		end

	default_pointer_style_width: INTEGER
			-- Default pointer style width.
		do
		end

	default_pointer_style_height: INTEGER
			-- Default pointer style height.
		do
		end

	has_printer: BOOLEAN
			-- Is a default printer available?
			-- `Result' is `True' if at least one printer is installed.
		do
			system ("which lpr > /dev/null 2>&1")
			Result := return_code = 0
		end

	font_families: LINEAR [STRING_32]
			-- List of fonts available on the system
		once
			check
				not_implemented: False
			end
			create {LINKED_LIST [STRING_32]}Result.make
		end

note
	copyright: "Copyright (c) 1984-2018, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
