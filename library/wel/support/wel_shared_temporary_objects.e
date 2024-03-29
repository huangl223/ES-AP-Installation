note
	description: "[
		Objects that provide access to a set of shared objects that may be used on a temporary
		basis to increase performance. These objects should only be used in the case where an
		object is required as an intermediary step for passing to a routine, with no further reference
		being kept to the object. By retrieving one of the objects from his class and using it temporarily,
		it prevents memory allocation through the creation of new objects. This can improve performace in
		systems where such access is performed many times in a short space of time.
			]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2011-10-04 19:56:44 +0000 (Tue, 04 Oct 2011) $"
	revision: "$Revision: 87395 $"

class
	WEL_SHARED_TEMPORARY_OBJECTS

feature -- Access

	wel_rect: WEL_RECT
			-- Once access to an object of type WEL_RECT
		once
			create Result.make (0, 0, 0, 0)
		end

	wel_string: WEL_STRING
			-- Once access to an object of type WEL_STRING
		once
			create Result.make_empty (256)
		end

	wel_string_restricted (characters: INTEGER): WEL_STRING
			-- Return shared `wel_string' as `Result' if `characters'
			-- is less than `maximum_buffered_string_size', otherwise return a
			-- new WEL_STRING object. This is used to prevent huge strings
			-- from being kept within a system.
		do
			if characters < maximum_buffered_string_size then
				Result := wel_string
				Result.set_count (characters)
			else
				create Result.make_empty (characters)
			end
		end

	wel_string_from_string (s: READABLE_STRING_GENERAL): WEL_STRING
			-- Return a shared wel string set to `s' if
			-- `s.count' < `maximum_buffered_string_size', otherwise
			-- return a new WEL_STRING object set to `s'.
		require
			s_not_void: s /= Void
		do
			if s.count < maximum_buffered_string_size then
				Result := wel_string
				Result.set_string (s)
			else
				create Result.make (s)
			end
		end

	wel_string_from_string_with_newline_conversion (s: READABLE_STRING_GENERAL): WEL_STRING
			-- Return a shared wel string set to `s' if
			-- `s.count' < `maximum_buffered_string_size', otherwise
			-- return a new WEL_STRING object set to `s'.
			-- Make sure all lone '%N' characters are prepended with a carriage return '%R'.
		require
			s_not_void: s /= Void
		do
			if s.count < maximum_buffered_string_size then
				Result := wel_string
				Result.set_string_with_newline_conversion (s)
			else
				create Result.make_with_newline_conversion (s)
			end
		end

	maximum_buffered_string_size: INTEGER = 10000;
		-- Maximum size of string permitting a shared WEL_STRING object to
		-- be returned by `wel_string_restricted'.

note
	copyright:	"Copyright (c) 1984-2011, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end
