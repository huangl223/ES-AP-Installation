note
	description: "TrackPopupMenu (TPM) constants."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2011-10-03 23:26:17 +0000 (Mon, 03 Oct 2011) $"
	revision: "$Revision: 87385 $"

class
	WEL_TPM_CONSTANTS

feature -- Access

	Tpm_leftbutton: INTEGER
		external
			"C [macro %"wel.h%"]"
		alias
			"TPM_LEFTBUTTON"
		end

	Tpm_rightbutton: INTEGER
		external
			"C [macro %"wel.h%"]"
		alias
			"TPM_RIGHTBUTTON"
		end

	Tpm_leftalign: INTEGER
		external
			"C [macro %"wel.h%"]"
		alias
			"TPM_LEFTALIGN"
		end

	Tpm_centeralign: INTEGER
		external
			"C [macro %"wel.h%"]"
		alias
			"TPM_CENTERALIGN"
		end

	Tpm_rightalign: INTEGER
		external
			"C [macro %"wel.h%"]"
		alias
			"TPM_RIGHTALIGN"
		end

	Tpm_bottomalign: INTEGER
		external
			"C [macro %"wel.h%"]"
		alias
			"TPM_BOTTOMALIGN"
		end

	Tpm_topalign: INTEGER
		external
			"C [macro %"wel.h%"]"
		alias
			"TPM_TOPALIGN"
		end

	Tpm_vcenteralign: INTEGER
		external
			"C [macro %"wel.h%"]"
		alias
			"TPM_VCENTERALIGN"
		end

	tpm_returncmd: INTEGER
		external
			"C [macro %"wel.h%"]"
		alias
			"TPM_RETURNCMD"
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




end -- class WEL_TPM_CONSTANTS

