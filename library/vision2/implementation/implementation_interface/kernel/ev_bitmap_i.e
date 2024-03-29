note
	description: "Objects that ..."
	author: ""
	date: "$Date: 2013-05-20 23:15:17 +0000 (Mon, 20 May 2013) $"
	revision: "$Revision: 92557 $"

deferred class
	EV_BITMAP_I

inherit
	EV_DRAWABLE_I
		redefine
			interface
		end

feature -- Status Setting

	set_size (a_x, a_y: INTEGER)
			-- Set the size of the pixmap to `a_x' by `a_y' pixels.
		require
			x_coordinate_valid: a_x > 0
			y_coordinate_valid: a_y > 0
		deferred
		end

feature

	interface: detachable EV_BITMAP note option: stable attribute end;

end
