note
	description: "Process creation flags."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2009-01-14 20:15:44 +0000 (Wed, 14 Jan 2009) $"
	revision: "$Revision: 76691 $"

class
	WEL_STARTUP_CONSTANTS

feature -- Access

	Startf_use_show_window: INTEGER
			-- Attribute `show_command' from WEL_STARTUP_INFO is meaningful
		external
			"C [macro <winbase.h>]"
		alias
			"STARTF_USESHOWWINDOW"
		end

	Startf_use_position: INTEGER
			-- Attributes `x_offset' and `y_offset' from WEL_STARTUP_INFO are meaningful
		external
			"C [macro <winbase.h>]"
		alias
			"STARTF_USEPOSITION"
		end

	Startf_use_size: INTEGER
			-- Attributes `width' and `height' from WEL_STARTUP_INFO are meaningful
		external
			"C [macro <winbase.h>]"
		alias
			"STARTF_USESIZE"
		end

	Startf_use_count_chars: INTEGER
			-- Attributes `x_character_count' and `y_character_count' from WEL_STARTUP_INFO are meaningful
		external
			"C [macro <winbase.h>]"
		alias
			"STARTF_USECOUNTCHARS"
		end

	Startf_use_fill_attributes: INTEGER
			-- Attribute `fill_attributes' from WEL_STARTUP_INFO is meaningful
		external
			"C [macro <winbase.h>]"
		alias
			"STARTF_USEFILLATTRIBUTE"
		end

	Startf_force_on_feedback: INTEGER
			-- Cursor set to feedback until window intialization is done
		external
			"C [macro <winbase.h>]"
		alias
			"STARTF_FORCEONFEEDBACK"
		end

	Startf_force_off_feedback: INTEGER
			-- Feedback cursor forced off
		external
			"C [macro <winbase.h>]"
		alias
			"STARTF_FORCEOFFFEEDBACK"
		end

	Startf_use_std_handles: INTEGER
			-- Attributes `std_input', `std_output' and `std_error' from WEL_STARTUP_INFO are meaningful
		external
			"C [macro <winbase.h>]"
		alias
			"STARTF_USESTDHANDLES"
		end

	is_valid_startup_flag (a_flag: INTEGER): BOOLEAN
			-- Is `a_flag' a valid startup flag?
		do
			Result := a_flag = Startf_use_show_window or
				a_flag = Startf_use_position or
				a_flag = Startf_use_size or
				a_flag = Startf_use_count_chars or
				a_flag = Startf_use_fill_attributes or
				a_flag = Startf_force_on_feedback or
				a_flag = Startf_force_off_feedback or
				a_flag = Startf_use_std_handles
		end

	is_valid_startup_flags (a_flags: INTEGER): BOOLEAN
			-- Is `a_flags' a valid startup flags combination?
		do
			Result :=  a_flags = (a_flags & (Startf_use_show_window | Startf_use_position |
				Startf_use_size | Startf_use_count_chars | Startf_use_fill_attributes |
				Startf_force_on_feedback | Startf_force_off_feedback | Startf_use_std_handles))
		end

note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 5949 Hollister Ave., Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class WEL_STARTUP_CONSTANTS

