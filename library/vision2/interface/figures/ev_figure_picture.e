note
	description:
		"Pixmaps drawn on `point'."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "figure, picture, pixmap"
	date: "$Date: 2017-05-03 15:56:14 +0000 (Wed, 03 May 2017) $"
	revision: "$Revision: 100317 $"

class
	EV_FIGURE_PICTURE

obsolete
	"Use EV_MODEL_PICTURE instead. [2017-05-31]"

inherit
	EV_ATOMIC_FIGURE
		redefine
			default_create
		end

	EV_SINGLE_POINTED_FIGURE
		undefine
			default_create
		end

create
	default_create,
	make_with_point,
	make_with_pixmap

feature {NONE} -- Initialization

	default_create
			-- Create in (0, 0)
		do
			pixmap := default_pixmap
			Precursor {EV_ATOMIC_FIGURE}
			is_default_pixmap_used := True
		end

	make_with_pixmap (a_pixmap: EV_PIXMAP)
			-- Create with `a_pixmap'.
		require
			a_pixmap_not_void: a_pixmap /= Void
		do
			default_create
			set_pixmap (a_pixmap)
		end

feature -- Access

	pixmap: EV_PIXMAP
			-- Pixmap that is displayed.

feature -- Status report

	width: INTEGER
			-- Width of pixmap.
		do
			Result := pixmap.width
		ensure
			assigned: Result = pixmap.width
		end

	height: INTEGER
			-- Height of Pixmap.
		do
			Result := pixmap.height
		ensure
			assigned: Result = pixmap.height
		end


	is_default_pixmap_used: BOOLEAN
			-- Is `Current' using a default pixmap?

feature -- Status setting

	set_pixmap (a_pixmap: EV_PIXMAP)
			-- Set `pixmap' to `a_pixmap'.
		require
			a_pixmap_not_void: a_pixmap /= Void
		do
			pixmap := a_pixmap
			is_default_pixmap_used := False
			invalidate
		ensure
			pixmap_assigned: pixmap = a_pixmap
		end

feature -- Events

	position_on_figure (x, y: INTEGER): BOOLEAN
			-- Is (`x', `y') on this figure?
		local
			ax, ay: INTEGER
		do
			ax := point.x_abs
			ay := point.y_abs
			Result := point_on_rectangle (x, y, ax, ay, ax + width, ay + height)
		end

	Default_pixmap: EV_PIXMAP
			-- Pixmap set by `default_create'.
		once
			create Result
		end

invariant
	pixmap_exists: pixmap /= Void

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




end -- class EV_FIGURE_PICTURE





