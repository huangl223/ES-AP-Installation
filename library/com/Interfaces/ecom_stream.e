﻿note
	description: "Encapsulation of standard implementation of IStream interface."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2017-04-13 16:48:42 +0000 (Thu, 13 Apr 2017) $"
	revision: "$Revision: 100178 $"

class
	ECOM_STREAM

inherit
	ECOM_QUERIABLE
		redefine
			dispose
		end

	ECOM_STAT_FLAGS

	ECOM_STREAM_SEEK

	ECOM_LOCK_TYPES

	EXCEPTION_MANAGER_FACTORY

create
	make_from_other,
	make_from_pointer

feature {NONE} -- Initialization

	make_from_pointer (cpp_obj: POINTER)
			-- Make from pointer
		do
			initializer := ccom_create_c_istream (cpp_obj)
			item := ccom_item (initializer)
		end

feature -- Access

	end_of_stream: BOOLEAN
			-- Is current seek pointer at end of stream?
			-- Valid only after `read' ,`update_end_of_stream', `start', or `finish'.

	last_character: CHARACTER
			-- last read CHARACTER

	last_integer: INTEGER
			-- last read INTEGER

	last_real: REAL
			-- last read REAL

	last_boolean: BOOLEAN
			-- last read BOOLEAN

	last_string: STRING
			-- last read STRING

	description (stat_flag: INTEGER): ECOM_STATSTG
			-- STATSTG structure
			-- See class ECOM_STAT_FLAGS for `stat_flag' values.
		require
			valid_stat_flag: is_valid_stat_flag (stat_flag)
		local
			ptr: POINTER
		do
			ptr := ccom_stat (initializer, stat_flag)
			create Result.make (ptr)
		ensure
			Result /= Void
		end

	name: READABLE_STRING_32
			-- Name
		do
			Result := description (Statflag_default).name
		end

	size: ECOM_ULARGE_INTEGER
			-- Size in bytes
		do
			Result := description (Statflag_noname).size
		end

	modification_time: WEL_FILE_TIME
			-- Modification time
		do
			Result := description (Statflag_noname).modification_time
		end

	creation_time: WEL_FILE_TIME
			-- Creation time
		do
			Result := description (Statflag_noname).creation_time
		end

	access_time: WEL_FILE_TIME
			-- Access time
		do
			Result := description (Statflag_noname).access_time
		end

	locks_supported: INTEGER
			-- Types of region locking supported by stream
		do
			Result := description (Statflag_noname).locks_supported
		end

feature -- Basic Operations

	update_end_of_stream
			-- Update value of `end_of_stream'.
		do
			end_of_stream := ccom_end_of_stream_reached (initializer) = 1
		end

	read (buffer: POINTER; bytes: INTEGER)
			-- Reads `bytes' number of bytes from stream
			-- into `buffer' starting at current seek pointer.
		require
			valid_buffer: buffer /= default_pointer
			valid_bytes: bytes >= 0
		local
			tried: BOOLEAN
		do
			if not tried then
				ccom_read (initializer, buffer, bytes)
				end_of_stream := False
			end
		rescue
			if attached {COM_FAILURE} exception_manager.last_exception as com_failure then
				if com_failure.hresult_code = {ECOM_EXCEPTION_CODES}.E_end_of_stream then
					end_of_stream := True
					tried := True
					retry
				end
			end
		end

	read_character
			-- Read character from stream.
		local
			tried: BOOLEAN
		do
			if not tried then
				last_character := ccom_read_character (initializer)
				end_of_stream := False
			end
		rescue
			if attached {COM_FAILURE} exception_manager.last_exception as com_failure then
				if com_failure.hresult_code = {ECOM_EXCEPTION_CODES}.E_end_of_stream then
					end_of_stream := True
					tried := True
					retry
				end
			end
		end

	read_integer
			-- Read integer from stream.
		local
			tried: BOOLEAN
		do
			if not tried then
				last_integer := ccom_read_integer (initializer)
				end_of_stream := False
			end
		rescue
			if attached {COM_FAILURE} exception_manager.last_exception as com_failure then
				if com_failure.hresult_code = {ECOM_EXCEPTION_CODES}.E_end_of_stream then
					end_of_stream := True
					tried := True
					retry
				end
			end
		end

	read_real
			-- Read real from stream.
		local
			tried: BOOLEAN
		do
			if not tried then
				last_real := ccom_read_real (initializer)
				end_of_stream := False
			end
		rescue
			if attached {COM_FAILURE} exception_manager.last_exception as com_failure then
				if com_failure.hresult_code = {ECOM_EXCEPTION_CODES}.E_end_of_stream then
					end_of_stream := True
					tried := True
					retry
				end
			end
		end

	read_boolean
			-- Read boolean from stream.
		local
			tried: BOOLEAN
		do
			if not tried then
				last_boolean := ccom_read_boolean (initializer)
				end_of_stream := False
			end
		rescue
			if attached {COM_FAILURE} exception_manager.last_exception as com_failure then
				if com_failure.hresult_code = {ECOM_EXCEPTION_CODES}.E_end_of_stream then
					end_of_stream := True
					tried := True
					retry
				end
			end
		end

	read_string
			-- Read string from stream.
		local
			tried: BOOLEAN
		do
			if not tried then
				last_string := ccom_read_string (initializer)
				end_of_stream := False
			end
		rescue
			if attached {COM_FAILURE} exception_manager.last_exception as com_failure then
				if com_failure.hresult_code = {ECOM_EXCEPTION_CODES}.E_end_of_stream then
					end_of_stream := True
					tried := True
					retry
				end
			end
		end

	write (buffer: POINTER; bytes: INTEGER)
			-- Writes `bytes' number of bytes into stream
			-- starting at current seek pointer.
		require
			valid_buffer: buffer /= default_pointer
		do
			ccom_write (initializer, buffer, bytes)
		end

	write_character (character: CHARACTER)
			-- Write `character' into stream.

		do
			ccom_write_character (initializer, character)
		end

	write_integer (integer: INTEGER)
			-- Write `integer' into stream.

		do
			ccom_write_integer (initializer, integer)
		end

	write_real (real: REAL)
			-- Write `real' into stream.
		do
			ccom_write_real (initializer, real)
		end

	write_boolean (boolean: BOOLEAN)
			-- Write `boolean' into stream.

		do
			ccom_write_boolean (initializer, boolean)
		end

	write_string (string: READABLE_STRING_GENERAL)
			-- Write `string' into stream.
		require
			string /= Void
		local
			wel_string: WEL_STRING
		do
			create wel_string.make (string)
			ccom_write_string (initializer, wel_string.item)
		end

	seek (displacement: ECOM_LARGE_INTEGER; origin: INTEGER)
			-- Move seek pointer by `displacement'
			-- relative to `origin'.
			-- See class ECOM_STREAM_SEEK for `origin' values.
		require
			non_void_displacement: displacement /= Void
			valid_displacement: displacement.exists
			valid_seek_origin: is_valid_seek(origin)
		do
			ccom_seek (initializer, displacement.item, origin)
		end

	start
			-- Set seek pointer to beginning of stream.
		local
			large_integer: ECOM_LARGE_INTEGER
		do
			create large_integer.make_from_integer (0)
			seek (large_integer, Stream_seek_set)
			end_of_stream := False
		ensure
			not_end: not end_of_stream
		end

	finish
			-- Set seek pointer to end of stream.
		local
			large_integer: ECOM_LARGE_INTEGER
		do
			create large_integer.make_from_integer (0)
			seek (large_integer, Stream_seek_end)
			end_of_stream := True
		ensure
			at_end: end_of_stream
		end

	set_size (new_size: ECOM_ULARGE_INTEGER)
			-- Change size of stream to `new_size'.
		require
			valid_new_size: new_size /= Void and then
				new_size.exists;
		do
			ccom_set_size (initializer, new_size.item)
		ensure
			size = new_size
		end

	copy_to (destination: ECOM_STREAM; bytes: ECOM_ULARGE_INTEGER)
			-- Copy `bytes' number of bytes from current seek pointer
			-- in stream to current seek pointer in
			-- `destination'.
		require
			valid_destination: destination /= Void
					and then destination.exists
			valid_bytes_number: bytes /= Void and then
					bytes.exists
		do
			ccom_copy_to (initializer, destination.item, bytes.item)
		end

	lock_region (offset, count: ECOM_ULARGE_INTEGER; lock: INTEGER)
			-- Restricts access to range of bytes defined by
			-- `offset' and `count'.
		require
			valid_offset: offset /= Void and then offset.exists
			valid_count: count /= Void and then count.exists
			valid_lock: is_valid_lock (lock)
		do
			ccom_lock_region (initializer, offset.item, count.item, lock)
		end

	unlock_region (offset, count: ECOM_ULARGE_INTEGER; lock: INTEGER)
			-- Removes access restriction to range of bytes defined by
			-- `offset' and `count'.
		require
			valid_offset: offset /= Void and then offset.exists
			valid_count: count /= Void and then count.exists
			valid_lock: is_valid_lock (lock)
		do
			ccom_unlock_region (initializer, offset.item, count.item, lock)
		end

	clone_stream: ECOM_STREAM
			-- New stream referencing
			-- the same bytes as Current
			-- Seek pointer is also cloned
		do
			create Result.make_from_pointer(ccom_clone(initializer))
		ensure
			clone_created: Result /= Void and then Result.exists
		end

feature {NONE} -- Implementation

	delete_wrapper
			-- Close root compound file.
		do
			ccom_delete_c_stream (initializer)
		end

	dispose
		do
			Precursor {ECOM_QUERIABLE}
		end

feature {NONE} -- Externals

	ccom_create_c_istream(a_pointer: POINTER): POINTER
		external
			"C++ [new E_IStream %"E_IStream.h%"](IStream *)"
		end

	ccom_delete_c_stream (cpp_obj: POINTER)
		external
			"C++ [delete E_IStream %"E_IStream.h%"]()"
		end

	ccom_end_of_stream_reached (cpp_obj: POINTER): INTEGER
		external
			"C++ [E_IStream %"E_IStream.h%"](): EIF_INTEGER"
		end

	ccom_read (cpp_obj: POINTER; buffer: POINTER; byte_num: INTEGER)
		external
			"C++ [E_IStream %"E_IStream.h%"] (void *, ULONG)"
		end

	ccom_read_character (cpp_obj: POINTER): CHARACTER
		external
			"C++ [E_IStream %"E_IStream.h%"] (): EIF_CHARACTER"
		end

	ccom_read_integer (cpp_obj: POINTER): INTEGER
		external
			"C++ [E_IStream %"E_IStream.h%"] (): EIF_INTEGER"
		end

	ccom_read_real (cpp_obj: POINTER): REAL
		external
			"C++ [E_IStream %"E_IStream.h%"] (): EIF_REAL"
		end

	ccom_read_boolean (cpp_obj: POINTER): BOOLEAN
		external
			"C++ [E_IStream %"E_IStream.h%"] (): EIF_BOOLEAN"
		end

	ccom_read_string (cpp_obj: POINTER): STRING
		external
			"C++ [E_IStream %"E_IStream.h%"] (): EIF_REFERENCE"
		end

	ccom_write (cpp_obj: POINTER; buffer: POINTER; byte_num: INTEGER)
		external
			"C++ [E_IStream %"E_IStream.h%"] (void *, ULONG)"
		end

	ccom_write_character (cpp_obj: POINTER; character: CHARACTER)
		external
			"C++ [E_IStream %"E_IStream.h%"] (EIF_CHARACTER)"
		end

	ccom_write_integer (cpp_obj: POINTER; integer: INTEGER)
		external
			"C++ [E_IStream %"E_IStream.h%"] (EIF_INTEGER)"
		end

	ccom_write_real (cpp_obj: POINTER; real: REAL)
		external
			"C++ [E_IStream %"E_IStream.h%"] (EIF_REAL)"
		end

	ccom_write_boolean (cpp_obj: POINTER; boolean: BOOLEAN)
		external
			"C++ [E_IStream %"E_IStream.h%"] (EIF_BOOLEAN)"
		end

	ccom_write_string (cpp_obj: POINTER; string: POINTER)
		external
			"C++ [E_IStream %"E_IStream.h%"] (EIF_POINTER)"
		end

	ccom_seek (cpp_obj: POINTER; displacement: POINTER; origin: INTEGER)
		external
			"C++ [E_IStream %"E_IStream.h%"] (EIF_POINTER, EIF_INTEGER)"
		end

	ccom_set_size (cpp_obj: POINTER; new_size: POINTER)
		external
			"C++ [E_IStream %"E_IStream.h%"] (EIF_POINTER)"
		end

	ccom_copy_to (cpp_obj: POINTER; destination: POINTER; cb: POINTER)
		external
			"C++ [E_IStream %"E_IStream.h%"] (IStream *, EIF_POINTER)"
		end

	ccom_lock_region (cpp_obj: POINTER; offset, cb: POINTER;
					lock_type: INTEGER)
		external
			"C++ [E_IStream %"E_IStream.h%"] (EIF_POINTER, EIF_POINTER, EIF_INTEGER)"
		end

	ccom_unlock_region (cpp_obj: POINTER; offset, cb: POINTER;
					lock_type: INTEGER)
		external
			"C++ [E_IStream %"E_IStream.h%"] (EIF_POINTER, EIF_POINTER, EIF_INTEGER)"
		end

	ccom_stat (cpp_obj: POINTER; flag: INTEGER): POINTER
		external
			"C++ [E_IStream %"E_IStream.h%"] (DWORD): EIF_POINTER"
		end

	ccom_clone (cpp_obj: POINTER): POINTER
		external
			"C++ [E_IStream %"E_IStream.h%"] (): EIF_POINTER"
		end

	ccom_item (cpp_obj: POINTER): POINTER
		external
			"C++ [E_IStream %"E_IStream.h%"] (): EIF_POINTER"
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

end
