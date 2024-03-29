note
	description: "A data packet for sending and receiving on a socket."
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date: 2010-01-06 21:46:03 +0000 (Wed, 06 Jan 2010) $";
	revision: "$Revision: 82000 $"

class
	PACKET

inherit
	ANY
		redefine
			copy, is_equal
		end

create
	make,
	make_from_managed_pointer

feature -- Initialization

	make (size: INTEGER)
			-- Create a packet.
		require
			valid_size: size >= 0
		do
			create data.make (size)
		end

	make_from_managed_pointer (a_data: like data)
			-- Create packet from `a_data' memory stream.
		require
			a_data_not_void: a_data /= Void
		do
			data := a_data
		ensure
			data_set: data = a_data
		end

feature -- Measurement

	count: INTEGER
			-- Number of elements in packet
		do
			Result := data.count
		end

feature -- Access

	element alias "[]", at alias "@" (i: INTEGER): CHARACTER assign put_element
			-- Entry at index `i'.
		require
			valid_position: valid_position (i)
		do
			Result := data.read_integer_8 (i).to_character_8
		end

feature -- Status report

	valid_position (i: INTEGER): BOOLEAN
			-- Is `i' within the bounds of Current?
		do
			Result := (0 <= i) and then (i < count)
		end

feature -- Element change

	put_element (v: CHARACTER; i: INTEGER)
			-- Replace `i'-th entry by `v'.
		require
			valid_position: valid_position (i)
		do
			data.put_integer_8 (v.code.to_integer_8, i)
		ensure
			inserted: element (i) = v
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN
			-- Is current packet equal to `other'?
		do
			Result := data.is_equal (other.data)
		end

feature -- Duplication

	copy (other: like Current)
			-- Reinitialize by copying characters of `other'.
			-- (This is also used by `clone')
		do
			if other /= Current then
				standard_copy (other)
				data := other.data.twin
			end
		ensure then
			size_valid: count = other.count
		end

feature -- Storage

	data: MANAGED_POINTER
			-- Place holder

invariant
	data_not_equal_void: data /= Void

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




end -- class PACKET

