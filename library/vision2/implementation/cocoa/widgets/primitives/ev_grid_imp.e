note
	description: "[
		Widget which is a combination of an EV_TREE and an EV_MULTI_COLUMN_LIST.
		Cocoa implementation.
			]"
	copyright:	"Copyright (c) 2009, Daniel Furrer"
	date: "$Date: 2019-03-11 13:20:02 +0000 (Mon, 11 Mar 2019) $"
	revision: "$Revision: 102950 $"

class
	EV_GRID_IMP

inherit
	EV_GRID_I
		undefine
			propagate_background_color,
			propagate_foreground_color
		redefine
			interface
		end

	EV_CELL_IMP
		rename
			item as cell_item
		undefine
			drop_actions,
			has_focus,
			set_focus,
			set_pebble,
			set_pebble_function,
			conforming_pick_actions,
			pick_actions,
			pick_ended_actions,
			set_accept_cursor,
			set_deny_cursor,
			enable_capture,
			disable_capture,
			has_capture,
			set_default_colors,
			set_default_key_processing_handler,
			set_pick_and_drop_mode,
			set_drag_and_drop_mode,
			set_target_menu_mode,
			set_configurable_target_menu_mode,
			set_configurable_target_menu_handler,
			tooltip,
			set_tooltip
		redefine
			interface,
			make,
			old_make,
			set_background_color,
			set_foreground_color
		end

	NS_STRING_CONSTANTS

create
	make

feature {NONE} -- Initialization

	old_make (an_interface: attached like interface)
			-- Create grid
		do
			assign_interface (an_interface)
		end

	make
			-- Initialize `Current'
		local
			l_color: detachable NS_COLOR
		do
			create_implementation_objects

			create focused_selection_color.make_with_rgb (1, 0, 0)

			create l_color.selected_text_background_color
			l_color := l_color.color_using_color_space_name (create {NS_STRING}.make_with_string ("NSDeviceRGBColorSpace"))
			if attached l_color then
				create non_focused_selection_color.make_with_rgb (l_color.red_component, l_color.green_component, l_color.blue_component)
			else
				-- FIXME: What to do in this case ?
				create non_focused_selection_color
			end

			create focused_selection_text_color.make_with_rgb (0, 1, 0)
			create l_color.selected_text_color
			l_color := l_color.color_using_color_space_name (create {NS_STRING}.make_with_string ("NSDeviceRGBColorSpace"))
			if attached l_color then
				create non_focused_selection_text_color.make_with_rgb (l_color.red_component, l_color.green_component, l_color.blue_component)
			else
				-- FIXME
				create non_focused_selection_text_color
			end

			create cocoa_view.make
			Precursor {EV_CELL_IMP}
			initialize_grid

			set_is_initialized (True)
		end

feature -- Element change

	set_background_color (a_color: EV_COLOR)
			-- Assign `a_color' to `background_color'
		do
			Precursor {EV_CELL_IMP} (a_color)
			redraw_client_area
		end

	set_foreground_color (a_color: EV_COLOR)
			-- Assign `a_color' to `foreground_color'
		do
			Precursor {EV_CELL_IMP} (a_color)
			redraw_client_area
		end

feature {EV_GRID_ITEM_I} -- Implementation

	string_size (a_string: READABLE_STRING_GENERAL; a_font: EV_FONT; tuple: TUPLE [INTEGER, INTEGER])
			-- `Result' contains width and height required to
			-- fully display string `s' in font `f'.
			-- This should be used instead of `string_size' from EV_FONT
			-- as we can perform an optimized implementation which does
			-- not include the horizontal overhang or underhang. This can
			-- make quite a difference on certain platforms.
		local
			l_font_imp: detachable EV_FONT_IMP
			l_string: NS_STRING
			l_attributes: NS_DICTIONARY
			l_size: NS_SIZE
		do
			if a_string.is_empty then
				tuple.put_integer (0, 1)
				tuple.put_integer (0, 2)
			else
				l_font_imp ?= a_font.implementation
				check l_font_imp /= void then end
				create l_string.make_with_string (a_string)
				create l_attributes.make_with_object_for_key (l_font_imp.font, font_attribute_name)
				l_size := l_string.size_with_attributes (l_attributes)

				tuple.put_integer (l_size.width.rounded, 1)
				tuple.put_integer (l_size.height.rounded, 2)
			end
		end

	color_from_state (style_type, a_state: INTEGER): EV_COLOR
			-- Return color of either fg or bg representing `a_state'
		local
			a_r, a_g, a_b: INTEGER
		do
				-- Style is cached so it doesn't need to be unreffed.
			create Result
			Result.set_rgb_with_16_bit (a_r, a_g, a_b)
		end

	text_style, base_style, fg_style, bg_style: INTEGER = unique

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_GRID note option: stable attribute end;
			-- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'.

note
	copyright: "Copyright (c) 1984-2019, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
