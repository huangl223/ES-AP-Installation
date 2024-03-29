note
	description:
		"[
			Base class for interactive scrolling widgets.
			See EV_HORIZONTAL_SCROLL_BAR and EV_VERTICAL_SCROLL_BAR.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "scroll, bar, horizontal, vertical, gauge, leap, step, page"
	date: "$Date: 2008-12-29 20:27:11 +0000 (Mon, 29 Dec 2008) $"
	revision: "$Revision: 76420 $"

deferred class
	EV_SCROLL_BAR

inherit
	EV_GAUGE
		redefine
			implementation,
			is_in_default_state_for_tabs
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	implementation: EV_SCROLL_BAR_I
			-- Responsible for interaction with native graphics toolkit.

feature {NONE} -- Contract support

	is_in_default_state_for_tabs: BOOLEAN
		do
			Result := not is_tabable_from and not is_tabable_to
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




end -- class EV_SCROLL_BAR

