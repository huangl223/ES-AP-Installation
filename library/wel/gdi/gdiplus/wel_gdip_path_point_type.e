note
	description: "[
					Enumeration the type of point in a GraphicsPath object.
					Please see MSDN:
					http://msdn.microsoft.com/en-us/library/3ch9cxht(VS.71).aspx
																					]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2013-05-20 23:15:17 +0000 (Mon, 20 May 2013) $"
	revision: "$Revision: 92557 $"

class
	WEL_GDIP_PATH_POINT_TYPE

feature -- Enumeration

	Start: INTEGER = 0
			-- Specifies the starting point of a GraphicsPath.

	Line: INTEGER = 1
			-- Specifies a line segment.

	Bezier: INTEGER = 3
			-- Specifies a default Bezier curve.

	Bezier3: INTEGER = 3
			-- Specifies a cubic Bezier curve.

	PathTypeMask: INTEGER = 7
			-- Specifies a mask point.

	DashMode: INTEGER = 0x10
			-- Specifies that the corresponding segment is dashed.

	PathMarker: INTEGER = 0x20
			-- Specifies a path marker.

	CloseSubpath: INTEGER = 0x80
			-- Specifies the ending point of a subpath.

feature -- Query

	is_valid (a_int: INTEGER): BOOLEAN
			-- If `a_int' valid?
		do
			Result := a_int = Start
				or a_int = Line
				or a_int = Bezier
				or a_int = Bezier3
				or a_int = Pathtypemask
				or a_int = Dashmode
				or a_int = Pathmarker
				or a_int = Closesubpath
		end

	is_valid_array (a_array: ARRAYED_LIST [INTEGER]): BOOLEAN
			-- If all items in `a_array' valid?
		require
			not_void: a_array /= Void
		do
			from
				Result := True
				a_array.start
			until
				a_array.after or not Result
			loop
				Result := is_valid (a_array.item)
				a_array.forth
			end
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

end
