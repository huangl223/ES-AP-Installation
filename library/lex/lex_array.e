note
	description:
		"One-dimensional arrays for lexical analysis"
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date: 2014-01-06 18:45:09 +0000 (Mon, 06 Jan 2014) $";
	revision: "$Revision: 93904 $"

class LEX_ARRAY [T] inherit

	ARRAY [T]
		export
			{ANY} lower, upper, item, put, resize;
		end

create
	make_filled, make_empty

note
	copyright:	"Copyright (c) 1984-2014, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
