note
	description: "Convert a data to its string representation according%
			%to an agent. Use this class when `out' cannot be used."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Cedric Reduron"
	date: "$Date: 2019-08-26 15:54:41 +0000 (Mon, 26 Aug 2019) $"
	revision: "$Revision: 103422 $"

class
	DV_VALUE_REDIRECTOR

create
	make,
	make_with_default_size

feature -- Initialization

	make
			-- Create storage hash-tables.
		do
			create result_table.make (10)
			create inversion_table.make (10)
		end

	make_with_default_size (n_items: INTEGER)
			-- Make with and allocate space to store at least `n_items'.
		do
			create result_table.make (n_items)
			create inversion_table.make (n_items)
		end

feature -- Access

	redirected_value (data: ANY): STRING_32
			-- Return the redirected value from redirector.
		require
			at_least_one_result_set: at_least_one_result_set
		do
			if attached {HASHABLE} data as h then
				if attached result_table.item (h) as l_found_item then
					Result := l_found_item
				elseif attached redirector as l_redirector then
					Result := l_redirector.item ([h])
					result_table.put (Result, h)
				else
					Result := ""
				end
			elseif attached redirector as l_redirector then
				Result := l_redirector.item ([data])
			else
				Result := ""
			end
		end

	inverted_value (s: READABLE_STRING_GENERAL): detachable ANY
			--
		require
			can_invert: can_invert
		do
			if attached inversion_table.item (s) as l_found_item then
				Result := l_found_item
			elseif attached invertor as l_invertor then
				Result := l_invertor.item ([s.to_string_32])
				inversion_table.put (Result, s)
			end
		end

feature -- Status report

	at_least_one_result_set: BOOLEAN
			-- Is one way to get a result set?
		do
			Result := redirector /= Void or else result_table /= Void
		end

	can_invert: BOOLEAN
			-- Can component retrieve data from its indirection?
		do
			Result := invertor /= Void or else inversion_table /= Void
		end

feature -- Basic operations

	set_results (res_t: HASH_TABLE [STRING_32, HASHABLE])
			-- Set values of the redirector result table with `res_t'.
		require
			not_void: res_t /= Void
		do
			result_table := res_t
		ensure
			at_least_one_result_set: at_least_one_result_set
		end

	set_inversion_table (inv_t: STRING_TABLE [ANY])
			-- Set values of the invertor result table with `res_t'.
		require
			not_void: inv_t /= Void
		do
			inversion_table := inv_t
		ensure
			can_invert: can_invert
		end

	set_redirector (red: FUNCTION [ANY, STRING_32])
			-- Set the redirector to use.
			-- PLEASE set a procedure keeping argument of type ANY to avoid cat calls.
		require
			not_void: red /= Void
		do
			redirector := red
		ensure
			at_least_one_result_set: at_least_one_result_set
		end

	set_invertor (inv: FUNCTION [STRING_32, ANY])
			-- Set the invertor to use.
			-- Warning: set a procedure keeping result of type ANY to avoid cat calls.
		require
			not_void: inv /= Void
		do
			invertor := inv
		ensure
			can_invert: can_invert
		end

feature {NONE} -- Implementation

	redirector: detachable FUNCTION [ANY, STRING_32]
			-- Function to redirect data to a string representation.

	invertor: detachable FUNCTION [STRING_32, ANY]
			-- Function to find back data from its string representation.

	result_table: HASH_TABLE [STRING_32, HASHABLE]
			-- Table to store and access string corresponding to an hashable data.

	inversion_table: STRING_TABLE [ANY];
			--  Table to store and access data from its string representation.

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


end -- class DV_VALUE_REDIRECTOR



