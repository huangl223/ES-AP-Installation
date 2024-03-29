note
	description: "Defines the attributes of a palette."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2009-01-25 02:01:47 +0000 (Sun, 25 Jan 2009) $"
	revision: "$Revision: 76831 $"

class
	WEL_LOG_PALETTE

inherit
	WEL_STRUCTURE
		rename
			make as structure_make
		end

create
	make,
	make_by_pointer

feature {NONE} -- Initialization

	make (a_version, a_num_entries: INTEGER)
			-- Make a logical palette version `a_version'
			-- with `a_num_entries' entries
		do
			private_num_entries := a_num_entries
			structure_make
			set_version (a_version)
			set_num_entries (a_num_entries)
		ensure
			version_set: version = a_version
			num_entries_set: num_entries = a_num_entries
		end

feature -- Access

	version: INTEGER
			-- Windows version number for the structure
			-- Must be 768 for Windows 3.0 and later
		do
			Result := cwel_log_palette_get_version (item)
		end

	num_entries: INTEGER
			-- Number of palette color entries
		do
			Result := cwel_log_palette_get_num_entries (item)
		end

	pal_entry (index: INTEGER): WEL_PALETTE_ENTRY
			-- Palette entry at `index'
		require
			index_inf: index >= 0
			index_sup: index < num_entries
		do
			create Result.make_by_pointer (
				cwel_log_palette_get_pal_entry (item, index))
		ensure
			result_not_void: Result /= Void
		end

feature -- Element change

	set_version (a_version: INTEGER)
			-- Set `version' with `a_version'
		do
			cwel_log_palette_set_version (item, a_version)
		ensure
			version_set: version = a_version
		end

	set_num_entries (a_num_entries: INTEGER)
			-- Set `num_entries' with `a_num_entries'
		do
			cwel_log_palette_set_num_entries (item, a_num_entries)
		ensure
			num_entries_set: num_entries = a_num_entries
		end

	set_pal_entry (index: INTEGER; a_pal_entry: WEL_PALETTE_ENTRY)
			-- Set `a_pal_entry' at `index'
		require
			a_pal_entry_not_void: a_pal_entry /= Void
			a_pal_entry_exists: a_pal_entry.exists
		do
			cwel_log_palette_set_pal_entry_red (item, index,
				a_pal_entry.red)
			cwel_log_palette_set_pal_entry_green (item, index,
				a_pal_entry.green)
			cwel_log_palette_set_pal_entry_blue (item, index,
				a_pal_entry.blue)
			cwel_log_palette_set_pal_entry_flags (item, index,
				a_pal_entry.flags)
		end

feature -- Measurement

	structure_size: INTEGER
			-- Size to allocate (in bytes)
		do
			Result := c_size_of_log_palette +
				(private_num_entries * c_size_of_pal_entry)
		end

feature {NONE} -- Implementation

	private_num_entries: INTEGER
			-- Number of entries used to allocate the memory

feature {NONE} -- Externals

	c_size_of_log_palette: INTEGER
		external
			"C [macro <logpal.h>]"
		alias
			"sizeof (LOGPALETTE)"
		end

	c_size_of_pal_entry: INTEGER
		external
			"C [macro <logpal.h>]"
		alias
			"sizeof (PALETTEENTRY)"
		end

	cwel_log_palette_set_version (ptr: POINTER; value: INTEGER)
		external
			"C [macro <logpal.h>]"
		end

	cwel_log_palette_set_num_entries (ptr: POINTER; value: INTEGER)
		external
			"C [macro <logpal.h>]"
		end

	cwel_log_palette_set_pal_entry_red (ptr: POINTER; index,
			value: INTEGER)
		external
			"C [macro <logpal.h>]"
		end

	cwel_log_palette_set_pal_entry_green (ptr: POINTER; index,
			value: INTEGER)
		external
			"C [macro <logpal.h>]"
		end

	cwel_log_palette_set_pal_entry_blue (ptr: POINTER; index,
			value: INTEGER)
		external
			"C [macro <logpal.h>]"
		end

	cwel_log_palette_set_pal_entry_flags (ptr: POINTER; index,
			value: INTEGER)
		external
			"C [macro <logpal.h>]"
		end

	cwel_log_palette_get_version (ptr: POINTER): INTEGER
		external
			"C [macro <logpal.h>]"
		end

	cwel_log_palette_get_num_entries (ptr: POINTER): INTEGER
		external
			"C [macro <logpal.h>]"
		end

	cwel_log_palette_get_pal_entry (ptr: POINTER; i: INTEGER): POINTER
		external
			"C [macro <logpal.h>]  (LOGPALETTE*, int): EIF_POINTER"
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




end -- class WEL_LOG_PALETTE

