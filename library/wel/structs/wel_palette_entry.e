note
	description: "Specifies the color and usage of an entry in a logical %
		%color palette."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2008-12-29 20:27:11 +0000 (Mon, 29 Dec 2008) $"
	revision: "$Revision: 76420 $"

class
	WEL_PALETTE_ENTRY

inherit
	WEL_STRUCTURE
		rename
			make as structure_make
		end

create
	make,
	make_by_pointer

feature {NONE} -- Initialization

	make (a_red, a_green, a_blue, a_flags: INTEGER)
			-- Make a palette entry with colors
			-- `a_red', `a_green', `a_blue'
			-- For `a_flags', see class WEL_PC_FLAGS_CONSTANTS
		do
			structure_make
			set_red (a_red)
			set_green (a_green)
			set_blue (a_blue)
			set_flags (a_flags)
		ensure
			red_set: red = a_red
			green_set: green = a_green
			blue_set: blue = a_blue
			flags_set: flags = a_flags
		end

feature -- Access

	red: INTEGER
		do
			Result := cwel_palette_entry_get_red (item)
		end

	green: INTEGER
		do
			Result := cwel_palette_entry_get_green (item)
		end

	blue: INTEGER
		do
			Result := cwel_palette_entry_get_blue (item)
		end

	flags: INTEGER
		do
			Result := cwel_palette_entry_get_flags (item)
		end

feature -- Element change

	set_red (a_red: INTEGER)
		do
			cwel_palette_entry_set_red (item, a_red)
		ensure
			red_set: red = a_red
		end

	set_green (a_green: INTEGER)
		do
			cwel_palette_entry_set_green (item, a_green)
		ensure
			green_set: green = a_green
		end

	set_blue (a_blue: INTEGER)
		do
			cwel_palette_entry_set_blue (item, a_blue)
		ensure
			blue_set: blue = a_blue
		end

	set_flags (a_flags: INTEGER)
		do
			cwel_palette_entry_set_flags (item, a_flags)
		ensure
			flags_set: flags = a_flags
		end


feature -- Measurement

	structure_size: INTEGER
			-- Size to allocate (in bytes)
		once
			Result := c_size_of_palette_entry
		end

feature {NONE} -- Externals

	c_size_of_palette_entry: INTEGER
		external
			"C [macro <palentry.h>]"
		alias
			"sizeof (PALETTEENTRY)"
		end

	cwel_palette_entry_set_red (ptr: POINTER; value: INTEGER)
		external
			"C [macro <palentry.h>]"
		end

	cwel_palette_entry_set_green (ptr: POINTER; value: INTEGER)
		external
			"C [macro <palentry.h>]"
		end

	cwel_palette_entry_set_blue (ptr: POINTER; value: INTEGER)
		external
			"C [macro <palentry.h>]"
		end

	cwel_palette_entry_set_flags (ptr: POINTER; value: INTEGER)
		external
			"C [macro <palentry.h>]"
		end

	cwel_palette_entry_get_red (ptr: POINTER): INTEGER
		external
			"C [macro <palentry.h>]"
		end

	cwel_palette_entry_get_green (ptr: POINTER): INTEGER
		external
			"C [macro <palentry.h>]"
		end

	cwel_palette_entry_get_blue (ptr: POINTER): INTEGER
		external
			"C [macro <palentry.h>]"
		end

	cwel_palette_entry_get_flags (ptr: POINTER): INTEGER
		external
			"C [macro <palentry.h>]"
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
