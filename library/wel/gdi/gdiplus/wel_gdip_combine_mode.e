note
	description: "[
					The CombineMode enumeration specifies how a new region is 
					combined with an existing region.
																			]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2013-05-20 23:15:17 +0000 (Mon, 20 May 2013) $"
	revision: "$Revision: 92557 $"


class
	WEL_GDIP_COMBINE_MODE

feature -- Enumeration

	Replace: INTEGER = 0
			-- One clipping region is replaced by another.

	Intersect: INTEGER = 1
			-- Two clipping regions are combined by taking their intersection.

	Union: INTEGER = 2
			-- Two clipping regions are combined by taking the union of both.

	Xor_mode: INTEGER = 3
			-- Two clipping regions are combined by taking only the areas enclosed by one or the other region, but not both.

	Exclude: INTEGER = 4
			-- Specifies that the existing region is replaced by the result of the new region being removed
			-- from the existing region. Said differently, the new region is excluded from the existing region.

	Complement: INTEGER = 5
			-- Specifies that the existing region is replaced by the result of the existing region being
			-- removed from the new region. Said differently, the existing region is excluded from the new region.

feature -- Query

	is_valid (a_int: INTEGER): BOOLEAN
			-- If `a_int' valid?
		do
			Result := a_int = Replace
					or a_int = Intersect
					or a_int = Union
					or a_int = Xor_mode
					or a_int = Exclude
					or a_int = Complement
		end

;note
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
