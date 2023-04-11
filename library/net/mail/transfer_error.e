note
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date: 2009-02-24 23:44:31 +0000 (Tue, 24 Feb 2009) $"
	revision: "$Revision: 77298 $"

class
	TRANSFER_ERROR

feature -- Access

	transfer_error_message: detachable STRING

feature -- Status report

	transfer_error: BOOLEAN
		-- Is transfer error?


feature -- Status setting

	enable_transfer_error
		do
			transfer_error:= True
		end

	disable_transfer_error
		do
			transfer_error:= False
		end

	set_transfer_error_message (s: STRING)
		do
			transfer_error_message:= s
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




end -- class TRANSFER_ERROR

