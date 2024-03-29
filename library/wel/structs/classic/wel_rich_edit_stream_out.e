note
	description: "Defines the general notions of a stream out for the rich %
		%edit control."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2009-02-24 23:44:31 +0000 (Tue, 24 Feb 2009) $"
	revision: "$Revision: 77298 $"

deferred class
	WEL_RICH_EDIT_STREAM_OUT

inherit
	WEL_RICH_EDIT_STREAM
		redefine
			make
		end

feature {NONE} -- Initialization

	make
			-- Initialize the C variables.
		do
			Precursor {WEL_RICH_EDIT_STREAM}
			cwel_set_editstream_out_procedure_address ($internal_callback)
			cwel_editstream_set_pfncallback_out (item)
		end

feature -- Access

	buffer: detachable MANAGED_POINTER
			-- Buffer to set in `read_buffer'.

feature -- Basic operations

	write_buffer
			-- Write `buffer'.
		require
			buffer_not_void: buffer /= Void
		deferred
		end

feature {NONE} -- Implementation

	internal_callback (a_buffer: POINTER; a_length: INTEGER): INTEGER
			-- `buffer' contains `length' characters.
		local
			l_buffer: like buffer
		do
			l_buffer := buffer
			if l_buffer = Void then
				create l_buffer.share_from_pointer (a_buffer, a_length)
				buffer := l_buffer
			else
				l_buffer.set_from_pointer (a_buffer, a_length)
			end
			stream_result := 0
			write_buffer
			Result := stream_result
		end

feature {NONE} -- Externals

	cwel_editstream_set_pfncallback_out (ptr: POINTER)
		external
			"C [macro %"estream.h%"]"
		end

	cwel_set_editstream_out_procedure_address (address: POINTER)
		external
			"C [macro %"estream.h%"]"
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




end -- class WEL_RICH_EDIT_STREAM_OUT

