note
	description: "Tree view action flag (TVAF) constants."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2008-12-29 20:27:11 +0000 (Mon, 29 Dec 2008) $"
	revision: "$Revision: 76420 $"

class
	WEL_TVAF_CONSTANTS

feature -- Access

	Tvc_bykeyboard: INTEGER = 2
			-- Used for the `Tvn_selchanged' and `Tvn_selchanging'
			-- notification messages.
			-- Action done by a key stroke.
			--
			-- Declared in Windows as TVC_BYKEYBOARD

	Tvc_bymouse: INTEGER = 1
			-- Used for the `Tvn_selchanged' and `Tvn_selchanging'
			-- notification messages.
			-- Action done by a mouse click.
			--
			-- Declared in Windows as TVC_BYMOUSE

	Tvc_unknown: INTEGER = 0
			-- Used for the `Tvn_selchanged' or `Tvn_selchanging'
			-- notification messages.
			-- Action done by unknown.
			--
			-- Declared in Windows as TVC_UNKNOWN

	Tve_collapse: INTEGER = 1
			-- Used for the `Tvn_expand' or `Tvn_expanding'
			-- notification messages.
			-- Action done by collapsing the list.
			--
			-- Declared in Windows as TVE_COLLAPSE

	Tve_collapsereset: INTEGER = 32768
			-- Used for the `Tvn_expand' and `Tvn_expanding'
			-- notification messages.
			-- Action done by collapsing the list and removing
			-- the child items.
			--
			-- Declared in Windows as TVE_COLLAPSERESET

	Tve_expand: INTEGER = 2
			-- Used for the `Tvn_expand' and `Tvn_expanding'
			-- notification messages.
			-- Action done by expanding the list.
			--
			-- Declared in Windows as TVE_EXPAND

	Tve_toggle: INTEGER = 3;
			-- Used for the `Tvn_expand' and `Tvn_expanding'
			-- notification messages.
			-- Action done by changing the list of the list 
			-- between collapse and expand.
			--
			-- Declared in Windows as TVE_TOGGLE

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




end -- class WEL_TVAF_CONSTANTS

