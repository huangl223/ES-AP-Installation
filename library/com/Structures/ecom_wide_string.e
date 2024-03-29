note
	description: "wrapping of LPWSTR"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2008-12-29 20:27:11 +0000 (Mon, 29 Dec 2008) $"
	revision: "$Revision: 76420 $"

class
	ECOM_WIDE_STRING

obsolete
	"This class is obsolete, use WEL_STRING instead"

inherit
	DISPOSABLE

create
	make_from_string,
	make_from_pointer

feature {NONE} -- Initialization

	make_from_string (string: STRING)
			-- Create wide string from `string'
		require
			nonvoid_string: string /= Void
		local
			l_string: C_STRING
		do
			create l_string.make (string)
			item := ccom_create_from_string (l_string.item)
			shared := False
		ensure
			non_default_item: exists
			not_shared: not shared
		end

	make_from_pointer (a_wide_string: POINTER)
			-- Creation procedure
			-- Set `item' to `a_wide_string'
		require
			valid_pointer: a_wide_string /= default_pointer
		do
			item := a_wide_string
			shared := True
		ensure
			valid_item: item = a_wide_string
			shared: shared
		end

feature -- Accsess

	item: POINTER
			-- Pointer to wide string

	shared: BOOLEAN
				-- Is `item' shared by another object?
			-- If False (by default), `item' will
			-- be destroyed by `destroy_item'.
			-- If True, `item' will not be destroyed.

	exists: BOOLEAN
			-- Does the `item' exist?
		do
			Result := item /= default_pointer
		ensure
			Result = (item /= default_pointer)
		end

feature -- Basic Operations

	to_string: STRING
			-- Convert wide string to string
		do
			Result := ccom_wide_str_to_string (item)
		ensure
			nonvoid_result: Result /= Void
		end

	set_shared
			-- Set `shared' to True.
		do
			shared := True
		ensure
			shared: shared
		end

	set_unshared
			-- Set `shared' to False.
		do
			shared := False
		ensure
			not_shared: not shared
		end

feature {NONE} -- Implementation

	dispose
			-- Ensure `item' is destroyed when
			-- garbage collected by calling `destroy_item'
		do
			if not shared then
				destroy_item
			end
		end

	destroy_item
			-- Free `item'
		do
			if item /= default_pointer then
				c_free (item)
				item := default_pointer
			end
		end

feature {NONE} -- Externals

	ccom_create_from_string (str: POINTER): POINTER
		external
			"C (char *): EIF_POINTER | %"E_wide_string.h%""
		end


	ccom_wide_str_to_string (a_wstring: POINTER): STRING
		external
			"C (WCHAR *): EIF_REFERENCE | %"E_wide_string.h%""
		end

	c_calloc (a_num, a_size: INTEGER): POINTER
			-- C calloc
		external
			"C (size_t, size_t): EIF_POINTER | <malloc.h>"
		alias
			"calloc"
		end

	c_free (ptr: POINTER)
			-- C free
		external
			"C (void *) | <malloc.h>"
		alias
			"free"
		end

	c_memcpy (destination, source: POINTER; count: INTEGER)
			-- C memcpy
		external
			"C (void *, void *, size_t) | <memory.h>"
		alias
			"memcpy"
		end

	c_enomem
			-- Eiffel run-time function to raise an
			-- "Out of memory" exception.
		external
			"C | %"eif_except.h%""
		alias
			"enomem"
		end

invariant
	exists: exists

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




end -- class ECOM_WIDE_STRING

