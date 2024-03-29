﻿note
	description:
		"[
			EiffelVision table. Invisible container that allows
			unlimited number of other widgets to be packed inside it.
			A table controls the children's location and size
			automatically."
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2018-12-18 11:03:05 +0000 (Tue, 18 Dec 2018) $"
	revision: "$Revision: 102624 $"
class
	EV_TABLE

inherit
	EV_CONTAINER
		undefine
			fill,
			new_cursor,
			prune_all
		redefine
			implementation,
			is_in_default_state
		end

	CHAIN [EV_WIDGET]
		rename
			sequence_put as cl_put,
			prune as cl_prune,
			extend as cl_extend
		export
			{EV_ANY_HANDLER} default_create
		undefine
			default_create, copy, is_equal, cl_put, put,
			changeable_comparison_criterion, remove,
			cl_prune, has
		redefine
			move
		end

create
	default_create

feature -- Access

	rows: INTEGER
			-- Number of rows in `Current'.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.rows
		end

	columns: INTEGER
			-- Number of columns in `Current'.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.columns
		end

	item_at_position (a_column, a_row: INTEGER): detachable EV_WIDGET
			-- Widget at coordinates (`row', `column').
		require
			not_destroyed: not is_destroyed
			valid_row: (1 <= a_row) and (a_row <= rows);
			valid_column: (1 <= a_column) and (a_column <= columns)
		do
			Result := implementation.item_at_position (a_column, a_row)
		end

	item_column_position (widget: EV_WIDGET): INTEGER
			-- `Result' is column coordinate of `widget'.
		require
			not_destroyed: not is_destroyed
			widget_contained: has (widget)
		do
			Result := implementation.item_column_position (widget)
		ensure
			Result_valid: Result > 0 and Result <= columns - item_column_span (widget) + 1
		end

	item_row_position (widget: EV_WIDGET): INTEGER
			-- `Result' is row coordinate of `widget'.
		require
			not_destroyed: not is_destroyed
			widget_contained: has (widget)
		do
			Result := implementation.item_row_position (widget)
		ensure
			Result_valid: Result > 0 and Result <= rows - item_row_span (widget) + 1
		end

	item_column_span (widget: EV_WIDGET): INTEGER
			-- `Result' is number of columns taken by `widget'.
		require
			not_destroyed: not is_destroyed
			widget_contained: has (widget)
		do
			Result := implementation.item_column_span (widget)
		ensure
			Result_valid: Result > 0 and Result <= columns - item_column_position (widget) + 1
		end

	item_row_span (widget: EV_WIDGET): INTEGER
			-- `Result' is number of rows taken by `widget'.
		require
			not_destroyed: not is_destroyed
			widget_contained: has (widget)
		do
			Result := implementation.item_row_span (widget)
		ensure
			Result_valid: Result > 0 and Result <= rows - item_row_position (widget) + 1
		end

	item_list: ARRAYED_LIST [EV_WIDGET]
			-- List of items in `Current'.
		obsolete "Use `linear_representation' instead. [2017-05-31]"
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.item_list
		ensure
			Result_not_void: Result /= Void
			count_matches_widget_count: Result.count = count
		end

	to_array: ARRAY [detachable EV_WIDGET]
			-- A representation of `Current' as ARRAY. Included to
			-- ease transition from inheritance of ARRAY to
			-- inheritance of CHAIN. Contains contents of all cells
			-- from left to right, and top to bottom. You should only
			-- use this if you relied on the inheritence of ARRAY, and
			-- is only temporary to ease this change.
		obsolete "Available to ease transition to new inheritance structure. [2017-05-31]"
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.to_array
		ensure
			result_not_void: Result /= Void
		end

feature -- Status report

	columns_resizable_to (a_column: INTEGER): BOOLEAN
			-- May the column count be resized to `a_column'?
		require
			not_destroyed: not is_destroyed
			a_column_positive: a_column >= 1
		do
			Result := implementation.columns_resizable_to (a_column)
		end

	rows_resizable_to (a_row: INTEGER): BOOLEAN
			-- May the row count be resized to `a_row'?
		require
			not_destroyed: not is_destroyed
			a_row_positive: a_row >= 1
		do
			Result := implementation.rows_resizable_to (a_row)
		end

	column_clear (a_column: INTEGER): BOOLEAN
			-- Is column `a_column' free of widgets?
		require
			not_destroyed: not is_destroyed
			a_column_positive: a_column >= 1
			a_column_in_table: a_column <= columns
		do
			Result := implementation.column_clear (a_column)
		end

	row_clear (a_row: INTEGER): BOOLEAN
			-- Is row `a_row' free of widgets?
		require
			not_destroyed: not is_destroyed
			a_row_positive: a_row >= 1
			a_row_in_table: a_row <= rows
		do
			Result := implementation.row_clear (a_row)
		end

	widget_count: INTEGER
			-- Number of widgets in `Current'.
			-- Now that `Current' inherits CHAIN instead
			-- of ARRAY, `count' correctly returns the number
			-- of items in `Current', instead of the number of
			-- available cells in `Current', thereby making `widget_count'
			-- obsolete. To find the number of cells in `Current', do
			-- not use `count' anymore, but use rows * columns.
		obsolete "Use `count' instead. [2017-05-31]"
		require
			not_destroyed: not is_destroyed
		do
			Result := count
		ensure
			Result_non_negative: Result >= 0
		end

	row_spacing: INTEGER
			-- Spacing between two consecutive rows, in pixels.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.row_spacing
		ensure
			Result_non_negative: Result >= 0
		end

	column_spacing: INTEGER
			-- Spacing between two consecutive columns, in pixels.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.column_spacing
		ensure
			Result_non_negative: Result >= 0
		end

	border_width: INTEGER
			-- Spacing between edge of `Current' and outside edge items,
			-- in pixels.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.border_width
		ensure
			Result_non_negative: Result >= 0
		end

	is_homogeneous: BOOLEAN
			-- Are all items forced to have same dimensions.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.is_homogeneous
		ensure
			bridge_ok: Result = implementation.is_homogeneous
		end

	area_clear (a_column, a_row, column_span, row_span: INTEGER): BOOLEAN
			-- Are the cells represented by parameters free of widgets?
		require
			not_destroyed: not is_destroyed
			table_wide_enough: a_column + (column_span - 1) <= columns
			table_tall_enough: a_row + (row_span - 1) <= rows
		local
			a_col_ctr, a_row_ctr: INTEGER
		do
			Result := True
			from
				a_row_ctr := a_row
			until
				not Result or else (a_row_ctr = a_row + row_span)
			loop
				from
					a_col_ctr := a_column
				until
					not Result or else (a_col_ctr = a_column + column_span)
				loop
					Result := item_at_position (a_col_ctr, a_row_ctr) = Void
					a_col_ctr := a_col_ctr + 1
				end
				a_row_ctr := a_row_ctr + 1
			end
		end

	area_clear_excluding_widget (v: EV_WIDGET; a_column, a_row, column_span, row_span: INTEGER): BOOLEAN
			-- Are the cells represented by parameters free of widgets? Excludes cells
			-- filled by `v'.
		require
			not_destroyed: not is_destroyed
			table_wide_enough: a_column + (column_span - 1) <= columns
			table_tall_enough: a_row + (row_span - 1) <= rows
		do
			Result := implementation.area_clear_excluding_widget (v, a_column, a_row, column_span, row_span)
		end

	Prunable: BOOLEAN = True
		-- `Current' is always prunable.

	extendible: BOOLEAN
			-- May new items be added?
		do
			Result := not full
		end

	duplicate (n: INTEGER): like Current
			-- Copy of sub-chain beginning at current position
			-- and having min (`n', `from_here') items,
			-- where `from_here' is the number of items
			-- at or to the right of current position.

			-- This is not implementable in Vision2 as a widget may
			-- only be parented in one container at once.
		do
			check applicable: False then
			end
				-- The following line is for 6.8 void-safety compatibility.
			Result := Current
		end

feature -- Status settings

	enable_homogeneous
			-- Set each item in `Current' to be equal in size
			-- to that of the largest item.
		require
			not_destroyed: not is_destroyed
		do
			implementation.enable_homogeneous
		ensure
			is_homogeneous: is_homogeneous
		end

	disable_homogeneous
			-- Allow items to have varying sizes.
		require
			not_destroyed: not is_destroyed
		do
			implementation.disable_homogeneous
		ensure
			is_not_homogeneous: not is_homogeneous
		end

	set_row_spacing (a_value: INTEGER)
			-- Assign `a_value' to the spacing in-between rows, in pixels.
		require
			not_destroyed: not is_destroyed
			positive_value: a_value >= 0
		do
			implementation.set_row_spacing (a_value)
		ensure
			row_spacing_set: row_spacing = a_value
		end

	set_column_spacing (a_value: INTEGER)
			-- Assign `a_value' to the spacing in-between columns, in pixels.
		require
			not_destroyed: not is_destroyed
			positive_value: a_value >= 0
		do
			implementation.set_column_spacing (a_value)
		ensure
			column_spacing_set: column_spacing = a_value
		end

	set_border_width (a_value: INTEGER)
			-- Assign `a_value' to `border_width'.
		require
			not_destroyed: not is_destroyed
			positive_value: a_value >= 0
		do
			implementation.set_border_width (a_value)
		ensure
			border_width_set: border_width = a_value
		end

	resize (a_column, a_row: INTEGER)
			-- Resize the table to hold `a_column' by `a_row' widgets.
		require
			not_destroyed: not is_destroyed
			a_column_positive: a_column >= 1
			a_row_positive: a_row >= 1
			columns_resizeable: columns_resizable_to (a_column)
			rows_resizeable: rows_resizable_to (a_row)
		do
			implementation.resize (a_column, a_row)
		ensure
			columns_set: columns = a_column
			rows_set: rows = a_row
			items_untouched: linear_representation ~ old linear_representation
		end

	set_item_position (v: EV_WIDGET; a_column, a_row: INTEGER)
			-- Move `v' to position `a_column', `a_row'.
		require
			not_destroyed: not is_destroyed
			v_contained: has (v)
			a_column_positive: a_column >= 1
			a_row_positive: a_row >= 1
			table_wide_enough: a_column + (item_column_span (v) - 1) <= columns
			table_tall_enough: a_row + (item_row_span (v) - 1) <= rows
			table_area_clear:
				area_clear_excluding_widget (v, a_column, a_row, item_column_span (v), item_row_span (v))
		do
			implementation.set_item_position (v, a_column, a_row)
		ensure
			position_set: item_column_position (v) = a_column and item_row_position (v) = a_row
			span_unchanged: item_column_span (v) = old item_column_span (v) and
				item_row_span (v) = old item_row_span (v)
		end

	set_item_span (v: EV_WIDGET; column_span, row_span: INTEGER)
			-- Resize `v' to occupy `column_span' columns and `row_span' rows.
		require
			not_destroyed: not is_destroyed
			v_contained: has (v)
			column_span_positive: column_span >= 1
			row_span_positive: row_span >= 1
			table_wide_enough: item_column_position (v) + column_span - 1 <= columns
			table_tall_enough: item_row_position (v) + row_span - 1 <= rows
			table_area_clear:
				area_clear_excluding_widget (v, item_column_position (v), item_row_position (v), column_span, row_span)
			do
				implementation.set_item_span (v, column_span, row_span)
			ensure
				span_set: item_column_span (v) = column_span and item_row_span (v) = row_span
				position_unchanged: item_column_position (v) = old item_column_position (v) and
					item_row_position (v) = old item_row_position (v)
			end

	set_item_position_and_span (v: EV_WIDGET; a_column, a_row, column_span, row_span: INTEGER)
			-- Move `v' to `a_column', `a_row', and resize to occupy `column_span' columns and `row_span' rows.
		require
			not_destroyed: not is_destroyed
			v_not_void: v /= Void
			v_current: v /= Current
			v_contained: has (v)
			a_column_positive: a_column >= 1
			a_row_positive: a_row >= 1
			column_span_positive: column_span >= 1
			row_span_positive: row_span >= 1
			table_wide_enough: a_column + (column_span - 1) <= columns
			table_tall_enough: a_row + (row_span - 1) <= rows
			table_area_clear:
				area_clear_excluding_widget (v, a_column, a_row, column_span, row_span)
			do
				implementation.set_item_position_and_span (v, a_column, a_row, column_span, row_span)
			ensure
				position_set: item_column_position (v) = a_column and item_row_position (v) = a_row
				span_set: item_column_span (v) = column_span and item_row_span (v) = row_span
			end

feature -- Element change

	put_at_position, add (v: EV_WIDGET; a_column, a_row, column_span, row_span: INTEGER)
			-- Set the position of the widgets in one-based coordinates.
			--
			--           1         2
			--     +----------+---------+
			--   1 |xxxxxxxxxxxxxxxxxxxx|
			--     +----------+---------+
			--   2 |          |         |
			--     +----------+---------+
			--
			-- To describe the widget in the table as shown above,
			-- the corresponding coordinates would be (1, 1, 2, 1)
		require
			not_destroyed: not is_destroyed
			v_not_void: v /= Void
			v_not_current: v /= Current
			v_not_contained: not has (v)
			v_parent_void: v.parent = Void
			v_not_parent_of_current: not is_parent_recursive (v)
			v_containable: may_contain (v)
			a_column_positive: a_column >= 1
			a_row_positive: a_row >= 1
			column_span_positive: column_span >= 1
			row_span_positive: row_span >= 1
			table_wide_enough: a_column + (column_span - 1) <= columns
			table_tall_enough: a_row + (row_span - 1) <= rows
			table_area_clear:
				area_clear (a_column, a_row, column_span, row_span)
		do
			implementation.put (v, a_column, a_row, column_span, row_span)
		ensure
			item_inserted: has (v)
			count_increased : count = old count + 1
			position_assigned: item_column_position (v) = a_column and item_row_position (v) = a_row
			span_assigned: item_column_span (v) = column_span and item_row_span (v) = row_span
		end

	remove
			-- Remove current item.
		do
			prune (item)
		end

	prune (v: EV_WIDGET)
			-- Remove `v' if present. Do not move cursor, except if
			-- cursor was on `v', move to right neighbor.
		do
			implementation.remove (v)
		ensure then
			not_has_v: not has (v)
			had_item_implies_parent_void:
				old has (v) implies v.parent = Void
			had_item_implies_count_decreased:
				old has (v) implies count = old count - 1
		end

feature -- Iteration.

	has (v: EV_WIDGET): BOOLEAN
			-- Does `Current' contain `v'?
		do
			Result := implementation.has (v)
		end

	count: INTEGER
			-- Number of widgets contained in `Current'.
		do
			Result := implementation.count
		end

	full: BOOLEAN
			-- Is structure filled to capacity?
		do
			Result := implementation.full
		end

	wipe_out
			-- Remove all items.
		do
			implementation.wipe_out
		end

	before: BOOLEAN
			-- Is there no valid position to the left of current one?
		do
			Result := implementation.before
		end

	index: INTEGER
			-- Current position.
		do
			Result := implementation.index
		end

	after: BOOLEAN
			-- Is there no valid position to the right of current one?
		do
			Result := implementation.after
		end

	forth
			-- Move to next position; if no next position,
			-- ensure that `exhausted' will be true.
		do
			implementation.forth
		end

	back
			-- Move to previous position.
		do
			implementation.back
		end

	cursor: CURSOR
			-- Current cursor position.
		do
			Result := implementation.cursor
		ensure then
			bridge_ok: Result ~ implementation.cursor
		end

	valid_cursor (p: CURSOR): BOOLEAN
			-- Can the cursor be moved to position `p'?
			-- This is True if `p' conforms to EV_DYNAMIC_LIST_CURSOR and
			-- if it points to an item, `Current' must have it.
		do
			Result := implementation.valid_cursor (p)
		end

	go_to (p: CURSOR)
			-- Move cursor to position `p'.
		do
			implementation.go_to (p)
		end

	move (i: INTEGER)
			-- Move cursor `i' positions. The cursor
			-- may end up `off' if the absolute value of `i'
			-- is too big.
		do
			implementation.move (i)
		end

feature -- Contract support

	is_in_default_state: BOOLEAN
			-- Is `Current' in its default state.
		do
			Result := Precursor {EV_CONTAINER} and (
				not is_homogeneous and
				border_width = 0 and
				row_spacing = 0 and
				column_spacing = 0 and
				rows = 1 and
				columns = 1)
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	implementation: EV_TABLE_I
		-- Responsible for interaction with native graphics toolkit.

feature {NONE} -- Implementation

	create_implementation
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_TABLE_IMP} implementation.make
		end

invariant
	columns_positive: columns >= 1
	rows_positive: rows >= 1

note
	copyright: "Copyright (c) 1984-2018, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
