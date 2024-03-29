note
	description: "Objects that ..."
	author: "Daniel Furrer"
	date: "$Date: 2019-03-11 13:20:02 +0000 (Mon, 11 Mar 2019) $"
	revision: "$Revision: 102950 $"

class
	EV_HEADER_ITEM_IMP

inherit
	EV_HEADER_ITEM_I
		redefine
			interface
		end

	EV_TEXTABLE_IMP
		redefine
			interface,
			set_text
		end

	EV_PIXMAPABLE_IMP
		redefine
			interface
		end

	EV_ITEM_IMP
		redefine
			interface
		end

create
	make

feature -- Initialization

	make
			-- Initialize the header item.
		do
			create table_column.make
			table_column.set_min_width ({REAL_32}0.0)
			align_text_left
			set_width (80)
			set_text ("")
			set_is_initialized (True)
			user_can_resize := True
			maximum_width := 32000
		end

	handle_resize
			-- Call the appropriate actions for the header item resize
		do

		end

feature -- Access

	minimum_width: INTEGER
		-- Lower bound on `width' in pixels.

	minimum_height: INTEGER
		-- Lower bound on `width' in pixels.

	maximum_width: INTEGER
		-- Upper bound on `width' in pixels.

	user_can_resize: BOOLEAN
		-- Can a user resize `Current'?


	disable_user_resize
			-- Prevent `Current' from being resized by users.
		do

		end

	enable_user_resize
			-- Permit `Current' to be resized by users.
		do

		end

	is_dockable: BOOLEAN

feature -- Status setting

	set_text (a_text: READABLE_STRING_GENERAL)
		do
			Precursor {EV_TEXTABLE_IMP} (a_text)
			table_column.header_cell.set_string_value (create {NS_STRING}.make_with_string (a_text))
		end

	set_minimum_width (a_minimum_width: INTEGER)
			-- Assign `a_minimum_width' in pixels to `minimum_width'.
			-- If `width' is less than `a_minimum_width', resize.
		do
			table_column.set_min_width (a_minimum_width)
			minimum_width := a_minimum_width
			if width < minimum_width then
				set_width (minimum_width)
			end
		end

	set_maximum_width (a_maximum_width: INTEGER)
			-- Assign `a_maximum_width' in pixels to `maximum_width'.
			-- If `width' is greater than `a_maximum_width', resize.
		do
			table_column.set_max_width (a_maximum_width)
			maximum_width := a_maximum_width
			if width > maximum_width then
				set_width (maximum_width)
			end
		end

	set_width (a_width: INTEGER)
			-- Assign `a_width' to `width'.
		do
			table_column.set_width (a_width)
			--width := a_width
		end

	width: INTEGER
		do
			-- Test: Does not work because cocoa seems to enforce a minimum with of 10
			Result := table_column.width.floor
		end

	height: INTEGER
		do
			Result := 18
		end

	screen_x: INTEGER
		do
			io.put_string ("EV_HEADER_ITEM_IMP.screen_x: Not implemented%N")
		end

	screen_y: INTEGER
		do
			io.put_string ("EV_HEADER_ITEM_IMP.screen_y: Not implemented%N")
		end

	x_position: INTEGER
		do
			io.put_string ("EV_HEADER_ITEM_IMP.x_position: Not implemented%N")
		end

	y_position: INTEGER
		do
			io.put_string ("EV_HEADER_ITEM_IMP.y_position: Not implemented%N")
		end

	resize_to_content
			-- Resize `Current' to fully display both `pixmap' and `text'.
			-- As size of `text' is dependent on `font' of `parent', `Current'
			-- must be parented.
		do
			table_column.size_to_fit
		end

	set_pointer_style (c: EV_POINTER_STYLE)
			-- Assign `c' to `pointer_style'
		do
		end

feature {EV_HEADER_IMP} -- Implementation

	table_column: NS_TABLE_COLUMN

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_HEADER_ITEM note option: stable attribute end;
		-- Interface object of `Current'.

note
	copyright: "Copyright (c) 1984-2019, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
