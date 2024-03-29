note

	description: "Stat flags, used in feature `stat' of EOLE_STREAM"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date: 2008-12-29 20:27:11 +0000 (Mon, 29 Dec 2008) $";
	revision: "$Revision: 76420 $"

class
	ECOM_STAT_FLAGS

feature -- Access

	Statflag_default: INTEGER
			-- Indicate that this is not used for property
		external
			"C [macro <wtypes.h>]"
		alias
			"STATFLAG_DEFAULT"
		end

	Statflag_noname: INTEGER
			-- Indicate that this is not used for property
		external
			"C [macro <wtypes.h>]"
		alias
			"STATFLAG_NONAME"
		end
		
	is_valid_stat_flag (flag: INTEGER): BOOLEAN
			-- Is `flag' a valid stat flag?
		do
			Result := flag = Statflag_default or
						flag = Statflag_noname
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




end -- class EOLE_STAT_FLAGS

