note
	description:
		"Enumeration class for text alignment. Default is left."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "text, aligment"
	date: "$Date: 2013-05-20 23:15:17 +0000 (Mon, 20 May 2013) $"
	revision: "$Revision: 92557 $"
	
class
	EV_TEXT_ALIGNMENT

create
	default_create,
	make_with_left_alignment,
	make_with_center_alignment,
	make_with_right_alignment

feature {NONE} -- Initialization

	make_with_left_alignment
		do
			set_left_alignment
		end

	make_with_center_alignment
		do
			set_center_alignment
		end

	make_with_right_alignment
		do
			set_right_alignment
		end

feature -- Status setting

	set_left_alignment
			-- Set the horizontal alignment to "left"
		do
			alignment_code := left_alignment
		ensure
			is_left_aligned: is_left_aligned
		end

	set_center_alignment
			-- Set the horizontal alignment to "center"
		do
			alignment_code := center_alignment
		ensure
			is_center_aligned: is_center_aligned
		end

	set_right_alignment
			-- Set the horizontal alignment to "right"
		do
			alignment_code := right_alignment
		ensure
			is_right_aligned: is_right_aligned
		end

feature -- Status report

	is_left_aligned: BOOLEAN
		do
			Result := alignment_code = left_alignment
		end

	is_center_aligned: BOOLEAN
		do
			Result := alignment_code = center_alignment
		end

	is_right_aligned: BOOLEAN
		do
			Result := alignment_code = right_alignment
		end

feature {EV_ANY_I} -- Implementation

	alignment_code: INTEGER
		-- Used internally to represent one of the three alignment states.

	left_alignment: INTEGER = 0
		-- Constant representing left alignment.
	center_alignment: INTEGER = 1
		-- Constant representing center alignment.
	right_alignment: INTEGER = 2
		-- Constants representing right alignment.

invariant
	alignment_code_within_range: 
		alignment_code >= left_alignment and 
		alignment_code <= right_alignment

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




end -- class EV_TEXT_ALIGNMENT

