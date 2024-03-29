﻿note
	description: "Token that describe one or several tabulations."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"
	date: "$Date: 2018-12-18 18:07:47 +0000 (Tue, 18 Dec 2018) $"
	revision: "$Revision: 102628 $"

class
	EDITOR_TOKEN_TABULATION

inherit
	EDITOR_TOKEN_BLANK
		redefine
			is_tabulation
		end

create
	make

feature -- Initialisation

	make (number: INTEGER)
		require
			number_valid: number > 0
		do
			length := number
			create wide_image.make (number)
			wide_image.fill_character('%T')
		ensure
			wide_image_not_void: wide_image /= Void
			length_positive: length > 0
		end

feature -- Status report

	is_tabulation: BOOLEAN = True
			-- Is current a tabulation token?

feature -- Width & Height

	width: INTEGER
			-- Width in pixel of the entire token.
		local
			l_tab_width: INTEGER
		do
			l_tab_width := tabulation_width

				-- Width of first tabulation.
			Result := (((position // l_tab_width) + 1 ) * l_tab_width) - position

				-- Handle next tabulations.
			Result := Result + (l_tab_width * (length - 1))
		end

	get_substring_width (n: INTEGER): INTEGER
			-- Conpute the width in pixels of the first
			-- `n' characters of the current string.
		local
			l_tab_width: INTEGER
		do
			if n = 0 then
				Result := 0
			else
				l_tab_width := tabulation_width

					-- Width of first tabulation.
				Result := (((position // l_tab_width) + 1 ) * l_tab_width) - position

					-- Handle next tabulations.
				Result := Result + l_tab_width * (n - 1)
			end
		end

	retrieve_position_by_width (a_width: INTEGER): INTEGER
			-- Return the character situated under the `a_width'-th
			-- pixel.
		local
			width_first_tab: INTEGER
			l_tab_width: INTEGER
		do
			l_tab_width := tabulation_width
			width_first_tab := (((position // l_tab_width) + 1 ) * l_tab_width ) - position

			if a_width < width_first_tab then
				Result := 1
			else
				Result := 2 + (a_width - width_first_tab) // l_tab_width
			end
		end

feature -- Visitor

	process (a_visitor: TOKEN_VISITOR)
			-- Visitor
		do
			a_visitor.process_editor_token_tabulation (Current)
		end

feature {NONE} -- Implementation

	display_blanks (d_x, d_y: INTEGER; device: EV_DRAWABLE; selected: BOOLEAN; start_tab, end_tab: INTEGER; panel: TEXT_PANEL): INTEGER
		local
			the_text_color: EV_COLOR
			the_background_color: EV_COLOR
			local_width: INTEGER
			symbol_position: INTEGER
			view_tabulation_symbol: BOOLEAN
			i: INTEGER
			local_position: INTEGER
		do
 				-- Initialisations
 			view_tabulation_symbol := panel.view_invisible_symbols
 			local_position := d_x

 				-- Select the drawing style we will use.
 			if selected then
 				if panel.has_focus then
	 				the_text_color := selected_text_color
	 				the_background_color := selected_background_color
	 			else
	 				the_text_color := text_color
	 				the_background_color := focus_out_selected_background_color
 				end
 			else
 				the_text_color := text_color
 				the_background_color := background_color
 			end

 				-- Backup drawing style & set the new one
 			device.set_font (font)
 			device.set_foreground_color (the_text_color)
			if the_background_color /= Void then
				device.set_background_color (the_background_color)
			end

 				-- Display the first tabulation
 			from
 				i := start_tab
 			until
 				i > end_tab
 			loop
 					-- Compute the width of the tabulation
 				if i = 1 then
 					local_width := get_substring_width (1)
 				else
 					local_width := tabulation_width
 				end

 					-- Compute the position of the tabulation symbol
 				if view_tabulation_symbol then
 					symbol_position := local_position + ( local_width - tabulation_symbol_width ) // 2
 				end

 					-- Fill the rectangle occupied by the tabulation
				if the_background_color /= Void then
	 				device.clear_rectangle(local_position, d_y, local_width, height)
				end

 					-- Display the tabulation symbol
 				if view_tabulation_symbol then
 					draw_text_top_left (symbol_position, d_y, tabulation_symbol, device)
 				end

 					-- update the local position & prepare next iteration
 				local_position := local_position + local_width
 				i := i + 1

 				Result := local_position
 			end
		end

feature {NONE} -- Private characteristics & constants

	tabulation_width: INTEGER
			-- Compute the number of pixels represented by a tabulation based on
			-- user preferences number of spaces per tabulation.
		do
			if is_fixed_width then
				Result := editor_preferences.tabulation_spaces * font_width
			else
				Result := editor_preferences.tabulation_spaces * font.string_width (once " ").max (1)
			end
		end

	tabulation_symbol_width: INTEGER
			-- Compute the number of pixels represented by the tabulation symbol.
		do
			Result := font.string_width (tabulation_symbol)
		end

	tabulation_symbol: STRING = "»";
			-- Symbol for tabulation when formatting marks are shown.

note
	copyright:	"Copyright (c) 1984-2018, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
