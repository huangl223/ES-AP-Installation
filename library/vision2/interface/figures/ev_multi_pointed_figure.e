note
	description:
		"Figures consisting of zero or more points."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "figure, points"
	date: "$Date: 2017-05-03 15:56:14 +0000 (Wed, 03 May 2017) $"
	revision: "$Revision: 100317 $"

deferred class
	EV_MULTI_POINTED_FIGURE

obsolete
	"Use EV_MODEL_MULTI_POINTED instead. [2017-05-31]"

feature -- Access

	point_count: INTEGER
			-- Dynamic number of points in `Current'.
		do
			Result := points.count
		end

	i_th_point (i: INTEGER): EV_RELATIVE_POINT
			-- `i'-th point of `Current'.
		require
			i_within_bounds: i > 0 and then i <= point_count
		do
			Result := points.i_th (i)
		ensure
			correct_entry: Result = points.i_th (i)
		end

feature -- Status setting

	set_i_th_point (i: INTEGER; a_point: EV_RELATIVE_POINT)
			-- Assign `a_point' to `i'-th point.
		require
			i_within_bounds: i > 0 and then i <= point_count
			a_point_not_void: a_point /= Void
		do
			points.put_i_th (a_point, i)
		ensure
			assigned: points.i_th (i) = a_point
		end

	set_point_count (a_count: INTEGER)
			-- Assign `a_count' to `point_count'.
		require
			a_count_non_negative: a_count >= 0
		do
			if a_count > point_count then
				from until point_count = a_count loop
					points.extend (create {EV_RELATIVE_POINT})
				end
			elseif a_count < point_count then
				from until point_count = a_count loop
					points.finish
					points.remove
				end
			end
		ensure
			point_count_assigned: point_count = a_count
		end

	extend_point (a_point: EV_RELATIVE_POINT)
			-- Add `a_point' to end of `Current'.
		require
			a_point_not_void: a_point /= Void
		do
			points.extend (a_point)
		ensure
			incremented: points.count = old points.count + 1
			assigned: points.i_th (points.count) = a_point
		end

feature {NONE} -- Implementation

	points: ARRAYED_LIST [EV_RELATIVE_POINT]
			-- Relative points `Current' consists of.
		deferred
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




end -- class EV_MULTI_POINTED_FIGURE





