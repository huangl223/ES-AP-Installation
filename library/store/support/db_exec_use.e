note

	status: "See notice at end of class.";
	Date: "$Date: 2019-08-26 15:54:41 +0000 (Mon, 26 Aug 2019) $"
	Revision: "$Revision: 103422 $"
	Access: execute, immediate, prepare
	Product: EiffelStore
	Database: All_Bases

class DB_EXEC_USE

inherit

	HANDLE_USE

feature -- Status report

	immediate_execution: BOOLEAN
			-- Are requests immediately executed?
			-- (default is `no').
		do
			Result := handle.execution_type.immediate_execution
		end

	is_tracing: BOOLEAN
			-- Is trace option for SQL queries on?
		do
			Result := handle.execution_type.is_tracing
		end

	trace_message (m: READABLE_STRING_GENERAL)
			-- Trace message `m` to destination file.
		require
			is_tracing
		do
			trace_output.put_string ({UTF_CONVERTER}.utf_32_string_to_utf_8_string_8 (m))
			trace_output.put_new_line
		end

	trace_output: FILE
			-- Trace destination file
		do
			Result := handle.execution_type.trace_output
		end

feature -- Status setting

	set_immediate
			-- Set queries to be executed with a
			-- `EXECUTE IMMEDIATE' SQL  statement.
		do
			handle.execution_type.set_immediate
		ensure
			execution_status: immediate_execution
		end

	unset_immediate
			-- Set queries to be executed with a
			-- `PREPARE' followed by a `EXECUTE' SQL statement.
		do
			handle.execution_type.unset_immediate
		ensure
			execution_status: not immediate_execution
		end

	set_trace
			-- Trace queries sent to database server.
		do
			handle.execution_type.set_trace
		ensure
			trace_status: is_tracing
		end

	unset_trace
			-- Do not trace queries sent to database server.
		do
			handle.execution_type.unset_trace
		ensure
			trace_status: not is_tracing
		end

note
	copyright:	"Copyright (c) 1984-2019, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class DB_EXEC_USE
