note
	description:
		"[
			Linear widget container.
			Base class for EV_HORIZONTAL_BOX and EV_VERTICAL_BOX
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "box, container, child"
	date: "$Date: 2008-12-29 20:27:11 +0000 (Mon, 29 Dec 2008) $"
	revision: "$Revision: 76420 $"

deferred class 
	EV_BOX

inherit
	EV_WIDGET_LIST
		redefine
			implementation,
			is_in_default_state
		end
		
	EV_DOCKABLE_TARGET
		undefine
			is_equal
		redefine
			implementation,
			is_in_default_state
		end

feature -- Status report

	is_homogeneous: BOOLEAN
			-- Are all items forced to have same dimensions.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.is_homogeneous
		ensure
			bridge_ok: Result = implementation.is_homogeneous
		end

	border_width: INTEGER
			-- Width of border around container in pixels.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.border_width
		ensure
			bridge_ok: Result = implementation.border_width
			positive: Result >= 0
		end

	padding_width, padding: INTEGER
			-- Space between children in pixels.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.padding
		ensure
			bridge_ok: Result = implementation.padding
			positive: Result >= 0
		end 

feature -- Status report

	is_item_expanded (an_item: EV_WIDGET): BOOLEAN
			-- Is `an_item' expanded to occupy available spare space?
		require
			not_destroyed: not is_destroyed
			has_an_item: has (an_item)
		do
			Result := implementation.is_item_expanded (an_item)
		ensure
			bridge_ok: Result = implementation.is_item_expanded (an_item)
		end

feature -- Status setting
	
	enable_homogeneous
			-- Force all items to have same dimensions.
		require
			not_destroyed: not is_destroyed
		do
			implementation.set_homogeneous (True)
		ensure
			is_homogeneous: is_homogeneous
		end

	disable_homogeneous
			-- Allow items to have different dimensions.
		require
			not_destroyed: not is_destroyed
		do
			implementation.set_homogeneous (False)
		ensure
			not_is_homogeneous: not is_homogeneous
		end

	set_border_width (value: INTEGER)
			-- Assign `value' to `border_width'.
		require
			not_destroyed: not is_destroyed
			positive_value: value >= 0
		do
			implementation.set_border_width (value)
		ensure
			border_width_assigned: border_width = value
		end

	set_padding_width, set_padding (value: INTEGER)
			-- Assign `value' to `padding_width'.
		require
			not_destroyed: not is_destroyed
			positive_value: value >= 0
		do
			implementation.set_padding (value)
		ensure
			padding_assigned: padding = value
		end

	enable_item_expand (an_item: EV_WIDGET)
			-- Expand `an_item' to occupy available spare space.
		require
			not_destroyed: not is_destroyed
			has_an_item: has (an_item)
		do
			implementation.set_child_expandable (an_item, True)
		ensure
			an_item_expanded: is_item_expanded (an_item)
		end

	disable_item_expand (an_item: EV_WIDGET)
			-- Do not expand `an_item' to occupy available spare space.
		require
			not_destroyed: not is_destroyed
			has_an_item: has (an_item)
		do
			implementation.set_child_expandable (an_item, False)
		ensure
			not_an_item_expanded: not is_item_expanded (an_item)
		end
		
feature {EV_ANY} -- Contract support

	is_in_default_state: BOOLEAN
			-- Is `Current' in its default state.
		do
			Result := Precursor {EV_WIDGET_LIST} and (
				not is_homogeneous and
				border_width = 0 and
				padding = 0			
			)
		end

feature {EV_ANY, EV_ANY_I} -- Implementation
	
	implementation: EV_BOX_I;
			-- Responsible for interaction with native graphics toolkit.
			
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




end -- class EV_BOX

