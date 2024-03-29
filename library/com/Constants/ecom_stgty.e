note

	description: "SToraGe TYpe flags"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date: 2008-12-29 20:27:11 +0000 (Mon, 29 Dec 2008) $";
	revision: "$Revision: 76420 $"

class
	ECOM_STGTY

feature -- Access

	Stgty_storage: INTEGER
			-- Storage object
		external
			"C [macro <objidl.h>]"
		alias
			"STGTY_STORAGE"
		end
		
	Stgty_stream: INTEGER
			-- Stream object
		external
			"C [macro <objidl.h>]"
		alias
			"STGTY_STREAM"
		end
		
	Stgty_lockbytes: INTEGER
			-- Byte array object
		external
			"C [macro <objidl.h>]"
		alias
			"STGTY_LOCKBYTES"
		end

	is_valid_stgty (stgty: INTEGER): BOOLEAN
			-- Is `stgty' a valid storage type flag?
		do
			Result := stgty = Stgty_storage or
						stgty = Stgty_stream or
						stgty = Stgty_lockbytes
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




end -- class EOLE_STGTY

