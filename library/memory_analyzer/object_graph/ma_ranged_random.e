note
	description: "Pseudo random number in a range."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "David Stevens"
	date: "$Date: 2008-12-29 20:27:11 +0000 (Mon, 29 Dec 2008) $"
	revision: "$Revision: 76420 $"

class
	MA_RANGED_RANDOM

inherit
	RANDOM

create
	make, make_default

feature {NONE} -- Initialization

	make_default
		local
			t: TIME
		do
			create t.make_now
			set_seed (t.seconds \\ 1000)
		end

feature -- Access

	next_item_in_range (a_min: INTEGER; a_max: INTEGER): INTEGER
		local
			l_double: DOUBLE
		do
			forth
			l_double := a_min + (a_max - a_min) * double_item
			Result := l_double.rounded
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




end -- class RANGED_RANDOM
