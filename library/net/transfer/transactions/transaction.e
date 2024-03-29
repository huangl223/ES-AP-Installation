note
	description:
		"Data transactions"
	legal: "See notice at end of class."

	status: "See notice at end of class."
	date: "$Date: 2009-05-06 15:19:03 +0000 (Wed, 06 May 2009) $"
	revision: "$Revision: 78525 $"

deferred class
	TRANSACTION

feature -- Access

	source: DATA_RESOURCE
			-- Current source
		deferred
		end

	target: DATA_RESOURCE
			-- Current target
		deferred
		end

feature -- Measurement

	count: INTEGER
			-- Number of transactions
		deferred
		end

feature -- Status report

	is_correct: BOOLEAN
			-- Is transaction set up correctly?
		deferred
		end

	error: BOOLEAN
			-- Has an error occurred in current transaction?
		do
			Result := source.error or target.error
		end

	succeeded: BOOLEAN
			-- Has the transaction succeeded?
		deferred
		end

feature -- Status setting

	reset_error
			-- Reset error flag.
		deferred
		end

feature -- Basic operations

	execute
			-- Execute transaction.
		require
			correct_transaction: is_correct
		deferred
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




end -- class TRANSACTION

