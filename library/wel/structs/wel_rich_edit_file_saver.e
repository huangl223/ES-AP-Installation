note
	description: "[
		This class allows to save in a file the contents of a
		rich edit control.
		
		Note: Do not use more than one instance of this class at the same
			time. Nested streams are not supported.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2013-05-30 20:53:24 +0000 (Thu, 30 May 2013) $"
	revision: "$Revision: 92652 $"

class
	WEL_RICH_EDIT_FILE_SAVER

inherit
	WEL_RICH_EDIT_STREAM_OUT
		rename
			make as rich_edit_stream_out_make
		redefine
			finish_action
		end

create
	make

feature {NONE} -- Initialization

	make (a_file: RAW_FILE)
			-- Save the contents of the rich edit control
			-- in `a_file'.
		require
			a_file_not_void: a_file /= Void
			a_file_exists: a_file.exists
			a_file_is_open_write: a_file.is_open_write
		do
			file := a_file
			rich_edit_stream_out_make
		ensure
			file_set: file = a_file
		end

feature {NONE} -- Implementation

	file: RAW_FILE
			-- File to save

	write_buffer
			-- Write `a_buffer' in `file'.
		local
			l_buffer: like buffer
		do
			l_buffer := buffer
			check l_buffer_attached: l_buffer /= Void then end
			file.put_managed_pointer (l_buffer, 0, l_buffer.count)
		end

	finish_action
			-- Close `file'.
		do
			file.close
		ensure then
			file_closed: file.is_closed
		end

invariant
	file_not_void: file /= Void
	not_is_unicode_data: not is_unicode_data

note
	copyright:	"Copyright (c) 1984-2013, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
