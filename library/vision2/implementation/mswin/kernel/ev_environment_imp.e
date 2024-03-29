note
	description:
		"Eiffel Vision Environment. Mswindows implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2017-03-27 17:23:22 +0000 (Mon, 27 Mar 2017) $"
	revision: "$Revision: 100056 $"

class
	EV_ENVIRONMENT_IMP

inherit
	EV_ENVIRONMENT_I

	WEL_SYSTEM_PARAMETERS_INFO
		export
			{NONE} all
		end

create
	make

feature -- Initialization

	old_make (an_interface: attached like interface)
			-- Initialize `Current' with interface `an_interface'.
		do
			assign_interface (an_interface)
		end

	make
			-- No extra initialization needed.
		do
			set_is_initialized (True)
		end

feature {NONE} -- Implementation

	supported_image_formats: LINEAR [STRING_32]
			-- `Result' contains all supported image formats
			-- on current platform, in the form of their three letter extension.
			-- e.g. PNG, BMP, XPM, ICO
		local
			res: ARRAYED_LIST [STRING_32]
		do
			create res.make (3)
			res.extend ({STRING_32} "BMP")
			res.extend ({STRING_32} "PNG")
			res.extend ({STRING_32} "ICO")
			res.compare_objects
			Result := res
		end

	font_families: LINEAR [STRING_32]
			-- All font families available on current platform.
		local
			res: ARRAYED_LIST [STRING_32]
			all_fonts: ARRAYED_LIST [STRING_32]
		do
			create res.make (20)
			all_fonts := font_enumerator.font_faces
			from
				all_fonts.start
			until
				all_fonts.off
			loop
				res.extend (all_fonts.item)
				all_fonts.forth
			end
			Result := res
		end

	mouse_wheel_scroll_lines: INTEGER
			-- Default number of lines to scroll in response to
			-- a mouse wheel scroll event.
		do
			Result := get_wheel_scroll_lines
		end

	default_pointer_style_width: INTEGER
			-- Default pointer style width.
		local
			l_metrics: WEL_SYSTEM_METRICS
		do
			create l_metrics
			Result := l_metrics.cursor_width
		end

	default_pointer_style_height: INTEGER
			-- Default pointer style height.
		local
			l_metrics: WEL_SYSTEM_METRICS
		do
			create l_metrics
			Result := l_metrics.cursor_height
		end

	has_printer: BOOLEAN
			-- Is a default printer available?
			-- `Result' is `True' if at least one printer is installed.
		local
			default_printer: WEL_DEFAULT_PRINTER_DC
		do
			create default_printer.make
			Result := default_printer.exists
		end

	Font_enumerator: EV_WEL_FONT_ENUMERATOR_IMP
			-- Enumerate Installed fonts
		once
			create Result
		end

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




end -- class EV_ENVIRONMENT_IMP










