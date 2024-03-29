note
	description:
		"Managers that control the data transactions"
	legal: "See notice at end of class."

	status: "See notice at end of class."
	date: "$Date: 2013-12-04 01:09:18 +0000 (Wed, 04 Dec 2013) $"
	revision: "$Revision: 93617 $"

class TRANSFER_MANAGER inherit

	TRANSACTION_CONTAINER [TRANSACTION]
		rename
			item as transaction
		undefine
			copy, is_equal, force, is_inserted, search, append, fill,
			for_all, there_exists, do_all, do_if
		end

	ARRAYED_LIST [TRANSACTION]
		rename
			make as list_make, item as transaction,
			go_i_th as select_transaction
		export
			{ANY} valid_index, valid_cursor_index
			{TRANSFER_MANAGER} area, area_v2, i_th, cursor, go_to, valid_cursor, upper, lower
			{NONE} all
		end

	DATA_RESOURCE_ERROR_CONSTANTS
		export
			{NONE} all
		undefine
			copy, is_equal
		end

create
	make

create {TRANSFER_MANAGER}
	list_make

feature {NONE} -- Initialization

	make
			-- Create manager.
		do
			list_make (1)
			stop_on_error
		end

feature -- Access

	source: DATA_RESOURCE
			-- Selected source
		do
			Result := transaction.source
		end

	target: DATA_RESOURCE
			-- Selected target
		do
			Result := transaction.target
		end

feature -- Measurement

	total_count: INTEGER
			-- Total number of transactions
		local
			idx: INTEGER
			i: INTEGER
		do
			if count > 0 then
				idx := index
				from i := 1 until i = count + 1 loop
					select_transaction (i)
					Result := Result + transaction.count
					i := i + 1
				end
			end
			select_transaction (idx)
		ensure
			index_unchanged: index = old index
		end

	finished_transactions: INTEGER
			-- Number of already finished transactions

feature -- Status report

	error: BOOLEAN
			-- Has an error occurred in any transaction?
		require
			not_empty: not is_empty
		do
			Result := check_query (agent transaction.error)
		end

	error_reason: STRING
			-- Reason of most recent error
		require
			error_exists: error
		local
			idx: INTEGER
			l_error: detachable STRING
		do
			idx := index
			from start until l_error /= Void or after loop
				if source.error then
					l_error := error_text (source.error_code)
				elseif target.error then
					l_error := error_text (target.error_code)
				end
				forth
			end
			check l_error_attached: l_error /= Void then
				Result := l_error
			end
			select_transaction (idx)
		ensure
			non_empty_string: Result /= Void and then not Result.is_empty
			index_unchanged: index = old index
		end

	transactions_succeeded: BOOLEAN
			-- Have all transactions succeeded?
		require
			not_empty: not is_empty
		do
			if transfer_finished then
				Result := check_query (agent transaction.succeeded)
			end
		end

	transfer_finished: BOOLEAN
			-- Has a transfer taken place?

	insertable (t: TRANSACTION): BOOLEAN
			-- Can transaction `t' be added?
		do
			Result := True
		end

feature -- Status setting

	reset_status
			-- Reset status flags.
		do
			transfer_finished := False
			execute_command (agent reset_error)
		ensure
			finished_flag_reset: not transfer_finished
			no_error: not error
		end

feature -- Removal

	remove_transaction (n: INTEGER)
			-- Remove `n'-th transaction.
		require
			not_empty: not is_empty
			index_in_range: 1 <= n and n <= count
		local
			idx: INTEGER
		do
			idx := index
			select_transaction (n)
			remove
			if idx > count then idx := count end
			select_transaction (idx)
		ensure
			one_less_item: count = count - 1
			index_unchanged: (old index < old count) implies (index = old index)
			index_adapted: (old index = old count) implies
					(index = old index - 1)
		end

feature -- Basic operations

	transfer
			-- Execute all transactions.
		require
			not_empty: not is_empty
			flags_reset: not (transfer_finished and transactions_succeeded)
		do
			transfer_finished := True
			execute_command (agent execute_transaction)
		ensure
			transfer_flag_set: transfer_finished
		end

	execute_transaction
			-- Execute selected transaction.
		do
			transaction.execute
			if not transaction.error then
				finished_transactions :=
					finished_transactions + transaction.count
			end
		ensure
			counter_updated: not transaction.error implies
				finished_transactions = old finished_transactions +
					transaction.count
		end

feature {NONE} -- Implementation

	reset_error
			-- Reset error flags.
		do
			transaction.reset_error
		end

invariant

	finished_transaction_range: 0 <= finished_transactions and
			finished_transactions <= total_count

note
	copyright:	"Copyright (c) 1984-2013, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class TRANSFER_MANAGER

