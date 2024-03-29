note
	description: "IMalloc interface wrapper."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2008-12-29 20:27:11 +0000 (Mon, 29 Dec 2008) $"
	revision: "$Revision: 76420 $"

class
	WEL_IMALLOC

inherit
	WEL_STRUCTURE
		redefine
			make,
			destroy_item
		end

create
	make

feature -- Initialization

	make
			-- Initialize interface.
		do
			cwin_coinitialize
			Precursor {WEL_STRUCTURE}
			cwin_sh_get_malloc (item)
		end

feature -- Access

	allocated_buffer (an_integer: INTEGER): POINTER
			-- Pointer to newly allocated buffer of `an_integer' bytes
			-- `default_pointer' if no enough memory is available
		do
			Result := cwel_imalloc_alloc (item, an_integer)
		end
	
	reallocated_buffer (a_pointer: POINTER; an_integer: INTEGER): POINTER
			-- Pointer to newly allocated buffer of `an_integer' bytes
			-- Allocated buffer contains same information as memory pointed by
			-- `a_pointer' (if `an_integer' is greater than orginal memory block
			-- pointed by `a_pointer' then additional bytes are not initialized).
		require
			was_allocated: allocated (a_pointer)
		do
			Result := cwel_imalloc_realloc (item, a_pointer, an_integer)
		end

	size (a_pointer: POINTER): INTEGER
			-- Size (in bytes) of previously allocated memory block pointed by
			-- `a_pointer'
		require
			was_allocated: allocated (a_pointer)
		do
			Result := cwel_imalloc_get_size (item, a_pointer)
		end
	
	allocated (a_pointer: POINTER): BOOLEAN
			-- Was memory block pointed by `a_pointer' allocated with
			-- `allocated_buffer'?
			-- Default result is `True'.
			-- See `allocated_not_reliable' for validity of result.
		local
			an_integer: INTEGER
		do
			an_integer := cwel_imalloc_did_alloc (item, a_pointer)
			Result := (an_integer = 1 or an_integer = -1)
			allocated_not_reliable := an_integer = -1
		end

	allocated_not_reliable: BOOLEAN
			-- Is `allocated' reliable?
			
feature -- Basic Operations
	
	free_buffer (a_pointer: POINTER)
			-- Free memory block pointed by `a_pointer'.
		require
			was_allocated: allocated (a_pointer)
		do
			cwel_imalloc_free (item, a_pointer)
		end
	
feature {NONE} -- Removal

	destroy_item
			-- Called by the `dispose' routine to
			-- destroy `item' by calling the
			-- corresponding Windows function and
			-- set `item' to `default_pointer'.
		do
			cwel_imalloc_release (item)
			Precursor
		end

feature -- Measurement

	structure_size: INTEGER
			-- Size to allocate (in bytes)
		do
			Result := c_size_of_lpmalloc
		end

feature {NONE}-- Externals

	c_size_of_lpmalloc: INTEGER
		external
			"C [macro %"wel.h%"]"
		alias
			"sizeof (LPMALLOC)"
		end

	cwin_coinitialize
		external
			"C [macro %"wel_imalloc.h%"]"
		alias
			"CoInitialize (NULL)"
		end

	cwin_couninitialize
		external
			"C | %"wel_imalloc.h%""
		alias
			"CoUninitialize"
		end

	cwin_sh_get_malloc (a_pointer: POINTER)
		external
			"C [macro <shlobj.h>] (LPMALLOC*)"
		alias
			"SHGetMalloc"
		end

	cwel_imalloc_alloc (a_pointer: POINTER; an_integer: INTEGER): POINTER
			external
				"C [macro %"wel_imalloc.h%"] (LPMALLOC, ULONG): EIF_POINTER"
			end

	cwel_imalloc_realloc (a_pointer1, a_pointer2: POINTER; an_integer: INTEGER): POINTER
			external
				"C [macro %"wel_imalloc.h%"] (LPMALLOC, void*, ULONG): EIF_POINTER"
			end

	cwel_imalloc_get_size (a_pointer1, a_pointer2: POINTER): INTEGER
			external
				"C [macro %"wel_imalloc.h%"] (LPMALLOC, void*): EIF_INTEGER"
			end
	
	cwel_imalloc_did_alloc (a_pointer1, a_pointer2: POINTER): INTEGER
			external
				"C [macro %"wel_imalloc.h%"] (LPMALLOC, void*): EIF_INTEGER"
			end
	
	cwel_imalloc_free (a_pointer1, a_pointer2: POINTER)
			external
				"C [macro %"wel_imalloc.h%"] (LPMALLOC, void*)"
			end
	
	cwel_imalloc_release (a_pointer: POINTER)
			external
				"C [macro %"wel_imalloc.h%"] (LPMALLOC)"
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
