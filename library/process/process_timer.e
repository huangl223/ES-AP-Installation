﻿note
	description: "Timer used to check process status."
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date: 2017-03-31 13:03:02 +0000 (Fri, 31 Mar 2017) $"
	revision: "$Revision: 100086 $"

deferred class
	PROCESS_TIMER

feature {PROCESS} -- Control

	start
			-- Start timer.
		require
			thread_capable: {PLATFORM}.is_thread_capable
			process_launcher_not_void: process_launcher /= Void
			timer_destroyed: is_destroyed
		deferred
		end

	destroy
			-- Destroy timer.
		require
			thread_capable: {PLATFORM}.is_thread_capable
			process_launcher_not_void: process_launcher /= Void
		deferred
		end

	wait (a_timeout: INTEGER): BOOLEAN
			-- Wait at most `a_timeout' milliseconds for current timer to be destroyed.
			-- If `a_timeout' is 0, wait infinitly until timer is destroyed.			
			-- Return True if timer is destroyed in `a_timeout', otherwise False.
			-- Timer will be destroyed automatically when launched process has terminated and related io
			-- redirection has finished. So waiting for timer means wait for a safe status which indicats
			-- all needed work has finished.
		require
			thread_capable: {PLATFORM}.is_thread_capable
			process_launcher_not_void: process_launcher /= Void
			a_timeout_not_negative: a_timeout >= 0
			timer_started: has_started
		deferred
		end

feature -- Setting

	set_process_launcher (prc_launcher: PROCESS)
			-- Set process launcher to which this timer is attached with `prc_launcher'.
		require
			prc_launcher_not_void: prc_launcher /= Void
			timer_destroyed: is_destroyed
		do
			process_launcher := prc_launcher
		ensure
			process_launcher_set: process_launcher = prc_launcher
		end

feature -- Status reporting

	has_started: BOOLEAN
			-- Has this timer started yet?

	frozen destroyed: BOOLEAN
			-- Has this timer been destroyed?
		obsolete
			"Use `is_destroyed' instead. [2017-05-31]"
		do
			Result := is_destroyed
		end

	is_destroyed: BOOLEAN
			-- Has this timer been destroyed?
		deferred
		end

	sleep_time: INTEGER
			-- Time in milliseconds for this timer to sleep	

	process_launcher: detachable PROCESS
			-- process launcher to which this timer is attached.

feature {NONE} -- Implementation

	one_millisecond_in_nanoseconds: INTEGER = 1_000_000
		-- One millisecond expressed in nanoseconds.

invariant
	sleep_time_positive: sleep_time > 0

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
