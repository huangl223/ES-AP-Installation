note
	description:
		"Abstract notion of a checkable/uncheckable menu item."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2014-05-21 03:43:47 +0000 (Wed, 21 May 2014) $"
	revision: "$Revision: 95131 $"

deferred class
	EV_CHECKABLE_MENU_ITEM_IMP

inherit
	ANY

	WEL_CONSTANTS
		export
			{NONE} all
		end

	WEL_SHARED_FONTS
		export
			{NONE} all
		end

	WEL_SYSTEM_COLORS
		export
			{NONE} all
		end

	WEL_STANDARD_COLORS
		export
			{NONE} all
		end

feature -- Access

	pixmap_imp: detachable EV_PIXMAP_IMP_STATE
			-- Implementation of pixmap in `Current'.
		deferred
		end

feature -- Status report

	is_selected: BOOLEAN
			-- Is this menu item checked?
		deferred
		end

feature -- Status setting

	enable_select
			-- Select this menu item.
		deferred
		end

	disable_select
			-- Unselect this menu item.
		deferred
		end

feature {EV_CONTAINER_IMP, EV_MENU_IMP} -- WEL Implementation

	on_draw_menu_item_left_part (draw_item_struct: WEL_DRAW_ITEM_STRUCT)
			-- Process `Wm_drawitem' message, for the left part.
			-- In the left part, one draw the pixmap, check state..
			-- or nothing.
		local
			draw_dc: WEL_CLIENT_DC
			draw_item_struct_rect: WEL_RECT
			draw_item_state: INTEGER
			left_pos, top_pos, bottom_pos: INTEGER
			selected_state, disabled_state, checked_state: BOOLEAN
			rect: WEL_RECT
			background_color: WEL_COLOR_REF
		do
			draw_dc := draw_item_struct.dc
			draw_item_struct_rect := draw_item_struct.rect_item
			draw_item_state := draw_item_struct.item_state
			left_pos := draw_item_struct_rect.left
			top_pos := draw_item_struct_rect.top
			bottom_pos := draw_item_struct_rect.bottom
			selected_state := (draw_item_state & Wel_ownerdraw_constants.Ods_selected /= 0)
			disabled_state := (draw_item_state & Wel_ownerdraw_constants.Ods_disabled /= 0)
			checked_state := (draw_item_state & Wel_ownerdraw_constants.Ods_checked /= 0)

			create rect.make (0, 0, 0, 0)
			if pixmap_imp /= Void then
					-- First erase the background
				if selected_state then
					rect.set_rect (left_pos, top_pos, left_pos + plain_text_position - 2, bottom_pos)
					erase_background (draw_dc, rect, system_color_highlight)

					rect.set_rect (left_pos + plain_text_position - 2, top_pos, left_pos + plain_text_position, bottom_pos)
					erase_background (draw_dc, rect, system_color_highlight)
				else
					rect.set_rect (left_pos, top_pos, left_pos + plain_text_position, bottom_pos)
					erase_background (draw_dc, rect, system_color_menu)
				end
					-- Then draw the pixmap
				draw_pixmap (draw_dc, draw_item_struct_rect, checked_state, selected_state, disabled_state)
			else
					-- When selected, erase the background where the pixmap is with highlight background.
				rect.set_rect (left_pos, top_pos, left_pos + plain_text_position, bottom_pos)
				if selected_state then
					background_color := system_color_highlight
				else
					background_color := system_color_menu
				end
				erase_background (draw_dc, rect, background_color)

					-- Draw the check mark
				if checked_state then
					draw_check_mark (draw_dc, rect, selected_state, disabled_state)
				end
			end
		end

feature {NONE} -- WEL Implementation

	plain_text_position: INTEGER
			-- Position in pixels where the plain text starts being written.
		deferred
		end

	draw_check_mark (draw_dc: WEL_DC; rect: WEL_RECT; selected, disabled: BOOLEAN)
			-- Draw the check mark
		local
			check_dc: WEL_MEMORY_DC
			check_bitmap: WEL_BITMAP
			memory_rect: WEL_RECT
			text_height: INTEGER
			foreground_color: WEL_COLOR_REF
			background_color: WEL_COLOR_REF
			l_real_text: like real_text
		do
			l_real_text := real_text
			check l_real_text /= Void then end
			text_height := menu_font.string_height (l_real_text)
			create memory_rect.make (0, 0, rect.width, text_height)

			create check_dc.make
			create check_bitmap.make_compatible (check_dc, rect.width, rect.height)
			check_dc.select_bitmap (check_bitmap)
			check_dc.draw_frame_control (memory_rect, Wel_drawing_constants.Dfc_menu, check_mark_bitmap_constant)

			if selected then
				background_color := system_color_highlight
			else
				background_color := system_color_menu
			end

			if disabled and not selected and system_color_menu.same_color (system_color_btnface) then
					-- Draw the embossed check mark
				draw_dc.set_background_color (background_color)
				draw_dc.set_text_color (system_color_btnhighlight)
				draw_dc.bit_blt (1 + rect.left, 1 + rect.top + (rect.height - text_height) // 2, rect.width, text_height, check_dc, 0, 0, Wel_drawing_constants.Srccopy)

					-- Draw the main check mark
				draw_dc.set_text_color (Black)
				draw_dc.set_background_color (White)
				draw_dc.bit_blt (rect.left, rect.top + (rect.height - text_height) // 2, rect.width, text_height, check_dc, 0, 0, Wel_drawing_constants.Srcand)

				draw_dc.set_text_color (system_color_btnshadow)
				draw_dc.set_background_color (Black)
				draw_dc.bit_blt (rect.left, rect.top + (rect.height - text_height) // 2, rect.width, text_height, check_dc, 0, 0, Wel_drawing_constants.Srcpaint)
			else
				if disabled then
					foreground_color := system_color_btnshadow
					if foreground_color.same_color (system_color_highlight) then
						foreground_color := system_color_btnhighlight
					end
				elseif selected then
					foreground_color := system_color_highlighttext
				else
					foreground_color := system_color_menutext
				end
				draw_dc.set_background_color (background_color)
				draw_dc.set_text_color (foreground_color)
				draw_dc.bit_blt (rect.left, rect.top + (rect.height - text_height) // 2, rect.width, text_height, check_dc, 0, 0, Wel_drawing_constants.Srccopy)
			end
			check_dc.unselect_bitmap
			check_dc.delete
			check_bitmap.delete
		end

	draw_pixmap (draw_dc: WEL_DC; rect: WEL_RECT; checked, selected, disabled: BOOLEAN)
			-- Draw the pixmap.
		local
			wel_icon: WEL_ICON
			icon_top_position, icon_left_position: INTEGER
			draw_flags: INTEGER
			edge_rect: WEL_RECT
			hlc: WEL_COLOR_REF
			l_bitmap: WEL_BITMAP
			l_pixmap_imp: like pixmap_imp
		do
				-- Draw an edge around the pixmap when it is selected
			create edge_rect.make (rect.left, rect.top, rect.left + plain_text_position - 2, rect.bottom)
			if checked then
				create hlc.make_by_color (contrast_color (system_color_menu).item)
				draw_dc.draw_edge (edge_rect, Wel_drawing_constants.Bdr_sunkenouter, Wel_drawing_constants.Bf_rect)
			elseif selected and not disabled then
				create hlc.make_by_color (contrast_color (system_color_highlight).item)
			end
			edge_rect.dispose

			l_pixmap_imp := pixmap_imp
			check l_pixmap_imp /= Void then end

				-- Draw the pixmap
			icon_top_position := (rect.top + rect.bottom - l_pixmap_imp.height - 2) // 2
			icon_left_position := 1 + rect.left
			if checked then
				icon_top_position := icon_top_position + 1
				icon_left_position := icon_left_position + 1
			end
			if disabled then
				draw_flags := Wel_drawing_constants.Dss_disabled
			else
				draw_flags := Wel_drawing_constants.Dss_normal
			end
			wel_icon := extract_icon (l_pixmap_imp)
			if disabled and then attached disabled_image as l_disabled_image then
				if selected then
					create hlc.make_by_color (contrast_color (system_color_highlight).item)
				else
					create hlc.make_by_color (contrast_color (system_color_menu).item)
				end
				l_bitmap := l_pixmap_imp.get_bitmap
				l_disabled_image.draw_grayscale_bitmap_or_icon_with_memory_buffer (l_bitmap, wel_icon, draw_dc, icon_left_position, icon_top_position, hlc, l_pixmap_imp.has_mask)
				l_bitmap.decrement_reference
			else
				draw_dc.draw_state_icon (Void, wel_icon, icon_left_position, icon_top_position, draw_flags)
			end
			wel_icon.decrement_reference
		ensure
			rect_ok: rect.left = old rect.left and
					rect.top = old rect.top and
					rect.right = old rect.right and
					rect.bottom = old rect.bottom
		end

	disabled_image: detachable WEL_GDIP_GRAYSCALE_IMAGE_DRAWER
			-- Grayscale image drawer.
			-- Void if Gdi+ not installed.
		local
			l_gdip_starter: WEL_GDIP_STARTER
		once
			create l_gdip_starter
			if l_gdip_starter.is_gdi_plus_installed then
				create Result
			end
		end

	contrast_color (a_color: WEL_COLOR_REF): WEL_COLOR_REF
			-- New color which is either slightly lighter or darker than
			-- `a_color'.
		require
			a_color_not_void: a_color /= Void
		do
			create Result.make
			if a_color.red < 220 then
				Result.set_red (a_color.red + 20)
			else
				Result.set_red ((a_color.red - 20).max (0))
			end
			if a_color.green < 220 then
				Result.set_green (a_color.green + 20)
			else
				Result.set_green ((a_color.green - 20).max (0))
			end
			if a_color.blue < 220 then
				Result.set_blue (a_color.blue + 20)
			else
				Result.set_blue ((a_color.blue - 20).max (0))
			end
		ensure
			contrast_color_not_void: Result /= Void
		end

	erase_background (a_dc: WEL_DC; a_rect: WEL_RECT; a_background_color: WEL_COLOR_REF)
			-- Erase the background for the rectangle `a_rect' using the
			-- Device context `a_dc'. If `hilited_state' is set, use the
			-- background color corresponding to the hilited state.
		deferred
		end

	check_mark_bitmap_constant: INTEGER
			-- Constant coding for the check mark used in Current.
		deferred
		ensure
			valid_result: Result = Wel_drawing_constants.Dfcs_menucheck or
				Result = Wel_drawing_constants.Dfcs_menubullet
		end

feature {NONE} -- Implementation

	real_text: detachable STRING_32
			-- Text of `Current' as is.
		deferred
		end

	parent_imp: detachable EV_MENU_ITEM_LIST_IMP
			-- The menu or menu-bar this item is in.
		deferred
		end

	extract_icon (a_pixmap_imp_state: EV_PIXMAP_IMP_STATE): WEL_ICON
			-- Extract the icon from `pixmap_imp'.
		deferred
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




end -- class EV_CHECKABLE_ITEM_IMP











