note
	description: "[
					Helper functions of file name.
																	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2013-01-07 22:30:41 +0000 (Mon, 07 Jan 2013) $"
	revision: "$Revision: 90426 $"

class
	WEL_FILE_NAME_HELPER

feature -- Access

	short_path_name (a_file_name: READABLE_STRING_GENERAL): STRING_32
			-- Short path name of `a_file_name'
			-- File/directory must exists before convert to short name
		require
			a_file_name_attached: a_file_name /= Void
		local
			l_wel_string, l_wel_string_result: WEL_STRING
			l_api_return_value: INTEGER
		do
			create l_wel_string.make (a_file_name)
			create l_wel_string_result.make_empty (Max_path_length)

				-- Although this API's input and output string buffer can be same pointer
				-- But we must make sure the result output string is long enough, otherwise, it will crash (in finalized mode)
			l_api_return_value := c_win_get_short_path_name (l_wel_string.item, l_wel_string_result.item, Max_path_length);
			if l_api_return_value > 0 and l_api_return_value < Max_path_length then
				Result := l_wel_string_result.string
			else
					-- Error
				create Result.make_from_string_general (a_file_name)
			end
		end

feature {NONE} -- Implementation

	Max_path_length: INTEGER = 1024
			-- Maximum path length (in characters)
			--| Windows limit

	c_win_get_short_path_name (a_long_path: POINTER; a_short_path: POINTER; a_string_length: INTEGER): INTEGER
			-- Result 0 means failed.
			-- Result value is the length of the string that is copied, not including the terminating null character.
		external
			"C inline use <windows.h>"
		alias
			"[
				EIF_NATURAL_32 l_result;
				
				l_result = GetShortPathName ((LPCTSTR) $a_long_path, (LPTSTR) $a_short_path, (DWORD) $a_string_length);
				
				return l_result;
			]"
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
