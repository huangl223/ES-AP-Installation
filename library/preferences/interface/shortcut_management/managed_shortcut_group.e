note
	description: "A group shortcuts. Confliction is detected among shortcuts with the same group."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2014-01-07 17:56:21 +0000 (Tue, 07 Jan 2014) $"
	revision: "$Revision: 93917 $"

class
	MANAGED_SHORTCUT_GROUP

create
	make

feature -- Initialization

	make
			-- Initialization
		do
			create shortcuts.make (5)
		end

feature -- Access

	shortcuts: ARRAYED_LIST [MANAGED_SHORTCUT]

	found_item: detachable MANAGED_SHORTCUT

	key_combination (a_key: detachable EV_KEY; alt, ctrl, shift: BOOLEAN): detachable MANAGED_SHORTCUT
			-- Does this group has a shortcut with the key combination?
		local
			l_cursor: CURSOR
		do
			if a_key /= Void then
				from
					l_cursor := shortcuts.cursor
					shortcuts.start
				until
					shortcuts.after or Result /= Void
				loop
					if shortcuts.item.matches (a_key, alt, ctrl, shift) then
						Result := shortcuts.item
					end
					shortcuts.forth
				end
				shortcuts.go_to (l_cursor)
			end
		end

	shortcut (a_shortcut: detachable MANAGED_SHORTCUT): detachable MANAGED_SHORTCUT
			-- Shortcut similar to `a_shortcut'?
		do
			if a_shortcut /= Void and then not a_shortcut.is_wiped then
				Result := key_combination (a_shortcut.key, a_shortcut.is_alt, a_shortcut.is_ctrl, a_shortcut.is_shift)
			end
		end

feature -- Status Report

	has_key_combination (a_key: detachable EV_KEY; alt, ctrl, shift: BOOLEAN): BOOLEAN
			-- Does this group has `a_shortcut' with the key combination?
		do
			found_item := key_combination (a_key, alt, ctrl, shift)
			Result := found_item /= Void
		ensure
			has_item_implies_found_item_not_void: Result implies found_item /= Void
		end

	has (a_shortcut: detachable MANAGED_SHORTCUT): BOOLEAN
			-- Does this group has `a_shortcut'?
		do
			found_item := shortcut (a_shortcut)
			Result := found_item /= Void
		ensure
			has_item_implies_found_item_not_void: Result implies found_item /= Void
		end

feature {MANAGED_SHORTCUT} -- Element change

	add_shortcut (a_shortcut: MANAGED_SHORTCUT)
			-- Add a shortcut to this group.
		require
			not_has: not has (a_shortcut)
		do
			shortcuts.extend (a_shortcut)
		end

	remove_shortcut (a_shortcut: MANAGED_SHORTCUT)
			-- Add a shortcut to this group.
		do
			shortcuts.prune (a_shortcut)
		ensure
			not_exist: not shortcuts.has (a_shortcut)
		end

invariant
	shortcuts_not_void: shortcuts /= Void

note
	copyright:	"Copyright (c) 1984-2014, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
