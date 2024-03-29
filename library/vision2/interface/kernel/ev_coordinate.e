note
	description:
		"A position in a 2 dimensional space as INTEGERs (x, y)"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2013-05-20 23:15:17 +0000 (Mon, 20 May 2013) $"
	revision: "$Revision: 92557 $"

class
	EV_COORDINATE

inherit
	DEBUG_OUTPUT

create
	default_create,
	set,
	make,
	make_with_position,
	make_precise

feature -- Initialization

	make, set, make_with_position, set_position (a_x: like x; a_y: like y)
			-- Create an EV_COORDINATE at position (`a_x', `a_y').
		do
			x_precise := a_x
			y_precise := a_y
		ensure
			x_set: x = a_x
			y_set: y = a_y
		end

	make_precise, set_precise (a_x: like x_precise; a_y: like y_precise)
			-- Create an EV_COORDINATE at position (`a_x', `a_y')
		do
			x_precise := a_x
			y_precise := a_y
		ensure
			x_set: x_precise = a_x
			y_set: y_precise = a_y
		end


feature -- Access

	x, x_abs: INTEGER
			-- Horizontal position.
		do
			if x_precise > 0.0 then
				Result := (x_precise + 0.5).truncated_to_integer
			else
				Result := (x_precise - 0.5).truncated_to_integer
			end
		end

	y, y_abs: INTEGER
			-- Vertical position.
		do
			if y_precise > 0.0 then
				Result := (y_precise + 0.5).truncated_to_integer
			else
				Result := (y_precise - 0.5).truncated_to_integer
			end
		end

	x_precise: DOUBLE
			-- The precise horizontal position.

	y_precise: DOUBLE
			-- The precise vertival position.

feature -- Element change

	set_x (a_x: like x)
			-- Assign `a_x' to `x'.
		do
			x_precise := a_x
		ensure
			x_set: x = a_x
		end

	set_y (a_y: like y)
			-- Assign `a_y' to `y'.
		do
			y_precise := a_y
		ensure
			y_set: y = a_y
		end

	set_x_precise (a_x: like x_precise)
			-- Assign `a_x' to `x'.
		do
			x_precise := a_x
		ensure
			x_set: x_precise = a_x
		end

	set_y_precise (a_y: like y_precise)
			-- Assign `a_y' to `y'.
		do
			y_precise := a_y
		ensure
			y_set: y_precise = a_y
		end

feature -- Output

	debug_output: STRING
			-- Textual representation.
		do
			Result := "(" + x.out + ", " + y.out + ")"
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

end -- class EV_COORDINATES

