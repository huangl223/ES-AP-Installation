﻿note
	description: "Implementation of `IEnumXXXX' Interface."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2018-11-13 05:53:16 +0000 (Tue, 13 Nov 2018) $"
	revision: "$Revision: 102425 $"

class
	IENUM_IMPL [G]

create
	make

feature {NONE} -- Initialization

	make (enumeration: like implementation)
			-- Initialization.
		require
			non_void_enumeration: enumeration /= Void
		do
			implementation := enumeration
		end

feature -- Basic Operations

	next (celt: INTEGER; rgelt: ARRAY [G]; pcelt_fetched: INTEGER_REF)
			-- Retrieves the next `celt' items in
			-- the enumeration sequence.
			-- If there are fewer than the requested number
			-- of elements left in the sequence, it retrieves
			-- the remaining elements. The number of elements
			-- actually retrieved is returned through
			-- `pcelt_fetched' (unless the caller passed in
			-- Void for that parameter).
			--
			-- `celt' [in] Number of elements being requested.
			-- `rgelt' [out] Array of size `celt' (or larger)
			-- of the elements of interest. The type of this
			-- parameter depends on the item being enumerated.
			-- Array index starts from 1.
			-- `pcelt_fetched' [out] Reference to the number of
			-- elements actually supplied in `rgelt'. Caller can
			-- pass in Void if celt is one.
		require
			valid_celt: celt >= 0
			valid_rgelt_lower: rgelt.lower = 1
			valid_rgelt_capacity: rgelt.capacity >= celt
		local
			i, n: INTEGER
			old_index: like {LIST [G]}.index
			storage: like implementation
		do
			storage := implementation
			old_index := storage.index
			from
				n := celt
				i := 1
			until
				storage.after or else n <= 0
			loop
				rgelt.put (storage.item, i)
				storage.forth
				i := i + 1
				n := n - 1
			variant
				n
			end
			storage.go_i_th (old_index)
			if attached pcelt_fetched then
				pcelt_fetched.set_item (i - 1)
			end
		end

	skip (celt: INTEGER)
			-- Skips over the next specified number of
			-- elements in the enumeration sequence.
			-- `celt' [in] Number of elements to be skipped.
		do
			implementation.move (celt)
		end

	reset
			-- Resets the enumeration sequence to the beginning.
		do
			implementation.start
		end

	clone1 (ppenum: CELL [like Current])
			-- Creates another enumerator that contains the
			-- same enumeration state as the current one.
			-- Using this function, a client can record a
			-- particular point in the enumeration sequence
			-- and then return to that point at a later time.
			-- The new enumerator supports the same interface
			-- as the original one.
			-- `ppenum' [out].
		do
			ppenum.put (create {like Current}.make (implementation.twin))
		end

feature {NONE} -- Implementation

	implementation: LIST [G]
			-- Implementation of enumeration.

	implementation_exists: BOOLEAN
			-- Does `implementation' exist?
		do
			Result := implementation /= Void
		ensure
			Result implies attached implementation
		end

invariant
	implementation_exists: implementation_exists

note
	copyright:	"Copyright (c) 1984-2018, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
