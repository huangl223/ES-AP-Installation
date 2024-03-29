note
	description: "Set of static routines belonging to System.IntPtr"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2008-12-29 20:27:11 +0000 (Mon, 29 Dec 2008) $"
	revision: "$Revision: 76420 $"
	external_name: "System.IntPtr"
	assembly: "mscorlib"

frozen expanded external class
	DOTNET_POINTER

create {NONE}
	default_create

feature -- Statics

	frozen get_size: INTEGER
		external
			"IL static signature (): System.Int32 use System.IntPtr"
		alias
			"get_Size"
		end

	frozen from_integer (value: INTEGER): POINTER
		external
			"IL static signature (System.Int32): System.IntPtr use System.IntPtr"
		alias
			"op_Explicit"
		end

	frozen from_integer_64 (value: INTEGER_64): POINTER
		external
			"IL static signature (System.Int64): System.IntPtr use System.IntPtr"
		alias
			"op_Explicit"
		end

note
	library:	"EiffelBase: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class DOTNET_POINTER
