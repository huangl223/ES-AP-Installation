note
	description:
		"Displays two widgets one above the other separated by an adjustable%
		%divider"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2009-06-11 04:44:06 +0000 (Thu, 11 Jun 2009) $"
	revision: "$Revision: 79201 $"

deferred class
	EV_VERTICAL_SPLIT_AREA_I

inherit

	EV_SPLIT_AREA_I
		redefine
			interface
		end

feature

	minimum_split_position: INTEGER
			-- Minimum position the splitter can have.
		do
			if first_visible and then attached first as l_first then
				Result := l_first.minimum_height
			end
		end

	maximum_split_position: INTEGER
			-- Maximum position the splitter can have.
		local
			a_sec_height: INTEGER
		do
			if second_visible and then attached second as l_second then
				a_sec_height := l_second.minimum_height
			end
			Result := height - a_sec_height - splitter_width
			if Result < minimum_split_position then
				Result := minimum_split_position
			end
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_VERTICAL_SPLIT_AREA note option: stable attribute end;

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




end -- class EV_HORIZONTAL_SPLIT_AREA_I








