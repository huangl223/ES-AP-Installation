note
	description: "EiffelVision push button. Mswindows implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2017-03-27 17:23:22 +0000 (Mon, 27 Mar 2017) $"
	revision: "$Revision: 100056 $"

class
	EV_BUTTON_IMP

inherit
	EV_BUTTON_I
		redefine
			interface
		end

	EV_PRIMITIVE_IMP
		undefine
			set_default_minimum_size
		redefine
			on_key_down,
			make,
			interface,
			update_current_push_button,
			on_mouse_enter,
			on_mouse_leave,
			fire_select_actions_on_enter
		end

	EV_TEXT_ALIGNABLE_IMP
		redefine
			set_default_minimum_size,
			align_text_center,
			align_text_left,
			align_text_right,
			interface
		end

	EV_PIXMAPABLE_IMP
		redefine
			set_pixmap,
			remove_pixmap,
			interface
		end

	EV_FONTABLE_IMP
		redefine
			interface,
			set_font
		end

	WEL_BS_CONSTANTS
		export
			{NONE} all
		end

	WEL_BM_CONSTANTS
		export
			{NONE} all
		end

	WEL_DRAWING_ROUTINES

	WEL_BITMAP_BUTTON
		rename
			make as wel_make,
			parent as wel_parent,
			set_parent as wel_set_parent,
			shown as is_displayed,
			destroy as wel_destroy,
			item as wel_item,
			enabled as is_sensitive,
			width as wel_width,
			height as wel_height,
			x as x_position,
			y as y_position,
			move as wel_move,
			resize as wel_resize,
			move_and_resize as wel_move_and_resize,
			text as wel_text,
			set_text as wel_set_text,
			font as wel_font,
			set_font as wel_set_font,
			background_color as wel_background_color,
			foreground_color as wel_foreground_color,
			has_capture as wel_has_capture
		undefine
			set_width,
			set_height,
			on_left_button_down,
			on_middle_button_down,
			on_right_button_down,
			on_left_button_up,
			on_middle_button_up,
			on_right_button_up,
			on_left_button_double_click,
			on_middle_button_double_click,
			on_right_button_double_click,
			on_mouse_move,
			on_mouse_wheel,
			on_set_focus,
			on_desactivate,
			on_kill_focus,
			on_key_down,
			on_key_up,
			on_char,
			on_set_cursor,
			on_size,
			show,
			hide,
			x_position,
			y_position,
			wel_background_color,
			wel_foreground_color,
			on_sys_key_down,
			on_sys_key_up,
			default_process_message,
			on_getdlgcode,
			on_wm_dropfiles
		redefine
			default_style,
			on_bn_clicked,
			wel_set_text,
			on_erase_background,
			on_wm_theme_changed
		end

	WEL_THEME_PBS_CONSTANTS
		export
			{NONE} all
		end

	WEL_THEME_PART_CONSTANTS
		export
			{NONE} all
		end

	WEL_ODS_CONSTANTS
		export
			{NONE} all
		end

	WEL_SHARED_METRICS
		export
			{NONE} all
		end

create
	make

feature -- Initialization

	old_make (an_interface: attached like interface)
			-- Create `Current' with interface `an_interface'.
		do
			assign_interface (an_interface)
		end

	make
			-- Initialize `Current'.
		do
			wel_make (default_parent, "", 0, 0, 0, 0, 0)
			extra_width := 20
			text_alignment := default_alignment
				-- Retrieve the theme for the button.
			open_theme := application_imp.theme_drawer.open_theme_data (wel_item, "Button")
			Precursor {EV_PRIMITIVE_IMP}
			set_default_font
		end

feature -- Access

	extra_width: INTEGER
			-- Extra width on the size.

	is_default_push_button: BOOLEAN
			-- Is this button currently a default push button
			-- for a particular container?

feature -- Status setting

	set_default_minimum_size
			-- Reset `Current' to its default minimum size.
		local
			font_imp: detachable EV_FONT_IMP
			w,h: INTEGER
			l_text: like wel_text
		do
			l_text := wel_text
			if not l_text.is_empty then
				if private_font /= Void then
					font_imp ?= private_font.implementation
					check
						font_not_void: font_imp /= Void then
					end
					w := extra_width + font_imp.string_width (l_text)
					h := h.max (19 * font_imp.height // 9)
				elseif attached private_wel_font as l_private_wel_font then

					w := extra_width + l_private_wel_font.string_width (l_text)
					h := h.max (19 * l_private_wel_font.height // 9)
				else
					check False end
				end
			end


			if pixmap_imp /= Void and then attached private_pixmap as l_private_pixmap then
				if l_text.is_empty then
					w := l_private_pixmap.width + pixmap_border * 2
				else
					w := w + l_private_pixmap.width + pixmap_border
				end
				h := h.max (l_private_pixmap.height + pixmap_border * 2)
			end
			if l_text.is_empty and pixmap_imp = Void then
				w := w + extra_width
				h := h + internal_default_height
			end

				-- Finally, we set the minimum values.
			ev_set_minimum_size (w, h, False)
		end

	align_text_left
			-- Display `text' with alignment to left of `Current'.
		local
			new_style: INTEGER
		do
			new_style := clear_flag (style, Bs_center)
			new_style := clear_flag (new_style, Bs_right)
			new_style := set_flag (new_style, Bs_left)
			set_style (new_style)

			text_alignment := {EV_TEXT_ALIGNMENT_CONSTANTS}.Ev_Text_alignment_left
			invalidate
		end

	align_text_right
			-- Display `text' with alignment to right of `Current'.
		local
			new_style: INTEGER
		do
			new_style := clear_flag (style, Bs_center)
			new_style := clear_flag (new_style, Bs_left)
			new_style := set_flag (new_style, Bs_right)
			set_style (new_style)

			text_alignment := {EV_TEXT_ALIGNMENT_CONSTANTS}.Ev_Text_alignment_right
			invalidate
		end

	align_text_center
			-- -- Display `text' with alignment in center of `Current'.
		local
			new_style: INTEGER
		do
			new_style := clear_flag (style, Bs_right)
			new_style := clear_flag (new_style, Bs_left)
			new_style := set_flag (new_style, Bs_center)
			set_style (new_style)

			text_alignment := {EV_TEXT_ALIGNMENT_CONSTANTS}.Ev_Text_alignment_center
			invalidate
		end

	enable_default_push_button
			-- Set the style "default_push_button" of `Current'.
		do
			is_default_push_button := True
			if internal_bitmap /= Void then
				invalidate
			else
				{WEL_API}.send_message (wel_item, bm_setstyle,
					to_wparam (style | bs_defpushbutton),
					cwin_make_long (1, 0))
			end
		end

	disable_default_push_button
			-- Remove the style "default_push_button"  of `Current'.
		do
			is_default_push_button := False
			if flag_set (style, bs_ownerdraw) then
				invalidate
			else
				{WEL_API}.send_message (wel_item, bm_setstyle,
					to_wparam (style & bs_defpushbutton.bit_not),
					cwin_make_long (1, 0))
			end
		end

	enable_can_default
			--| Implementation only needed for GTK
		do
			--| Do nothing as this is the default on Win32.
		end

feature -- Element change

	set_pixmap (pix: EV_PIXMAP)
			-- Make `pix' the pixmap of `Current'.
		local
			internal_pixmap_state: detachable EV_PIXMAP_IMP_STATE
			l_internal_bitmap: detachable WEL_BITMAP
			font_imp: detachable EV_FONT_IMP
			size_difference: INTEGER
			l_private_pixmap: like private_pixmap
		do
			l_private_pixmap := pix.twin
			private_pixmap := l_private_pixmap
			if not text.is_empty then
				if attached private_font as l_private_font then
					font_imp ?= l_private_font.implementation
					check
						font_not_void: font_imp /= Void then
					end
					size_difference := font_imp.string_width (wel_text)
				elseif attached private_wel_font as l_private_wel_font then
					size_difference := l_private_wel_font.string_width (wel_text)
				else
					check False end
				end
			end

			internal_pixmap_state ?= l_private_pixmap.implementation
			check internal_pixmap_state /= Void then end
			l_internal_bitmap := internal_pixmap_state.get_bitmap
			internal_bitmap := l_internal_bitmap
			l_internal_bitmap.decrement_reference
			set_default_minimum_size
			invalidate
		end

	set_font (ft: EV_FONT)
			-- Make `ft' new font of `Current'.
		do
			Precursor {EV_FONTABLE_IMP} (ft)
			set_default_minimum_size
		end

	remove_pixmap
			-- Remove `pixmap' from `Current'.
		do
			Precursor {EV_PIXMAPABLE_IMP}
			set_default_minimum_size
			invalidate
		end

	wel_set_text (txt: READABLE_STRING_GENERAL)
			-- Assign `txt' to `text' of `Current'.
		do
			Precursor {WEL_BITMAP_BUTTON} (txt)
			set_default_minimum_size
		end

feature {NONE} -- Implementation, focus event

	internal_default_height: INTEGER
			-- The default minimum height of `Current' with no text.
		do
			Result := 7
		end

	update_current_push_button
			-- Update the current push button
			--
			-- Current is a push button, so we set it to be
			-- the current push button.
		local
			top_level_dialog_imp: detachable EV_DIALOG_I
		do
			top_level_dialog_imp ?= application_imp.window_with_focus
			if top_level_dialog_imp /= Void then
				top_level_dialog_imp.set_current_push_button (interface)
			else
					-- Current is not in a dialog so Current should not
					-- have the `is_default_push_button' flag.
				disable_default_push_button
			end
		end

	fire_select_actions_on_enter
			-- Call select_actions to respond to Enter key press if
			-- Current supports it.
		do
			if is_sensitive then
				if select_actions_internal /= Void and then not select_actions_internal.is_empty then
					select_actions_internal.call (Void)
				end
			end
		end

feature {NONE} -- WEL Implementation

	default_style: INTEGER
			-- Default style used to create `Current'.
		do
			Result := ws_visible | ws_child | ws_group | ws_tabstop | Ws_clipchildren | Ws_clipsiblings | Bs_ownerdraw
		end

	on_bn_clicked
			-- `Current' has been pressed.
		do
			if select_actions_internal /= Void then
				select_actions_internal.call (Void)
			end
		end

	on_key_down (virtual_key, key_data: INTEGER)
			-- A key has been pressed.
		do
			process_navigation_key (virtual_key)
			Precursor {EV_PRIMITIVE_IMP} (virtual_key, key_data)
		end

	on_wm_theme_changed
			-- WM_THEMECHANGED message received so update current theme object.
		do
			application_imp.theme_drawer.close_theme_data (open_theme)
			application_imp.update_theme_drawer
			open_theme := application_imp.theme_drawer.open_theme_data (wel_item, "Button")
		end

	open_theme: POINTER
		-- Theme currently open for `Current'. May be Void while running on Windows versions that
		-- do no support theming.

feature {EV_ANY_I} -- Drawing implementation

	has_pushed_appearence (state: INTEGER): BOOLEAN
			-- Should `Current' have the appearence of being
			-- pressed?
		do
			Result := flag_set (state, Ods_selected)
		end

	pixmap_border: INTEGER = 4
		-- spacing between image and edge of `Current'.

	focus_rect_border: INTEGER = 3
		-- Distance of focus rectangle from edge of button.

	internal_background_brush: WEL_BRUSH
			-- `Result' is background brush to be used for `Current'.
		local
			color_imp: detachable EV_COLOR_IMP
			color: EV_COLOR
		do
			color_imp := background_color_imp
			if color_imp = Void then
				create color
				color_imp ?= color.implementation
				check color_imp /= Void then end
				color_imp.set_with_system_id ({WEL_COLOR_CONSTANTS}.Color_btnface)
			end
			create Result.make_solid (color_imp)
		end

	on_draw_item (draw_item: WEL_DRAW_ITEM_STRUCT)
			-- Wm_drawitem message received. We must now draw `Current'
			-- ourselves with the information in `draw_item'.
		local
			dc: WEL_CLIENT_DC
				-- Temporary dc for quicker access to that of `draw_item'.
			text_rect: WEL_RECT
				-- Rect used to draw the text of `Current'.
			internal_pixmap_state: detachable EV_PIXMAP_IMP_STATE
				-- Pixmap state used to retrieve information about the pixmap of `Current', Void
				-- if there is no pixmap.
			wel_bitmap: detachable WEL_BITMAP
				-- Bitmap used to draw `internal_pixmap_state' on `Current' if it is not Void.
			l_rect: WEL_RECT
				-- Rect of `Current' retrieved from `draw_item'.
			focus_rect: WEL_RECT
				-- Rect used to draw focus rect. Is `l_rect' inflated negatively, using `focus_rect_border'.
			state: INTEGER
				-- State of `Current' as retrieved from `draw_item'.
			memory_dc: WEL_DC
				-- Dc used to perform all drawing on. This cuts out the flicker that would be present if
				-- we did not buffer the drawing.
			font_imp: detachable EV_FONT_IMP
				-- Temporary font implementation used when retrieving font of `Current'.
			height_offset: INTEGER
				-- If `internal_pixmap_state' is not Void, this is used to find the number of pixels vertically from
				-- the top of `Current' to where the pixmap should be drawn.
			color_imp: detachable EV_COLOR_IMP
				-- Temporary color implementation.
			image_width, image_height: INTEGER
				-- Width/height of current image, or 0 when `internal_pixmap_state' is Void.
			text_width: INTEGER
				-- Width of text on `Current', or 0 if there is no text.
			image_pixmap_space: INTEGER
				-- Space between image and text.
			combined_width: INTEGER
				-- Width of image + image_pixmap_space + text.
			left_position: INTEGER
				-- Horizontal position to begin drawing either the image, or text. Note that if both are set,
				-- this will be the start of the image, as the text is always to the right.
			right_spacing: INTEGER
				-- spacing required on right had side of image and text.
				-- Equal to `image_pixmap_space' when there is a text, or
				-- `pixmap_border' // 2 when there is no text.
			left_spacing: INTEGER
				-- spacing required on left had side of image and text.
				-- Equal to `image_pixmap_space' when there is a text, or
				-- `pixmap_border' // 2 when there is no text.
			mask_bitmap: detachable WEL_BITMAP
				-- Mask bitmap of current image.
			l_background_brush: detachable WEL_BRUSH

			color_ref: WEL_COLOR_REF
			coordinate: EV_COORDINATE
			drawstate: INTEGER
				-- Drawstate of the button.
			theme_drawer: EV_THEME_DRAWER_IMP
				-- Theme drawer currently in use.
			l_internal_brush: WEL_BRUSH
			l_is_remote: BOOLEAN
			l_icon: WEL_ICON
		do
			theme_drawer := application_imp.theme_drawer
			l_is_remote := metrics.is_remote_session

				-- Local access to information in `draw_item'.
			dc := draw_item.dc
			l_rect := draw_item.rect_item
			state := draw_item.item_state

			if l_is_remote then
				memory_dc := dc
			else
					-- Create `memory_dc' for double buffering, and select
					-- a bitmap compatible with `dc' ready for drawing.
				create {WEL_MEMORY_DC} memory_dc.make_by_dc (dc)
				create wel_bitmap.make_compatible (dc, l_rect.width, l_rect.height)
				memory_dc.select_bitmap (wel_bitmap)
				wel_bitmap.dispose
			end

				-- Now set both the font and background colors of `memory_dc'.
			color_imp ?= background_color.implementation
			check
				color_imp_not_void: color_imp /= Void then
			end
			memory_dc.set_background_color (color_imp)
				-- We are unable to query the font directly from `dc', so we set it ourselves.
			if private_font /= Void then
				font_imp ?= private_font.implementation
				check
					font_not_void: font_imp /= Void then
				end
				memory_dc.select_font (font_imp.wel_font)
			elseif attached private_wel_font as l_private_wel_font then
				memory_dc.select_font (l_private_wel_font)
			else
				check False end
			end

					-- Calculate the draw state flags and then draw the background
			if has_pushed_appearence (state) then
				drawstate := pbs_pressed
			else
				if not is_sensitive then
					drawstate := pbs_disabled
				elseif flag_set (state, ods_hotlight) or mouse_on_button then
						--| FIXME This is a big hack as `mouse_on_button' is used as we do not seem to
						--| get the ODS_HOTLIGHT notification?
					drawstate := pbs_hot
				elseif flag_set (state, Ods_focus) or else (is_default_push_button and then attached top_level_window_imp as l_top_level_window_imp and then l_top_level_window_imp.has_focus) then
					drawstate := pbs_defaulted
				else
					drawstate := pbs_normal
				end
			end

				-- Need to first clear the area to the background color of `parent_imp'
			if attached {EV_WEL_CONTROL_CONTAINER_IMP} parent_imp as l_parent then
				l_parent.set_is_theme_background_requested (True)
				theme_drawer.draw_theme_parent_background (wel_item, memory_dc, l_rect, Void)
				l_parent.set_is_theme_background_requested (False)
			end

				-- We set the text color of `memory_dc' to white, so that if we are
				-- a toggle button, and must draw the checked background, it uses white combined with
				-- the current background color. We then restore the original `text_color' back into `memory_dc'.
			color_ref := memory_dc.text_color
			memory_dc.set_text_color (white)

			l_internal_brush := internal_background_brush
			theme_drawer.draw_theme_background (open_theme, memory_dc, bp_pushbutton, drawstate, l_rect, Void, l_internal_brush)
			l_internal_brush.delete

			memory_dc.set_text_color (color_ref)

			create focus_rect.make (l_rect.left, l_rect.top, l_rect.right, l_rect.bottom)
			create text_rect.make (l_rect.left, l_rect.top, l_rect.right, l_rect.bottom)
			focus_rect.inflate (-focus_rect_border, -focus_rect_border)

			if has_pushed_appearence (state) then
				drawstate := ods_selected
			else
				if is_default_push_button then
					drawstate := ods_default
				else
					drawstate := ods_grayed
				end
			end

				-- Draw the edge of the button.
			theme_drawer.draw_button_edge (memory_dc, drawstate, text_rect)

				-- If there is a pixmap on `Current', then assign its implementation to
				--`internal_pixmap_state' and store its width in `image_width'.
			if attached private_pixmap as l_private_pixmap then
				internal_pixmap_state ?= l_private_pixmap.implementation
				check internal_pixmap_state /= Void then end
					-- Compute values for re-sizing
				image_width := internal_pixmap_state.width
				image_height := internal_pixmap_state.height
			end

				-- Compute width required to display `text' of `Current', and
				-- aassign it to `text_width'.
			text_width := memory_dc.tabbed_text_size (text).width

				-- Compute number of pixels space between an image and a text. This is also
				-- used as the extra spacing on each side of the text of `Current'.
			image_pixmap_space := extra_width // 2

				-- Calculate `combined_space', `right_space', and `left_space' for
				-- all three cases :- text only, pixmap only or both.
			if text.is_empty then
				combined_width := image_width
				right_spacing := pixmap_border
				left_spacing := pixmap_border
			elseif private_pixmap = Void then
				combined_width := text_width
				right_spacing := image_pixmap_space
				left_spacing := image_pixmap_space
			else
				image_pixmap_space := pixmap_border

				combined_width := image_width + text_width + image_pixmap_space
				left_spacing := (width - combined_width) // 2

				right_spacing := left_spacing
			end

				-- Calculate `left_position' which is the offset in pixels from the left of the button
				-- to draw the first graphical element. If a pixmap is set in `Current', then it will always be the first,
				-- as the text is always aligned to the right of the pixmap.
			if text_alignment = {EV_TEXT_ALIGNMENT_CONSTANTS}.ev_text_alignment_left then
				left_position := left_spacing
			elseif text_alignment = {EV_TEXT_ALIGNMENT_CONSTANTS}.ev_text_alignment_center then
				left_position := (width - combined_width) // 2 - ((right_spacing - left_spacing) // 2)
			elseif text_alignment = {EV_TEXT_ALIGNMENT_CONSTANTS}.ev_text_alignment_right then
				left_position := width - combined_width - right_spacing
			end

				-- Now assign the left edge of the text rectangle.
				-- Note that if there is no image, `image_width' is 0, and we do not
				-- add on `image_pixmap_space'.
			text_rect.set_left (left_position + image_width + ((private_pixmap /= Void).to_integer * image_pixmap_space))

			theme_drawer.update_button_text_rect_for_state (open_theme, state, text_rect)

			if foreground_color_imp /= Void then
				color_imp := foreground_color_imp
			else
				color_imp ?= default_foreground_color_imp
			end
			check color_imp /= Void then end
			theme_drawer.draw_text (open_theme, memory_dc, bp_pushbutton, pbs_normal, wel_text, dt_left | dt_vcenter | dt_singleline, is_sensitive, text_rect, color_imp)

				-- If we have a pixmap set on `Current', then we must draw it.
			if internal_pixmap_state /= Void then
					-- Compute distance from top of button to display image.
				height_offset := (height - internal_pixmap_state.height - pixmap_border * 2) // 2
					-- Retrieve the image of `Current'.

				wel_bitmap := internal_bitmap
				check wel_bitmap /= Void then end
					-- Perform the drawing.
				if internal_pixmap_state.has_mask then
					mask_bitmap := internal_pixmap_state.get_mask_bitmap
				end
					-- Modify the coordinates of the image one pixel to right
					-- and one pixel down if the button is currently depressed.

				create coordinate.make (left_position, pixmap_border + height_offset)
				theme_drawer.update_button_pixmap_coordinates_for_state (open_theme, state, coordinate)

				if attached disabled_image as l_disabled_image then
						-- GDI+ is installed, convert image to WEL_ICON and use icon rendering as this handles alpha data.
					l_icon := internal_pixmap_state.build_icon
					color_imp ?= background_color.implementation
					check
						color_imp_not_void: color_imp /= Void then
					end
					if not is_sensitive then
						l_disabled_image.draw_grayscale_bitmap_or_icon_with_memory_buffer (wel_bitmap, l_icon, memory_dc, coordinate.x, coordinate.y, color_imp, internal_pixmap_state.has_mask)
					else
							-- In this way it creating the icon resource on each draw.
							-- This could be done with GDI+ features, however it will create {WEL_GDIP_IMAGE} on each draw
						memory_dc.draw_icon_ex (l_icon, coordinate.x, coordinate.y, image_width, image_height, 0, Void, 0x3) -- 0x3 = DI_NORMAL (DI_IMAGE | DI_MASK)
					end
					l_icon.dispose
				else
					theme_drawer.draw_bitmap_on_dc (memory_dc, wel_bitmap, mask_bitmap, coordinate.x, coordinate.y, is_sensitive)
				end
			end

				-- If `Current' has the focus, then we must draw the focus rectangle.
			if flag_set (state, ods_focus) then
					-- If `is_default_push_button' then `Current' is being
					-- drawn as the focused button in a dialog. We must move
					-- `focus_rect' away from the extra thick border.
				if is_default_push_button then
					focus_rect.inflate (-1, -1)
				end
				draw_focus_rect (memory_dc, focus_rect)
			end

			if not l_is_remote then
					-- Copy the image from `memory_dc' to `dc' which is the dc originally provided
					-- in `draw_item_state'.
				dc.bit_blt (l_rect.left, l_rect.top, l_rect.width, l_rect.height, memory_dc, 0, 0, {WEL_RASTER_OPERATIONS_CONSTANTS}.Srccopy)
			end
				-- Clean up GDI objects created.
			memory_dc.unselect_all
			memory_dc.delete
			if l_background_brush /= Void then
				l_background_brush.delete
			end
			if mask_bitmap /= Void then
				mask_bitmap.decrement_reference
			end
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

	on_erase_background (paint_dc: WEL_PAINT_DC; invalid_rect: WEL_RECT)
			-- Wm_erase_background message has been received by Windows.
			-- We must override the default processing, as if we do not, then
			-- Windows will draw the background for us, even though it is not needed.
			-- This causes flicker.
		do
			disable_default_processing
			set_message_return_value (to_lresult (1))
		end

	white: WEL_COLOR_REF
			-- `Result' is color corresponding to white
		once
			Create Result.make_rgb (255, 255, 255)
		end

	default_foreground_color_imp: EV_COLOR_IMP
			-- Default foreground color for widgets.
		local
			l_result: detachable EV_COLOR_IMP
		once
			l_result ?= (create {EV_STOCK_COLORS}).default_foreground_color.implementation
			check l_result /= Void then end
			Result := l_result
		ensure
			result_not_void: result /= Void
		end

	mouse_on_button: BOOLEAN
		-- Is the mouse pointer currently held above `Current'? Used as
		-- a temporary hack until it can be found why Ods_hottrack does not seem to
		-- be sent when it should.

	on_mouse_enter
			-- Called when the mouse enters `Current'.
		do
			Precursor {EV_PRIMITIVE_IMP}
			mouse_on_button := True
			invalidate
		end

	on_mouse_leave
			-- Called when the mouse leaves `Current'.
		do
			Precursor {EV_PRIMITIVE_IMP}
			mouse_on_button := False
			invalidate
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_BUTTON note option: stable attribute end;

note
	copyright:	"Copyright (c) 1984-2017, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class EV_BUTTON_IMP
