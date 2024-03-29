﻿note
	description: "Process/Thread iteration"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date: 2017-03-31 13:03:02 +0000 (Fri, 31 Mar 2017) $"
	revision: "$Revision: 100086 $"

class
	WEL_TOOLHELP

inherit
	WEL_PROCESS_TOOLHELP_CONSTANTS

feature -- Access

	process_id_pair_list: detachable LINKED_LIST [WEL_PROCESS_ID_PAIR]
			-- List of process id pairs taken from a system snapshot.
			-- first item of a pair is parent process id, second item of a pair is process id.
		local
			ptr: POINTER
			entry: POINTER
			succ: BOOLEAN
			pid1, pid2: INTEGER
		do
			cwin_create_toolhelp32_snapshot (cwin_th32cs_snapprocess, 0, $ptr)
			if ptr /= default_pointer then
				create Result.make
				from
					cwin_process32_first (ptr, $entry, $succ)
				until
					not succ
				loop
					cwin_get_process_id_and_parent_id (entry, $pid1, $pid2)
					Result.extend (create {WEL_PROCESS_ID_PAIR}.make (pid2, pid1))
					cwin_process32_next (ptr, $entry, $succ)
				end
				if entry /= default_pointer then
					cwin_free_pointer (entry)
				end
				cwin_close_handle (ptr)
			end
		end

	process_information: detachable ARRAYED_LIST [WEL_PROCESS_ENTRY_32]
			-- Information about all running processes
		local
			ptr: POINTER
			entry: POINTER
			succ: BOOLEAN
			pid, ppid, thr_count: INTEGER
			pri_base: INTEGER_64
			exe: C_STRING
			exe_p: POINTER
		do
			cwin_create_toolhelp32_snapshot (cwin_th32cs_snapprocess, 0, $ptr)
			if ptr /= default_pointer then
				create Result.make (initial_list_capacity)
				from
					cwin_process32_first (ptr, $entry, $succ)
				until
					not succ
				loop
					read_process_entry (entry, $pid, $ppid, $thr_count, $pri_base, $exe_p)
					create exe.make_by_pointer (exe_p)
					Result.extend (create {WEL_PROCESS_ENTRY_32}.make (pid, ppid, thr_count, pri_base, exe.string))
					cwin_process32_next (ptr, $entry, $succ)
				end
				if entry /= default_pointer then
					cwin_free_pointer (entry)
				end
				cwin_close_handle (ptr)
			end
		end

feature{NONE} -- System snapshot

	cwin_create_toolhelp32_snapshot (flags: INTEGER; prc_id: INTEGER; handle: TYPED_POINTER [POINTER])
			-- Get system information snapshot and store result in `handle'.
			-- After use, call `cwin_close_handle' to close `handle'.
		external
			"C inline use <Tlhelp32.h>"
		alias
			"[
				{
					*$handle = CreateToolhelp32Snapshot($flags, $prc_id);
					if(*$handle == INVALID_HANDLE_VALUE)
					{
						*$handle = 0;
					}
				}
			]"
		end

feature{NONE} -- Process Iteration

	cwin_process32_first (snapshot: POINTER; prc_entry: TYPED_POINTER [POINTER]; succ: TYPED_POINTER [BOOLEAN])
			-- Get information of the first process in `snapshot' and store result in `prc_entry'.
			-- If successed, set `succ' to True, otherwise to False.
			-- This feature will create a POINTER object `prc_entry' if successful,
			-- so, after use, call `cwin_free_pointer' to destroy `prc_entry'.
		external
			"C inline use <Tlhelp32.h>"
		alias
			"[
				{
					PROCESSENTRY32 *pe32;
					pe32 = (PROCESSENTRY32 *)malloc (sizeof (PROCESSENTRY32));
					pe32->dwSize = sizeof( PROCESSENTRY32 );
  					if( Process32First( $snapshot, pe32 ) )
  					{
						*$succ = 1;
						*$prc_entry = (EIF_POINTER)pe32;
 					}
 					else
 					{
 						*$prc_entry = 0;
 						*$succ = 0;
 						free (pe32);
 					}
				}
			]"
		end

	cwin_process32_next (snapshot: POINTER; prc_entry: TYPED_POINTER [POINTER]; succ: TYPED_POINTER [BOOLEAN])
			-- Get information of the next process in `snapshot' and store result in `prc_entry'.
			-- If successed, set `succ' to True, otherwise to False.
			-- After use, call `cwin_free_pointer' to dispose `prc_entry'.
		external
			"C inline use <Tlhelp32.h>"
		alias
			"[
				{
  					if( Process32Next( $snapshot, (PROCESSENTRY32 *)(*$prc_entry) ) )
  					{
						*$succ = 1;
 					}
 					else
 					{
 						*$succ = 0;
 					}
				}
			]"
		end

	cwin_get_process_id_and_parent_id (prc_entry: POINTER; pid: TYPED_POINTER [INTEGER]; parent_pid: TYPED_POINTER [INTEGER])
			-- Get process id and its parent process id from `prc_entry'.
		external
			"C inline use <Tlhelp32.h>"
		alias
			"[
				{
					*$pid = ((PROCESSENTRY32 *)($prc_entry))->th32ProcessID;
					*$parent_pid = ((PROCESSENTRY32 *)($prc_entry))->th32ParentProcessID;
				}
			]"
		end

	read_process_entry (prc_entry: POINTER; pid, ppid: TYPED_POINTER [INTEGER]; thr_count: TYPED_POINTER [INTEGER]; pri_base: TYPED_POINTER [INTEGER_64]; exe: TYPED_POINTER [POINTER])
			-- Get process information from process entryp `prc_entry'.
			-- Store process id in `pid', parent process id in `ppid', thread count in `thr_count',
			-- priority class base in `pri_base' and executable file name in `exe'.
		external
			"C inline use <Tlhelp32.h>"
		alias
			"[
				{
					*$pid = ((PROCESSENTRY32 *)($prc_entry))->th32ProcessID;
					*$ppid = ((PROCESSENTRY32 *)($prc_entry))->th32ParentProcessID;
					*$thr_count = ((PROCESSENTRY32 *)($prc_entry))->cntThreads;
					*$pri_base = ((PROCESSENTRY32 *)($prc_entry))->pcPriClassBase;
					*$exe = ((PROCESSENTRY32 *)($prc_entry))->szExeFile;
				}
			]"
		end

feature{NONE} -- Thread iteration

	cwin_thread32_first (snapshot: POINTER; thread_entry: TYPED_POINTER [POINTER]; succ: TYPED_POINTER [BOOLEAN])
			-- Retrieves information about the first thread in a system snapshot `snapshot'.
			-- If successful, set `succ' to True and store thread information in `thread_entry'.
			-- After use, call `cwin_free_pointer' to dispose `thread_entry'.
		external
			"C inline use <Tlhelp32.h>"
		alias
			"[
				{
					THREADENTRY32 *te32;
					te32 = (THREADENTRY32 *)malloc (sizeof (THREADENTRY32));
					te32->dwSize = sizeof(THREADENTRY32 );
					if( Thread32First($snapshot, te32 ) )
					{
						*$succ = 1;
						*$thread_entry = (EIF_POINTER) te32;
					}
					else
					{
						*$succ = 0;
						*$thread_entry = 0;
						free (te32);
					}
				}
			]"
		end

	cwin_thread32_next (snapshot: POINTER; thread_entry: TYPED_POINTER [POINTER]; succ: TYPED_POINTER [BOOLEAN])
			-- Retrieves information about the next thread in a system snapshot `snapshot'.
			-- If successful, set `succ' to True and store thread information in `thread_entry'.
			-- After use, call `cwin_free_pointer' to dispose `thread_entry'.
		external
			"C inline use <Tlhelp32.h>"
		alias
			"[
				{
					if ( Thread32Next($snapshot, (THREADENTRY32 *)(*$thread_entry) ) )
					{
						*$succ = 1;
					}
					else
					{
						*$succ = 0;
					}
				}
			]"
		end

	cwin_read_thread_entry_32 (thread_entry: POINTER; owner_pid: TYPED_POINTER [INTEGER]; thread_id: TYPED_POINTER [INTEGER]; base_pri: TYPED_POINTER [INTEGER])
			-- Read thread information stored in `thread_entry' into `owner_pid', `thread_id' and `base_pri'.
		external
			"C inline use <Tlhelp32.h>"
		alias
			"[
				{
					*$owner_pid = ((THREADENTRY32 *)($thread_entry))->th32OwnerProcessID;
					*$thread_id = ((THREADENTRY32 *)($thread_entry))->th32ThreadID;
					*$base_pri = ((THREADENTRY32 *)($thread_entry))->tpBasePri;
				}
			]"
		end

	thread_information: detachable ARRAYED_LIST [WEL_THREAD_ENTRY_32]
			-- Information of all threads that are running
		local
			handle: POINTER
			entry: POINTER
			succ: BOOLEAN
			owner_pid, thread_id, base_pri: INTEGER
		do
			cwin_create_toolhelp32_snapshot (cwin_th32cs_snapthread, 0, $handle)
			if handle /= default_pointer then
				create Result.make (initial_list_capacity)
				from
					cwin_thread32_first (handle, $entry, $succ)
				until
					not succ
				loop
					cwin_read_thread_entry_32 (entry, $owner_pid, $thread_id, $base_pri)
					Result.extend (create {WEL_THREAD_ENTRY_32}.make (owner_pid, thread_id, base_pri))
					cwin_thread32_next (handle, $entry, $succ)
				end
				if entry /= default_pointer then
					cwin_free_pointer (entry)
				end
				cwin_close_handle (handle)
			end
		end

feature{NONE} -- Pointer and handle control

	cwin_free_pointer(ptr: POINTER)
			--
		external
			"C inline"
		alias
			"[
				{
					free ($ptr);
				}
			]"
		end

	cwin_close_handle (a_handle: POINTER)
			-- SDK CloseHandle
		external
			"C [macro <winbase.h>] (HANDLE)"
		alias
			"CloseHandle"
		end

feature{NONE} -- System Snapshot parameters

	cwin_th32cs_snapprocess: INTEGER
			--
		external
			"C inline use <Tlhelp32.h>"
		alias
			"TH32CS_SNAPPROCESS"
		end

	cwin_th32cs_inherit: INTEGER
			--
		external
			"C inline use <Tlhelp32.h>"
		alias
			"TH32CS_INHERIT"
		end

	cwin_th32cs_snapall: INTEGER
			--
		external
			"C inline use <Tlhelp32.h>"
		alias
			"TH32CS_SNAPALL"
		end

	cwin_th32cs_snapheaplist: INTEGER
			--
		external
			"C inline use <Tlhelp32.h>"
		alias
			"TH32CS_SNAPHEAPLIST"
		end

	cwin_th32cs_snapmodule: INTEGER
			--
		external
			"C inline use <Tlhelp32.h>"
		alias
			"TH32CS_SNAPMODULE"
		end

	cwin_th32cs_snapthread: INTEGER
			--
		external
			"C inline use <Tlhelp32.h>"
		alias
			"TH32CS_SNAPTHREAD"
		end

feature -- Process operation

	cwin_open_process (desired_access: INTEGER; inheritable: BOOLEAN;  prc_id: INTEGER): POINTER
			-- After use, call `cwin_close_handle' to close retrieved handle.
		external
			"C signature (DWORD, BOOL, DWORD): HANDLE use <Tlhelp32.h>"
		alias
			"OpenProcess"
		end

feature{NONE} -- Implementation

	initial_list_capacity: INTEGER = 100;
			-- Initial list capacity

note
	copyright: "Copyright (c) 1984-2017, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
