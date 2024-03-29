note
	description: "Variant constants, use `missing' as value for optional argument when %
				%no value should be specified"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2009-02-17 23:44:41 +0000 (Tue, 17 Feb 2009) $"
	revision: "$Revision: 77187 $"

class
	ECOM_SHARED_VARIANT

inherit
	ECOM_VAR_TYPE
	ECOM_EXCEPTION_CODES
		export
			{NONE} all
		end

feature -- Access

	missing: ECOM_VARIANT
			-- Value representing the default value of a COM optional argument.
			-- Equivalent to an omitted VB argument, or C++ vtMissing, or .NET System.Reflection.Missing.
		once
			create Result.make
			Result.set_error (create {ECOM_HRESULT}.make_from_integer (Disp_e_paramnotfound))
		ensure
			missing_attached: Result /= Void
			definition: is_missing (Result)
		end

feature -- Status report

	is_missing (v: ECOM_VARIANT): BOOLEAN
			-- Does `v' represent a COM optional argument?
		require
			v_attached: v /= Void
		do
			Result := is_error (v.variable_type) and then v.error.item = Disp_e_paramnotfound
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




end -- class ECOM_SHARED_VARIANT

