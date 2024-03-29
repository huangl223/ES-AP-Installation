note
	description:
		"[
			Item for use in EV_LIST and EV_COMBO_BOX.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "list, item, combo"
	date: "$Date: 2017-05-03 15:56:14 +0000 (Wed, 03 May 2017) $"
	revision: "$Revision: 100317 $"

class
	EV_LIST_ITEM

inherit
	EV_ITEM
		redefine
			is_in_default_state,
			implementation,
			default_identifier_name
		end

	EV_TEXTABLE
		undefine
			initialize
		redefine
			is_in_default_state,
			implementation
		end

	EV_DESELECTABLE
			-- These features may only be called when `Current' is parented.
			-- See `is_selectable' from EV_SELECTABLE.
		undefine
			initialize
		redefine
			is_in_default_state,
			implementation
		end

	EV_TOOLTIPABLE
		undefine
			initialize
		redefine
			is_in_default_state,
			implementation
		end

	EV_LIST_ITEM_ACTION_SEQUENCES

create
	default_create,
	make_with_text

feature -- Access

	default_identifier_name: STRING_32
			-- Default `identifier_name' if no specific name is set.
		do
			if attached parent as l_parent then
				create Result.make (5)
				Result.append_character ('#')
				Result.append_integer (l_parent.index_of (Current, 1))
			else
				Result := Precursor {EV_ITEM}
			end
		end

feature -- Obsolete

	align_text_left
			-- Display text left aligned
		obsolete "Was not implemented on all platforms. [2017-05-31]"
		require
			not_destroyed: not is_destroyed
		do
		end

	align_text_center
			-- Display text center aligned
		obsolete "Was not implemented on all platforms. [2017-05-31]"
		require
			not_destroyed: not is_destroyed
		do
		end

	align_text_right
			-- Display text right aligned
		obsolete "Was not implemented on all platforms. [2017-05-31]"
		require
			not_destroyed: not is_destroyed
		do
		end

feature {NONE} -- Contract support

	is_in_default_state: BOOLEAN
			-- Is `Current' in its default state?
		do
			Result := Precursor {EV_ITEM} and precursor {EV_TEXTABLE} and
				Precursor {EV_DESELECTABLE} and precursor {EV_DESELECTABLE}
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	implementation: EV_LIST_ITEM_I
			-- Responsible for interaction with native graphics toolkit.

feature {NONE} -- Implementation

	create_implementation
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_LIST_ITEM_IMP} implementation.make
		end

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




end -- class EV_LIST_ITEM











