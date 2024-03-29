note
	description: "[
		Operating system failure
		]"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	library: "Free implementation of ELKS library"
	copyright: "Copyright (c) 1986-2006, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date: 2019-02-02 07:49:15 +0000 (Sat, 02 Feb 2019) $"
	revision: "$Revision: 102762 $"

class
	OPERATING_SYSTEM_SIGNAL_FAILURE

inherit
	OPERATING_SYSTEM_EXCEPTION
		rename
			get_base_exception as local_get_base_exception,
			set_source as local_set_source,
			source as local_source,
			stack_trace as local_stack_trace
		end

	DOTNET_EXCEPTION_WRAPPER
		undefine
			default_create,
			out
		end

create
	default_create

create
	{EXCEPTION_MANAGER}make_dotnet_exception

feature -- Access

	frozen code: INTEGER
			-- Exception code
		do
			Result := {EXCEP_CONST}.signal_exception
		end

	signal_code: INTEGER
			-- Signal code, not implemented.

	tag: IMMUTABLE_STRING_32
			-- <Precursor>
		once
			create Result.make_from_string_8 ("Operating system signal.")
		end

feature {EXCEPTION_MANAGER} -- Status setting

	set_signal_code (a_code: like signal_code)
			-- Set `signal_code' with `a_code'
		do
			signal_code := a_code
		end

note
	library:   "EiffelBase: Library of reusable components for Eiffel."
	copyright: "Copyright (c) 1984-2019, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
