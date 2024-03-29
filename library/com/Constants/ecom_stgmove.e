note

	description: "SToraGe MOVE flags"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date: 2008-12-29 20:27:11 +0000 (Mon, 29 Dec 2008) $";
	revision: "$Revision: 76420 $"

class
	ECOM_STGMOVE

feature -- Access

	Stgmove_move: INTEGER
			-- Carry out the move operation, as expected.
		external
			"C [macro <wtypes.h>]"
		alias
			"STGMOVE_MOVE"
		end

	Stgmove_copy: INTEGER
			-- Carry out the first part of the move operation but do
			-- not remove the original element.
		external
			"C [macro <wtypes.h>]"
		alias
			"STGMOVE_COPY"
		end

	is_valid_stgmove (stgmove: INTEGER): BOOLEAN
			-- Is `stgmove' a valid storage move flag?
		do
			Result := stgmove = Stgmove_move or
						stgmove = Stgmove_copy
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




end -- class EOLE_STGMOVE

