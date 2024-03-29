note
	description: "Ancestor to scroll bar and track bar."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2008-12-29 20:27:11 +0000 (Mon, 29 Dec 2008) $"
	revision: "$Revision: 76420 $"

deferred class
	WEL_BAR

inherit
	WEL_CONTROL

feature -- Status report

	position: INTEGER
			-- Current position
		require
			exists: exists
		deferred
		ensure
			valid_minimum: Result >= minimum
			valid_maximum: Result <= maximum
		end

	minimum: INTEGER
			-- Minimum position
		require
			exists: exists
		deferred
		ensure
			minimum_ok: Result <= maximum
		end

	maximum: INTEGER
			-- Maximum position
		require
			exists: exists
		deferred
		ensure
			maximum_ok: Result >= minimum
		end

	valid_maximum (a_position: INTEGER): BOOLEAN
			-- Is `a_position' valid as a maximum?
		do
			Result := a_position <= maximum
		end

feature -- Status setting

	set_position (new_position: INTEGER)
			-- Set `position' with `new_position'
		require
			exists: exists
			valid_minimum: new_position >= minimum
			valid_maximum: valid_maximum (new_position)
		deferred
		ensure
			position_set: position = new_position
		end

	set_range (a_minimum, a_maximum: INTEGER)
			-- Set `minimum' and `maximum' with
			-- `a_minimum' and `a_maximum'
		require
			exists: exists
			valid_range: a_minimum <= a_maximum
		deferred
		ensure
			minimum_set: minimum = a_minimum
			maximum_set: maximum = a_maximum
		end

invariant
	--XXXX
	--range_ok: exists implies minimum <= maximum
	--position_ok: exists implies position >= minimum and position <= maximum

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




end -- class WEL_BAR

