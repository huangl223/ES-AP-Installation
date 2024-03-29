note
	description:
		"Facilities for managing peer relations between radio buttons.%N%
		%Base class for EV_RADIO_BUTTON, EV_RADIO_MENU_ITEM and%
		%EV_TOOL_BAR_RADIO_BUTTON."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "radio, item, menu, check, select"
	date: "$Date: 2013-05-20 23:15:17 +0000 (Mon, 20 May 2013) $"
	revision: "$Revision: 92557 $"

deferred class
	EV_RADIO_PEER

inherit
	EV_ANY
		redefine
			implementation,
			is_in_default_state
		end

feature -- Status report

	is_selected: BOOLEAN
			-- Is this radio item checked?
		require
			not_destroyed: not is_destroyed
		deferred
		end

	peers: LINKED_LIST [like selected_peer]
			-- All radio items in the group `Current' is in.
			-- Includes `Current'.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.peers
		ensure
			not_void: Result /= Void
			bridge_ok: Result.count = implementation.peers.count
		end

	selected_peer: like Current
			-- Item in `peers' that is currently selected.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.selected_peer
		ensure
			not_void: Result /= Void
			bridge_ok: Result.is_equal (implementation.selected_peer)
		end

feature -- Status setting

	enable_select
			-- Change selected peer to `Current'.
		require
			not_destroyed: not is_destroyed
		deferred
		ensure
			selected_peer_is_current: selected_peer = Current
		end

feature {NONE} -- Contract support

	selected_count: INTEGER
			-- Number of selected radio items in `peers'.
		local
			l: like peers
		do
			l := peers
			from
				l.start
			until
				l.off
			loop
				if l.item.is_selected then
					Result := Result + 1
				end
				l.forth
			end
		end

	is_in_default_state: BOOLEAN
			-- Is `Current' in its default state?
			-- Radio buttons are selected by default.
		do
			Result := Precursor and then is_selected
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	implementation: EV_RADIO_PEER_I
			-- Responsible for interaction with native graphics toolkit.

invariant
	peers_not_void: is_usable implies (peers /= Void)
	selected_peer_not_void: is_usable implies (selected_peer /= Void)
	peers_returns_new_copy_of_list: is_usable implies (peers /= peers)
	peers_has_current: is_usable implies (peers.has (Current))
	is_selected_equals_selected_peer_is_current:
		is_usable implies (is_selected = (selected_peer = Current))
	one_radio_item_selected: is_usable implies (selected_count = 1)

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




end -- class EV_RADIO_PEER

