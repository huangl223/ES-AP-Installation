note
	description: "Objects that may have their text aligned to the%
		%left, center or right."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2011-08-09 19:30:30 +0000 (Tue, 09 Aug 2011) $"
	revision: "$Revision: 86967 $"

deferred class
	EV_TEXT_ALIGNABLE


inherit
	EV_TEXTABLE
		redefine
			implementation
		end

feature -- Access

	text_alignment: INTEGER
			-- Current horizontal text alignment.
			-- See class EV_TEXT_ALIGNABLE_CONSTANTS for
			-- possible values.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.text_alignment
		ensure
			bridge_ok: Result = implementation.text_alignment
		end

feature -- Status report

	is_left_aligned: BOOLEAN
			-- Is `Current' left aligned?
		require
			not_destroyed: not is_destroyed
		do
			Result := text_alignment = {EV_TEXT_ALIGNMENT_CONSTANTS}.Ev_text_alignment_left
		end

	is_center_aligned: BOOLEAN
			-- Is `Current' center aligned?
		require
			not_destroyed: not is_destroyed
		do
			Result := text_alignment = {EV_TEXT_ALIGNMENT_CONSTANTS}.Ev_text_alignment_center
		end

	is_right_aligned: BOOLEAN
			-- Is `Current' right aligned?
		require
			not_destroyed: not is_destroyed
		do
			Result := text_alignment = {EV_TEXT_ALIGNMENT_CONSTANTS}.Ev_text_alignment_right
		end

feature -- Status setting

	align_text_center
			-- Display `text' centered.
		require
			not_destroyed: not is_destroyed
		do
			implementation.align_text_center
		ensure
			alignment_set: is_center_aligned
		end

	align_text_right
			-- Display `text' right aligned.
		require
			not_destroyed: not is_destroyed
		do
			implementation.align_text_right
		ensure
			alignment_set: is_right_aligned
		end

	align_text_left
			-- Display `text' left aligned.
		require
			not_destroyed: not is_destroyed
		do
			implementation.align_text_left
		ensure
			alignment_set: is_left_aligned
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	implementation: EV_TEXT_ALIGNABLE_I

invariant

	valid_alignment: (create {EV_TEXT_ALIGNMENT_CONSTANTS}).valid_alignment (text_alignment)

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




end -- class EV_TEXT_ALIGNABLE

