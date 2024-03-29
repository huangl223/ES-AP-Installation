﻿note
	description: "[
			Objects that contain all structures required for buffering RTF for saving/loading/implementation.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2020-05-12 19:25:53 +0000 (Tue, 12 May 2020) $"
	revision: "$Revision: 104177 $"

class
	EV_RICH_TEXT_BUFFERING_STRUCTURES_I

inherit
	ANY

	EV_RICH_TEXT_CONSTANTS_I
		export
			{NONE} all
		end

	EV_FONT_CONSTANTS
		export
			{NONE} all
		end

create
	set_rich_text

feature -- Status Setting

	set_rich_text (a_rich_text: EV_RICH_TEXT_I)
			-- Assign `a_rich_text' to `rich_text' and initialize buffering structures.
		require
			a_rich_text_not_void: a_rich_text /= Void
		do
			clear_structures
			rich_text := a_rich_text
		end

	clear_structures
			-- Clear all structures used for buffering into RTF format.
		do
				-- Rebuild structures used for buffering RTF.
			create start_formats.make (default_structure_size)
			create end_formats.make (default_structure_size)
			create formats.make (default_structure_size)
			create formats_index.make (default_structure_size)
			create heights.make (default_structure_size)
			create hashed_formats.make (default_structure_size)
			create format_offsets.make (default_structure_size)

				-- Rebuild structures used for optimizing contents of RTF.
				-- i.e. those that prevent repeated fonts and colors from being defined.
			create hashed_colors.make (default_structure_size)
			create color_offset.make (default_structure_size)
			create back_color_offset.make (default_structure_size)
			create hashed_fonts.make (default_structure_size)
			create font_offset.make (default_structure_size)

				-- Reset all other attributes used by buffering.			
			create internal_text.make (default_structure_size)
			is_current_format_underlined := False
			is_current_format_striked_through := False
			is_current_format_bold := False
			is_current_format_italic := False
			current_vertical_offset := 0
			color_text := color_table_start.twin
			font_text := font_table_start.twin
			font_count := 0
			color_count := 0
			create buffered_text.make_empty
		end

	initialize_for_saving
			-- Initialize `Current' for saving'.
		do
			clear_structures
		end

	append_text_for_rtf (a_text: READABLE_STRING_GENERAL; a_format: EV_CHARACTER_FORMAT_I)
			-- Append RTF representation of `a_text' with format `a_format' to `internal_text'
			-- and store information required from `a_format' ready for completion of buffering.
		local
			hashed_character_format: detachable STRING_8
			temp_string: STRING_32
			format_index: INTEGER
			vertical_offset, counter: INTEGER
			character_code: CHARACTER_32
			format_underlined, format_striked, format_bold, format_italic: BOOLEAN
			height_in_half_points: INTEGER
		do
			hashed_character_format := a_format.attached_interface.hash_value
			check hashed_character_format /= Void then end
			if not hashed_formats.has (hashed_character_format) then
				hashed_formats.put (a_format.attached_interface, hashed_character_format)
				formats.extend (a_format.attached_interface)

					-- Rich text requires font heights to be in half points, so
					-- multiply by 2.
				heights.extend (a_format.height_in_points * 2)
				format_offsets.put (hashed_formats.count, hashed_character_format)

				build_color_from_format (a_format)

				build_font_from_format (a_format)
			end

			format_index := format_offsets.item (hashed_character_format)

			create temp_string.make (128)
			if a_format.bcolor_set then
					-- Only apply highlighting if a highlight color was explicitly set.
				add_rtf_keyword (temp_string, rtf_highlight_string)
				temp_string.append_integer (back_color_offset.i_th (format_index))
			end
			add_rtf_keyword (temp_string, rtf_color_string)
			temp_string.append_integer (color_offset.i_th (format_index))

			format_underlined := a_format.is_underlined
			if not is_current_format_underlined and format_underlined then
				add_rtf_keyword (temp_string, rtf_underline_string)
				is_current_format_underlined := True
			elseif is_current_format_underlined and not format_underlined then
				add_rtf_keyword (temp_string, rtf_underline_string + "0")
				is_current_format_underlined := False
			end
			format_striked := a_format.is_striked_out
			if not is_current_format_striked_through and format_striked then
				add_rtf_keyword (temp_string, rtf_strikeout_string)
				is_current_format_striked_through := True
			elseif is_current_format_striked_through and not format_striked then
				add_rtf_keyword (temp_string, rtf_strikeout_string + "0")
				is_current_format_striked_through := False
			end
			format_bold := a_format.is_bold
			if not is_current_format_bold and format_bold then
				add_rtf_keyword (temp_string, rtf_bold_string)
				is_current_format_bold := True
			elseif is_current_format_bold and not format_bold then
				add_rtf_keyword (temp_string, rtf_bold_string + "0")
				is_current_format_bold := False
			end
			format_italic := a_format.shape = shape_italic
			if not is_current_format_italic and format_italic then
				add_rtf_keyword (temp_string, rtf_italic_string)
				is_current_format_italic := True
			elseif is_current_format_italic and not format_italic then
				add_rtf_keyword (temp_string, rtf_italic_string + "0")
				is_current_format_italic := False
			end
			vertical_offset := a_format.vertical_offset
			if vertical_offset /= current_vertical_offset then
				add_rtf_keyword (temp_string, rtf_vertical_offset)
				height_in_half_points := (pixels_to_half_points (vertical_offset))
				temp_string.append_integer (height_in_half_points)
				current_vertical_offset := vertical_offset
			end

			add_rtf_keyword (temp_string, rtf_font_string)
			temp_string.append_integer (font_offset.i_th (format_index))
			add_rtf_keyword (temp_string, rtf_font_size_string)
			temp_string.append_integer (heights.i_th (format_index))
			temp_string.append (space_string)
			internal_text.append (temp_string)
			from
				counter := 1
			until
				counter > a_text.count
			loop
				character_code := a_text.item (counter)
				if character_code = '%N' then
					add_rtf_keyword (internal_text, rtf_newline + "%N")
				elseif character_code = '\' then
					internal_text.append (rtf_backslash)
				elseif character_code = '{' then
					internal_text.append (rtf_open_brace)
				elseif character_code = '}' then
					internal_text.append (rtf_close_brace)
				elseif character_code.natural_32_code <= {CHARACTER_8}.max_value.to_natural_32 then
					internal_text.append_character (character_code)
				else
					internal_text.append (rtf_unicode_character)
					internal_text.append_natural_32 (character_code.natural_32_code)
						-- Add ANSI representation of the Unicode characters for
						-- those who cannot read Unicode characters.
					internal_text.append_character ('?')
				end
				counter := counter + 1
			end
		end

	rich_text: detachable EV_RICH_TEXT_I
			-- Rich text associated with `Current'.

	internal_text: STRING_32
			-- Text used for building RTF strings internally before buffering or saving.

feature {EV_ANY_I} -- Status Setting

	generate_paragraph_information (a_text: READABLE_STRING_GENERAL)
			-- `Result' is index of first character of every line in `a_text' upon
			-- which the paragraph formatting changes, as determined by '%N'.
		require
			text_not_void: a_text /= Void
		local
			counter: INTEGER
			l_rich_text: like rich_text
		do
			l_rich_text := rich_text
			check l_rich_text /= Void then end
			create paragraph_start_indexes.make (50)
			create paragraph_formats.make (50)

				-- Add the first line which is always 1.
			paragraph_start_indexes.extend (1)

			build_paragraph_from_format (l_rich_text.internal_paragraph_format (1))
				-- Now iterate `a_string' and determine each line as determined by `%N'.
			from
				counter := 1
			until
				counter > a_text.count
			loop
				if counter < a_text.count - 1 and then a_text.item (counter) = '%N' then
					if not l_rich_text.internal_paragraph_format_contiguous (counter, counter + 2) then
							-- Note that we checked "counter + 2" as we find the %N that signifies a new line, and then
							-- we must add one to convert to caret positions, and one to check that we are checking the first character
							-- of the next line (past the %N) to determine if the format changed.
						paragraph_start_indexes.extend (counter + 1)
						build_paragraph_from_format (l_rich_text.internal_paragraph_format (counter + 1))
					end
				end
				counter := counter + 1
			end
		ensure
			start_indexes_not_void: paragraph_start_indexes /= Void
			formats_not_void: paragraph_formats /= Void
			count_greater_or_equal_to_one: paragraph_start_indexes.count >= 1
			counts_equal: paragraph_start_indexes.count = paragraph_formats.count
		end

	set_with_rtf (rtf_text: STRING)
			-- Set `text' and formatting of `Current' from `rtf_text' in RTF format.
		require
			rtf_text_not_void: rtf_text /= Void
			rtf_text_not_empty: not rtf_text.is_empty
		local
			current_character: CHARACTER_32
			found_opening_brace: BOOLEAN
			paragraph_format: detachable EV_PARAGRAPH_FORMAT
			last_load_value, current_load_value,
			key_index, keys_count: INTEGER
			l_rich_text: like rich_text
			l_current_format: like current_format
		do
			l_rich_text := rich_text
			check l_rich_text /= Void then end

			last_load_successful := True
			if rtf_text.item (1) = rtf_open_brace_character then
				create format_stack.make (8)
				create all_fonts.make (50)
				create all_colors.make (50)
					-- If there are no color table in the RTF, we default to the
					-- foreground color of `rich_text'.
				all_colors.force (l_rich_text.foreground_color, 0)
				create all_formats.make (50)
				create all_paragraph_formats.make (50)
				create all_paragraph_indexes.make (50)
				create all_paragraph_format_keys.make (50)
				highest_read_char := 0
				number_of_characters_opened := 0
				current_depth := 0
				first_color_is_auto := False
				last_colorred := -1
				last_colorgreen := -1
				last_colorblue := -1
					-- These three values are set to -1 as we use this to determine
					-- if the auto color is set as color 0 in the color table.
				create l_current_format
				current_format := l_current_format

				create plain_text.make_empty

				from
					main_iterator := 1
				until
					main_iterator > rtf_text.count or (found_opening_brace and current_depth = 0)
				loop
					current_character := get_character (rtf_text, main_iterator)
					if found_opening_brace then
						if current_character = '{' then
								-- Store state on stack
							format_stack.extend (l_current_format.twin)
						elseif current_character = '}' then
								-- retrieve state from stack.
							l_current_format := format_stack.item
							current_format := l_current_format
							format_stack.remove
						elseif current_character = '\' then
							process_keyword (rtf_text, main_iterator)

						elseif main_iterator >= 2 and then current_character /= '%R' and
							(rtf_text.item (main_iterator - 1) = '%N' or
							rtf_text.item (main_iterator - 1) = '}' or
							rtf_text.item (main_iterator - 1) = '{') then
								-- We are now one character past the tag for the text. This may occur when a keyword
								-- is ended with a '%N' or we have just skipped a bracket section that contained the "\*"
								-- keyword. As in this case, `current_character' is the start of the text, call `process_text'
								-- from the previous position, as the first index is ignored.
							process_text (rtf_text, main_iterator - 1)
						elseif current_character = ' '  then
							process_text (rtf_text, main_iterator)
						end
					elseif current_character = '{' then
							-- Store state on stack
						format_stack.extend (l_current_format.twin)
						found_opening_brace := True
					end

					move_main_iterator (1)
						-- Move the iterator by one. This may or may not be required
						-- if other routines have just called it within this loop.

					update_main_iterator

					if l_rich_text.file_access_actions_internal /= Void then
							-- Here we update the `file_access_actions' with the range 0-90
							-- for the character formatting.
						current_load_value := (main_iterator * 90) // rtf_text.count
						if current_load_value /= last_load_value then
								-- Fire the `file_access_actions' only if changed.	
							last_load_value := current_load_value
							l_rich_text.file_access_actions.call ([current_load_value])
						end
					end
				end
				check
					no_carriage_returns: not plain_text.has ('%R')
				end
				l_rich_text.flush_buffer
				keys_count := all_paragraph_format_keys.count
				from
					all_paragraph_format_keys.start
				until
					all_paragraph_format_keys.off
				loop
					key_index := all_paragraph_format_keys.index
					paragraph_format := all_paragraph_formats.item (all_paragraph_format_keys.item)
					check paragraph_format /= Void then end
					if key_index < keys_count then
						l_rich_text.format_paragraph (all_paragraph_indexes.i_th (key_index), all_paragraph_indexes.i_th (key_index + 1), paragraph_format)
					else
						l_rich_text.format_paragraph (all_paragraph_indexes.i_th (key_index), l_rich_text.text_length, paragraph_format)
					end

					if l_rich_text.file_access_actions_internal /= Void then
							-- Here we update the `file_access_actions' with the range 90-100 for the
							-- paragraph formatting.
						current_load_value := 90 + ((key_index * 10) // keys_count)
						if current_load_value /= last_load_value then
								-- Fire the `file_access_actions' only if changed.	
							last_load_value := current_load_value
							l_rich_text.file_access_actions.call ([current_load_value])
						end
					end
					all_paragraph_format_keys.forth
				end
			else
				last_load_successful := False
			end
		end

	last_load_successful: BOOLEAN
		-- Was last call to `set_with_rtf' successful?

	generate_complete_rtf_from_buffering
			-- Generate the rtf heading for buffered operations into `internal_text'.
			-- Current contents of `internal_text' are lost.
		local
			old_internal_text: like internal_text
		do
				-- `font_text' contents is generated by each call to `buffered_append',
				-- so simply close the tag.
			font_text.append_character ('}')

				-- `color_text' contents is generated by each call to `buffered_append',
				-- so simply close the tag.
			color_text.append_character ('}')

			old_internal_text := internal_text
			create internal_text.make (old_internal_text.count + font_text.count)
			internal_text.append (font_text)
			internal_text.append_string_general ("%R%N")
			internal_text.append (color_text)
			internal_text.append_string_general ("%R%N")
			internal_text.append (old_internal_text)
			internal_text.append_character ('}')
			internal_text.append_string_general ("%R%N")
		end

feature {NONE} -- Implementation		

	process_text (rtf_text: STRING; index: INTEGER)
			-- Process RTF string `rtf_text' for text data from `index' until
			-- text is exhausted signified through encountering a control character.
		require
			rtf_text_not_void: rtf_text /= Void
			valid_index: rtf_text.valid_index (index)
		local
			l_index: INTEGER
			text_completed: BOOLEAN
			current_text: STRING_32
			current_character: CHARACTER_32
			next_character: CHARACTER
			l_new_line, l_carriage_return, l_closed_parenthesis, l_open_parenthesis, l_backslash: CHARACTER_32
		do
			create current_text.make (128)
			from
				l_index := 1
				l_new_line := '%N'
				l_carriage_return := '%R'
				l_closed_parenthesis := '}'
				l_open_parenthesis := '{'
				l_backslash := '\'
			until
				text_completed or l_index + index > rtf_text.count
			loop
				current_character := get_character (rtf_text, l_index + index)
				if current_character /= l_new_line and current_character /= l_carriage_return then
						-- New line characters have no effect on the RTF contents, so
						-- simply ignore these characters.
					if current_character = l_closed_parenthesis then
						text_completed := True
					elseif current_character = l_open_parenthesis then
						text_completed := True
							-- If the text is ending with `{', we reduce
							-- the offset by one so that the `{' is included within
							-- the main iteration
						l_index := l_index - 1
					elseif current_character = l_backslash then
						next_character := rtf_text.item (l_index + index + 1)
							-- The following three characters are reserved in RTF, and therefore
							-- if they appear in the text they must be escaped with the '\'.
							-- We perform this here.
						if next_character = l_closed_parenthesis or else next_character = l_open_parenthesis or else next_character = l_backslash then
							current_character := next_character
							l_index := l_index + 1
						else
							text_completed := True
							l_index := l_index - 1
						end
					end
					if not text_completed then
						current_text.append_character (current_character)
					end
				end
				l_index := l_index + 1
			end
			if current_text.count > 0 then
				move_main_iterator (l_index - 1)
				buffer_formatting (current_text)
			end
		end

	buffer_formatting (a_text: STRING_32)
			-- Buffer `a_text' into `rich_text' with formatting applied from `current_format'.
		require
			a_text_not_void: a_text /= Void
			a_text_not_empty: not a_text.is_empty
		local
			character_format: detachable EV_CHARACTER_FORMAT
			a_font: EV_FONT
			effects: EV_CHARACTER_FORMAT_EFFECTS
			paragraph_format: EV_PARAGRAPH_FORMAT
			l_current_format: like current_format
			l_rich_text: like rich_text
		do
			l_current_format := current_format
			check l_current_format /= Void then end

			l_rich_text := rich_text
			check l_rich_text /= Void then end

			if attached all_formats as l_formats then
				character_format := l_formats.item (l_current_format.character_format_out)
				if character_format = Void then
						-- Only create a new character format if an equivalent one does not already
						-- exist in `all_formats'.
					create character_format

					if first_color_is_auto and l_current_format.text_color = 0 then
						character_format.set_color (l_rich_text.foreground_color)
					elseif attached all_colors as l_colors and then attached l_colors.item (l_current_format.text_color) as l_color then
						character_format.set_color (l_color)
					end

					if first_color_is_auto and l_current_format.highlight_color = 0 then
						character_format.set_background_color (l_rich_text.background_color)
					elseif l_current_format.highlight_set and then attached all_colors as l_colors and then attached l_colors.item (l_current_format.highlight_color) as l_color then
						character_format.set_background_color (l_color)
					end

					if attached all_fonts as l_fonts and then attached l_fonts.item (l_current_format.character_format) as l_font then
						a_font := l_font.twin
						if l_current_format.is_bold then
							a_font.set_weight ({EV_FONT_CONSTANTS}.weight_bold)
						end
						if l_current_format.is_italic then
							a_font.set_shape ({EV_FONT_CONSTANTS}.shape_italic)
						end
						create effects
						if l_current_format.is_striked_out then
							effects.enable_striked_out
						end
						if l_current_format.is_underlined then
							effects.enable_underlined
						end
						effects.set_vertical_offset (half_points_to_pixels (l_current_format.vertical_offset))
						character_format.set_effects (effects)

							-- RTF uses half points to specify font heights so divide by 2.
						a_font.set_height_in_points (l_current_format.font_height // 2)
						character_format.set_font (a_font)
						l_formats.put (character_format, l_current_format.character_format_out)
					end
				end
			end
			if attached all_paragraph_formats and then (all_paragraph_formats.is_empty or else not all_paragraph_formats.has (l_current_format.paragraph_format_out)) then
				create paragraph_format
				paragraph_format.set_alignment (l_current_format.alignment)
				paragraph_format.set_left_margin (l_current_format.left_margin)
				paragraph_format.set_right_margin (l_current_format.right_margin)
				paragraph_format.set_top_spacing (l_current_format.top_spacing)
				paragraph_format.set_bottom_spacing (l_current_format.bottom_spacing)

				all_paragraph_formats.put (paragraph_format, l_current_format.paragraph_format_out)
			end
			if attached all_paragraph_format_keys and then attached all_paragraph_indexes and then (all_paragraph_format_keys.is_empty or else not all_paragraph_format_keys.last.same_string_general (l_current_format.paragraph_format_out)) then
				all_paragraph_format_keys.extend (l_current_format.paragraph_format_out)
				all_paragraph_indexes.extend (number_of_characters_opened + 1)
			end

			if character_format /= Void then
				l_rich_text.buffered_append (a_text, character_format)
			else
					-- RTF is not valid, we just use the default formatting.
				l_rich_text.buffered_append (a_text, create {EV_CHARACTER_FORMAT})
			end
			number_of_characters_opened := number_of_characters_opened + a_text.count
		end

	get_character (rtf_text: STRING; index: INTEGER): CHARACTER_32
			-- `Result' is character `index' within `rtf_text'.
		require
			rtf_text_not_void: rtf_text /= Void
			valid_index: rtf_text.valid_index (index)
		do
			Result := rtf_text.item (index)
			if index > highest_read_char then
				highest_read_char := index
				if Result = '{' then
					current_depth := current_depth + 1
				elseif Result = '}' then
					current_depth := current_depth - 1
				end
			end
		end

	highest_read_char: INTEGER
		-- Highest character index already read. This prevents us from increasing or
		-- decreasing the "depth" of the document if a "{" or "}" character is read twice.

	process_keyword  (rtf_text: STRING; index: INTEGER)
			-- Process RTF string `rtf_text' for a keyword starting at position `index'
			-- until a rtf character is received signifying the end of the keyword.
		require
			rtf_text_not_void: rtf_text /= Void
			valid_index: rtf_text.valid_index (index)
		local
			l_index: INTEGER
			current_character: CHARACTER_32
			tag, l_char: STRING_32
			tag_value: STRING_32
			performed_one_iteration: BOOLEAN
			tag_completed: BOOLEAN
			reading_tag_value: BOOLEAN
			tag_start_position: INTEGER
			processing_moved_iterator: BOOLEAN
			l_current_format: like current_format
		do
			l_current_format := current_format
			check l_current_format /= Void then end
			tag_start_position := index
			create tag.make_empty
			create tag_value.make_empty
				-- Set to space as default.
			current_character := ' '
			from
				l_index := 1
			until
				tag_completed
			loop
				current_character := get_character (rtf_text, l_index + index)

				inspect current_character
				when ' ', '\', '}', '{', '%N', '%R', ';'  then
					if performed_one_iteration then
							-- Flag the tag as completed so the loop is exited.
							-- This is only set once the tag value has also been read.
						tag_completed := True
					end
				when '0' .. '9' then
					reading_tag_value := True
							-- We have found a digit which signifies the end of the tag, but
							-- the start of the tag value. Not all tags have an INTEGER value.
				else
						-- Do nothing
				end
				if not tag_completed then
					if current_character /= '%N' then
						if not reading_tag_value then
								-- If still reading the tag, add the current character.
							tag.append_character (current_character)
						else
								-- If now reading the tags value, add the current character.
							tag_value.append_character (current_character)
						end
						performed_one_iteration := True
					end
					l_index := l_index + 1
				end
			end

				-- Now process the found keyword.
			if tag.is_equal (tab_tag_string) then
				buffer_formatting (tab_string)
			elseif tag.is_equal (rtf_color_string) then
				l_current_format.set_text_color (tag_value.to_integer)
			elseif tag.is_equal (line_string) then
				buffer_formatting (new_line_string)
			elseif tag.is_equal (rtf_unicode_string) then
					-- Removed ANSI representation of the character
				tag_value.remove_tail (1)
				create l_char.make (1)
				l_char.append_code (tag_value.to_integer_32.as_natural_32)
				buffer_formatting (l_char)
			elseif tag.is_equal (rtf_bold_string) then
				if tag_value.is_empty then
					l_current_format.set_bold (True)
				else
					check
						tag_is_zero: tag_value.same_string_general ("0")
					end
					l_current_format.set_bold (False)
				end
			elseif tag.is_equal (rtf_italic_string) then
				if tag_value.is_empty then
					l_current_format.set_italic (True)
				else
					check
						tag_is_zero: tag_value.same_string_general ("0")
					end
					l_current_format.set_italic (False)
				end
			elseif tag.is_equal (rtf_strikeout_string) then
				if tag_value.is_empty then
					l_current_format.set_striked_out (True)
				else
					check
						tag_is_zero: tag_value.same_string_general ("0")
					end
					l_current_format.set_striked_out (False)
				end
			elseif tag.is_equal (rtf_underline_string) then
				if tag_value.is_empty then
					l_current_format.set_underlined (True)
				else
					check
						tag_is_zero: tag_value.same_string_general ("0")
					end
					l_current_format.set_underlined (False)
				end
			elseif tag.is_equal (rtf_underline_none_string) then
				l_current_format.set_underlined (False)
			elseif tag.is_equal (rtf_vertical_offset) then
				check
					tag_not_empty: not tag.is_empty
				end
				l_current_format.set_vertical_offset (tag_value.to_integer)
			elseif tag.is_equal (rtf_highlight_string) then
				l_current_format.set_highlight_color (tag_value.to_integer)
			elseif tag.is_equal (rtf_red) then
				last_colorred := tag_value.to_integer
			elseif tag.is_equal (rtf_green) then
				last_colorgreen := tag_value.to_integer
			elseif tag.is_equal (rtf_blue) then
				last_colorblue := tag_value.to_integer
			elseif tag.is_equal (rtf_font_string) then
				last_fontindex := tag_value.to_integer
				l_current_format.set_character_format (tag_value.to_integer)
			elseif tag.is_equal (rtf_font_size_string) then
				l_current_format.set_font_height (tag_value.to_integer)
			elseif tag.is_equal (rtf_charset) then
				last_fontcharset := tag_value.to_integer
			elseif tag.is_equal (rtf_family_nill) then
				last_fontfamily := rtf_family_nill_int
			elseif tag.is_equal (rtf_family_modern) then
				last_fontfamily := rtf_family_modern_int
			elseif tag.is_equal (rtf_family_roman) then
				last_fontfamily := rtf_family_roman_int
			elseif tag.is_equal (rtf_family_script) then
				last_fontfamily := rtf_family_script_int
			elseif tag.is_equal (rtf_family_swiss) then
				last_fontfamily := rtf_family_swiss_int
			elseif tag.is_equal (rtf_family_tech) then
				last_fontfamily := rtf_family_tech_int
			elseif tag.is_equal (rtf_font_size_string) then
			elseif tag.is_equal (rtf_newline) then
				buffer_formatting (new_line_string)
			elseif tag.is_equal (rtf_user_props) then
				check
					is_start_of_group: rtf_text.substring (tag_start_position - 1, tag_start_position + 1).same_string_general ("{\*")
				end
				move_to_end_of_tag (rtf_text, tag_start_position - 1)
			elseif tag.is_equal (rtf_info) then
				check
					is_start_of_group: rtf_text.substring (tag_start_position - 1, tag_start_position).same_string_general ("{\")
				end
				move_to_end_of_tag (rtf_text, tag_start_position - 1)
			elseif tag.is_equal (rtf_stylesheet) then
				check
					is_start_of_group: rtf_text.substring (tag_start_position - 1, tag_start_position).same_string_general ("{\")
				end
				move_to_end_of_tag (rtf_text, tag_start_position - 1)
			elseif tag.is_equal (rtf_new_paragraph) then
				l_current_format.reset_paragraph
			elseif tag.is_equal (rtf_paragraph_left_aligned) then
				l_current_format.set_alignment ({EV_PARAGRAPH_CONSTANTS}.alignment_left)
			elseif tag.is_equal (rtf_paragraph_center_aligned) then
				l_current_format.set_alignment ({EV_PARAGRAPH_CONSTANTS}.alignment_center)
			elseif tag.is_equal (rtf_paragraph_right_aligned) then
				l_current_format.set_alignment ({EV_PARAGRAPH_CONSTANTS}.alignment_right)
			elseif tag.is_equal (rtf_paragraph_justified) then
				l_current_format.set_alignment ({EV_PARAGRAPH_CONSTANTS}.alignment_justified)
			elseif tag.is_equal (rtf_paragraph_left_indent) then
				l_current_format.set_left_margin (half_points_to_pixels (tag_value.to_integer) // 10)
			elseif tag.is_equal (rtf_paragraph_right_indent) then
				l_current_format.set_right_margin (half_points_to_pixels (tag_value.to_integer) // 10)
			elseif tag.is_equal (rtf_paragraph_space_before) then
				l_current_format.set_top_spacing (half_points_to_pixels (tag_value.to_integer) // 10)
			elseif tag.is_equal (rtf_paragraph_space_after) then
				l_current_format.set_bottom_spacing (half_points_to_pixels (tag_value.to_integer) // 10)
			elseif tag.is_equal (rtf_fonttable) then
				process_fonttable (rtf_text)
				processing_moved_iterator := True
			elseif tag.is_equal (rtf_colortbl) then
				process_colortable (rtf_text)
				processing_moved_iterator := True
			else
				--print ("Unhandled tag : " + tag.out + "%N")
			end
			if not processing_moved_iterator then
					-- Some keyword processing moves `main_iterator' as part of its processing,
					-- so do nothing in those cases, otherwise move the iterator by the size of the tag.
				move_main_iterator (tag.count + tag_value.count + 1)
			end
		end

	new_line_string: STRING_32 = "%N"
	tab_string: STRING_32 = "%T"
	tab_tag_string: STRING_32 = "tab"
	line_string: STRING_32 = "line"
			-- String constants

	move_to_end_of_tag (rtf_text: STRING; start_index: INTEGER)
			-- Move `main_iterator' to the next character immediately following the closing brace
			-- associated with the opening brace at `start_index' within RTF text `rtf_text'
			-- This includes the depth of the brace, and will find the brace pair, not just the next closing brace.
		require
			rtf_text_not_void: rtf_text /= Void
			valid_index: rtf_text.valid_index (start_index)
			index_points_to_start_tag: rtf_text.item (start_index) = '{'
		local
			l_index: INTEGER
			depth: INTEGER
			current_character: CHARACTER_32
		do
			depth := 1
			from
				l_index := 1
			until
					-- We go one down from the starting position, as we do not include
					-- the first brace in the searched characters.
				depth = 0
			loop
				current_character := get_character (rtf_text, start_index + l_index)
				if current_character = rtf_open_brace_character then
					depth := depth + 1
				elseif current_character = rtf_close_brace_character then
					depth := depth - 1
				end
				if depth /= 0 then
					l_index := l_index + 1
				end
			end
			move_main_iterator (l_index - 1)
		end

	process_fonttable (rtf_text: STRING)
			-- Process fonttable contained in `rtf_text', the contents of which
			-- start at character index `main_iterator'.
		require
			pointing_to_fonttable: rtf_text.substring (main_iterator, main_iterator + rtf_fonttable.count).same_string_general (create {STRING_32}.make_filled (rtf_control_character, 1) + rtf_fonttable)
		local
			depth: INTEGER
			current_character: CHARACTER_32
		do
			depth := 1
			from
				move_main_iterator (1)
			until
				depth = 0
			loop
				update_main_iterator
				current_character := get_character (rtf_text, main_iterator)
				if current_character = '{' then
						-- Store state on stack
					depth := depth + 1
				elseif current_character = '}'  then
					depth := depth - 1
					add_font_to_all_fonts
				elseif current_character = '\' then
					process_keyword (rtf_text, main_iterator)
				elseif current_character = ' ' and then rtf_text.item (main_iterator + 1) /= '\' then
					move_main_iterator (1)
					update_main_iterator
					process_fontname (rtf_text)
					add_font_to_all_fonts
				elseif current_character /= '%R' and (rtf_text.item (main_iterator - 1) = '%N' or rtf_text.item (main_iterator - 1) = '}') then
					process_fontname (rtf_text)
					add_font_to_all_fonts
				end
				move_main_iterator (1)
			end
		end

	add_font_to_all_fonts
			-- Create and add a new font to `all_fonts' at index `last_font_index'
			-- based on `last_fontfamily' and `last_fontname'.
		local
			a_font: EV_FONT
		do
			create a_font
			inspect last_fontfamily
			when rtf_family_roman_int then
				a_font.set_family (family_roman)
			when rtf_family_swiss_int then
				a_font.set_family (family_sans)
			when rtf_family_modern_int then
				a_font.set_family (family_modern)
			when rtf_family_script_int then
				a_font.set_family (family_typewriter)
			when rtf_family_tech_int then
				a_font.set_family (family_screen)
			else
				-- Perform nothing if family is Nill.
			end
				-- It is possible that no font name was specificed in the RTF.
			if attached last_fontname as l_last_fontname and then not l_last_fontname.is_empty then
				a_font.preferred_families.extend (l_last_fontname)
			end
			if attached all_fonts as l_fonts then
				l_fonts.force (a_font, last_fontindex)
			end
		end

	process_colortable (rtf_text: STRING)
			-- Process colortable contained in `rtf_text', the contents of which
			-- start at character index `main_iterator'.
		require
			pointing_to_colortable: rtf_text.substring (main_iterator, main_iterator + rtf_colortbl.count).same_string_general (create {STRING_32}.make_filled (rtf_control_character, 1) + rtf_colortbl)
		local
			depth: INTEGER
			current_character: CHARACTER_32
			a_color: EV_COLOR
			l_colors: like all_colors
		do
			l_colors := all_colors
			depth := 1
			from
				move_main_iterator (1)
			until
				depth = 0
			loop
				update_main_iterator
				current_character := get_character (rtf_text, main_iterator)
				if current_character = '{' then
						-- Store state on stack
					depth := depth + 1
				elseif current_character = '}' then
					depth := depth - 1
				elseif current_character = '\' then
					process_keyword (rtf_text, main_iterator)
				elseif current_character = ';' then
					if last_colorred = initial_color_value and
						last_colorgreen = initial_color_value and
						last_colorblue = initial_color_value then

						create a_color
						first_color_is_auto := True
							-- We have found the auto color so record the fact that there is an auto color.
					elseif l_colors /= Void then
						create a_color.make_with_8_bit_rgb (last_colorred, last_colorgreen, last_colorblue)
						l_colors.force (a_color, last_colorindex)
					end
					last_colorindex := last_colorindex + 1
				end
				move_main_iterator (1)
			end
		end

	first_color_is_auto: BOOLEAN
			-- Color at index `0' in the color table corresponds to the auto color.
			-- Any color references to this color must use either the foreground or
			-- background color of the control, instead of its actual value.

	last_fontname: detachable STRING_32
	last_colorindex: INTEGER
	last_fontindex: INTEGER
	last_fontcharset: INTEGER
	last_fontfamily: INTEGER
	last_colorred: INTEGER
	last_colorgreen: INTEGER
	last_colorblue: INTEGER
			-- Current values read in by parsing RTF.

	all_fonts: detachable HASH_TABLE [EV_FONT, INTEGER] note option: stable attribute end
			-- All fonts retrieved during parsing, accessible through their index in the font table.

	all_colors: detachable HASH_TABLE [EV_COLOR, INTEGER] note option: stable attribute end
			-- All colors retrieved during parsing, accessible through their index in the color table.

	all_formats: detachable HASH_TABLE [EV_CHARACTER_FORMAT, STRING] note option: stable attribute end
			-- All unique formats retreived during parsing.

	all_paragraph_formats: detachable HASH_TABLE [EV_PARAGRAPH_FORMAT, STRING] note option: stable attribute end

	all_paragraph_format_keys: detachable ARRAYED_LIST [STRING] note option: stable attribute end

	all_paragraph_indexes: detachable ARRAYED_LIST [INTEGER] note option: stable attribute end

	number_of_characters_opened: INTEGER

	current_depth: INTEGER
			-- Current depth of rtf parsing as determined by openeing "{" and
			-- closing "}". Valid rtf opens as many as are closed.


	process_fontname (rtf_text: STRING)
			-- Process a font name found in RTF text `rtf_text' starting at position `main_iterator'.
		require
			rtf_text_not_void: rtf_text /= Void
		local
			text_completed: BOOLEAN
			current_text: STRING_32
			current_character: CHARACTER_32
		do
			create current_text.make (50)
			from
			until
				text_completed
			loop
				update_main_iterator
				current_character := get_character (rtf_text, main_iterator)--l_index + index)
				if current_character /= '%N' and current_character /= '%R' then
						-- New line characters have no effect on the RTF contents, so
						-- simply ignore these characters.
					if current_character = ';' or current_character = '}' then
						text_completed := True
					end
					if not text_completed then
						current_text.append_character (current_character)
					end
				end
				if not text_completed then
					move_main_iterator (1)
				else
					if current_character = ';' then
					elseif current_character = '}' then
						temp_iterator := temp_iterator - 1
						main_iterator := main_iterator - 1
					else
						check
							unhandled_condition: False
						end
					end
				end
			end

			last_fontname := current_text
		end


	current_format: detachable RTF_FORMAT_I
		-- The current format retrieved from the RTF.

	format_stack: detachable ARRAYED_STACK [RTF_FORMAT_I] note option: stable attribute end
		-- A stack to hold current formatting for RTF being loaded.
		-- Each set of formatting contained within braces is only local to those braces,
		-- so we pop and push the current formats from the stack as we enter and leave braces.

	main_iterator: INTEGER
		-- The index currently iterated within the RTF file that is being loaded.
		-- This must be accessible to `move_main_iterator'.

	temp_iterator: INTEGER
		-- A temporary value used by `move_main_iterator' to ensure that multiple calls to
		-- move forwards do not move backwards.

	plain_text: detachable STRING_32
			-- A string representation of the contents of from the last
			-- RTF file loaded.
		note
			option: stable
		attribute
		end

	update_main_iterator
			-- Ensure `main_iterator' takes the value of `temp_iterator'.
		do
			main_iterator := temp_iterator
		ensure
			main_iterator_set: main_iterator = temp_iterator
		end

	move_main_iterator (step: INTEGER)
			-- Ensure `main_iterator' is moved `step' characters next time `update_main_iterator' is called.
			-- Each call will not move the iterator back to less than one of the previous calls
			-- as enforced by the value of `temp_iterator'.
			-- i.e. calling `move_main_iterator three times with 5, 12, and 2 as arguments, ensures that
			-- next time `update_main_iterator' is called it will increase by 12.
		require
			step_positive: step > 0
		do
			if main_iterator + step > temp_iterator then
				temp_iterator := main_iterator + step
			end
		ensure
			temp_iterator_moved_forwards: temp_iterator >= old temp_iterator
		end

feature {NONE} -- Implementation

	pixels_to_half_points (pixels: INTEGER): INTEGER
			-- `Result' is pixels converted to half points, being
			-- the meaurement used for font sizes in RTF.
		do
			Result := (pixels * points_per_inch * 2) // screen.vertical_resolution
		end

	half_points_to_pixels (half_points: INTEGER): INTEGER
			-- `Result' is half points converted to pixels.
		do
			Result := half_points * screen.vertical_resolution // (points_per_inch * 2)
		end

	build_paragraph_from_format (a_format: EV_PARAGRAPH_FORMAT)
			-- Add RTF representation of `a_format' to `paragraph_formats' is
		require
			formats_not_void: paragraph_formats /= Void
		local
			format: STRING_32
		do
			create format.make (128)
			add_rtf_keyword (format, rtf_new_paragraph)
			if a_format.is_left_aligned then
				add_rtf_keyword (format, rtf_paragraph_left_aligned)
			elseif a_format.is_center_aligned then
				add_rtf_keyword (format, rtf_paragraph_center_aligned)
			elseif a_format.is_right_aligned then
				add_rtf_keyword (format, rtf_paragraph_right_aligned)
			elseif a_format.is_justified then
				add_rtf_keyword (format, rtf_paragraph_justified)
			end
			if a_format.left_margin /= 0 then
				add_rtf_keyword (format, rtf_paragraph_left_indent)
				format.append_integer (pixels_to_half_points (a_format.left_margin * 10))
			end
			if a_format.right_margin /= 0 then
				add_rtf_keyword (format, rtf_paragraph_right_indent)
				format.append_integer (pixels_to_half_points (a_format.right_margin * 10))
			end
			if a_format.top_spacing /= 0 then
				add_rtf_keyword (format, rtf_paragraph_space_before)
				format.append_integer (pixels_to_half_points (a_format.top_spacing * 10))
			end
			if a_format.bottom_spacing /= 0 then
				add_rtf_keyword (format, rtf_paragraph_space_after)
				format.append_integer (pixels_to_half_points (a_format.bottom_spacing * 10))
			end
			format.append_character (' ')
			if paragraph_formats /= Void then
				paragraph_formats.extend (format)
			end
		ensure
			formats_count_increased: attached paragraph_formats and then paragraph_formats.count = old paragraph_formats.count + 1
		end


	build_font_from_format (a_format: EV_CHARACTER_FORMAT_I)
			-- Update font text `font_text' for addition of a new format to the buffering.
		local
			current_family: INTEGER
			family: STRING_32
			temp_string: STRING_32
		do
			current_family := a_format.family
			inspect current_family
			when family_screen then
				family := rtf_family_tech
			when family_roman then
				family := rtf_family_roman
			when family_sans then
				family := rtf_family_swiss
			when family_typewriter then
				family := rtf_family_script
			when family_modern then
				family := rtf_family_modern
			else
				family := rtf_family_nill
			end
			create temp_string.make (50)
			temp_string.append_character ('\')
			temp_string.append (family)
			temp_string.append_string_general ("\fcharset")
			temp_string.append_integer (a_format.char_set)
			temp_string.append (space_string)
			temp_string.append (a_format.name)
			hashed_fonts.search (temp_string)
			if not hashed_fonts.found then
				font_count := font_count + 1
				hashed_fonts.put (font_count, temp_string)
				font_offset.force (hashed_fonts.found_item)
				font_text.append_string_general ("{\f")
				font_text.append_integer (font_count)
				font_text.append (temp_string)
				font_text.append_string_general (";}")
			else
				font_offset.force (hashed_fonts.item (temp_string))
			end
		end


	build_color_from_format (a_format: EV_CHARACTER_FORMAT_I)
			-- Update color text `color_text' for addition of a new format to the buffering.
		local
			l_color: INTEGER
			hashed_color, hashed_back_color: STRING_32
			red, green, blue: INTEGER
		do
			l_color := a_format.fcolor
			create hashed_color.make_empty
			add_rtf_keyword (hashed_color, rtf_red)
			red := l_color & 0x000000ff
			l_color := l_color |>> 8
			green := l_color & 0x000000ff
			l_color := l_color |>> 8
			blue := l_color & 0x000000ff
			hashed_color.append_integer (red)
			add_rtf_keyword (hashed_color, rtf_green)
			hashed_color.append_integer (green)
			add_rtf_keyword (hashed_color, rtf_blue)
			hashed_color.append_integer (blue)
			hashed_color.append_character (';')


			hashed_colors.search (hashed_color)
				-- If the color does not already exist.
			if not hashed_colors.found then
					-- Add the color to `colors' for later retrieval.
				color_count := color_count + 1
				hashed_colors.put (color_count, hashed_color)
					-- Store the offset from the character index to the new color index for retrieval.
				color_offset.force (hashed_colors.found_item)
				color_text.append (hashed_color)
			else
				color_offset.force (hashed_colors.item (hashed_color))
			end

			l_color := a_format.bcolor
			create hashed_back_color.make_empty
			add_rtf_keyword (hashed_back_color, rtf_red)
			red := l_color & 0x000000ff
			l_color := l_color |>> 8
			green := l_color & 0x000000ff
			l_color := l_color |>> 8
			blue := l_color & 0x000000ff
			hashed_back_color.append_integer (red)
			add_rtf_keyword (hashed_back_color, rtf_green)
			hashed_back_color.append_integer (green)
			add_rtf_keyword (hashed_back_color, rtf_blue)
			hashed_back_color.append_integer (blue)
			hashed_back_color.append_character (';')

			hashed_colors.search (hashed_back_color)
				-- If the color does not already exist.
			if not hashed_colors.found then
				-- Add the color to `colors' for later retrieval.
				color_count := color_count + 1
				hashed_colors.put (color_count, hashed_back_color)
					-- Store the offset from the character index to the new color index for retrieval.
				back_color_offset.force (hashed_colors.found_item)
				color_text.append (hashed_back_color)
			else
				back_color_offset.force (hashed_colors.item (hashed_back_color))
			end
		end

feature {NONE} -- Implementation

	add_rtf_keyword (a_string, a_keyword: STRING_32)
			-- Add rtf representation of `rtf_control_character' and keyword `a_keyword' to `a_string'.
		require
			string_not_void: a_string /= Void
			keyword_not_void: a_keyword /= Void
		do
			a_string.append_character (rtf_control_character)
			a_string.append (a_keyword)
		ensure
			count_increased: old a_string.count + a_keyword.count + 1 = a_string.count
		end


feature {EV_ANY_I} -- Implementation

	paragraph_start_indexes: detachable ARRAYED_LIST [INTEGER] note option: stable attribute end
		-- Indexes of every paragraph format change in a document in order.
		-- Call `generate_paragraph_information' to fill.

	paragraph_formats: detachable ARRAYED_LIST [STRING_32] note option: stable attribute end
		-- A string representation of Each paragraph change found in
		-- `paragraph_start_indexes'. Call `generate_paragraph_information' to fill.

feature {NONE} -- Implementation

	default_structure_size: INTEGER = 20
		-- Default size used to initalize all buffering structures.

	default_string_size: INTEGER = 50000
		-- Default size used for all internal strings for buffering.
		-- This reduces the need to resize the string as the formatting is applied.
		-- Resizing strings can be slow, so is to be avoided wherever possible.

	-- `hashed_formats', `format_offsets' and `color_offsets' are only used in the
	-- buffered append operations, while the other lists and hash tables are used
	-- in the buffered formatting operations.

	hashed_formats: HASH_TABLE [EV_CHARACTER_FORMAT, STRING]
			-- A list of all character formats to be applied to buffering, accessible
			-- through `hash_value' of EV_CHARACTER_FORMAT. This ensures that repeated formats
			-- are not stored multiple times.

	format_offsets: HASH_TABLE [INTEGER, STRING]
			-- The index of each format in `hashed_formats' within the RTF document that must be generated.
			-- For each set of formatting that must be applied, a reference to the format in the document
			-- must be specified, and this table holds the appropriate offset of that formatting.

	buffered_text: STRING_32
		-- Internal representation of `text' used only when flushing the buffers. Prevents the need
		-- to stream the contents of `current', every time that the `text' is needed.

	lowest_buffered_value, highest_buffered_value: INTEGER
		-- Used when applying a buffered format, these values represent the lowest and highest character indexes
		-- that have been buffered. This allows implementations to only stream between these indexes if possible.

	formats: ARRAYED_LIST [EV_CHARACTER_FORMAT]
			-- All character formats used in `Current'.

	heights: ARRAYED_LIST [INTEGER]
			-- All heights of formats used in `Current', corresponding to contents of `forrmats'.

	formats_index: HASH_TABLE [INTEGER, INTEGER]
			-- The index of each format relative to a paticular character index. This permits the correct
			-- format to be looked up when the start positions of the formats are traversed.

	start_formats: HASH_TABLE [STRING, INTEGER]
			-- The format type applicable at a paticular character position. The `item' is used to look up the
			-- character format from `hashed_formats'.

	end_formats: HASH_TABLE [STRING, INTEGER]
			-- The format type applicable at a paticular character position. The integer represents the index of the
			-- closing caret index.

			-- These attributes are used to stop multiple versions of the same color being
			-- generated in the RTF.

	hashed_colors: HASH_TABLE [INTEGER, STRING_32]
			-- All colors currently stored for buffering, accessible via the
			-- actual RTF output, in the form ";\red255\green0\blue0". The integer `item'
			-- corresponds to the offset of the color in `colors'.

	color_offset: ARRAYED_LIST [INTEGER]
			-- All color indexes to use for foreground colors in document,
			-- indexed by their corresponding character format index.
			-- So, for example, item 20 would correspond to the color offset to use from
			-- the color table for the 20th character format.

	back_color_offset: ARRAYED_LIST [INTEGER]
			-- All color indexes to use for background colors in document,
			-- indexed by their corresponding character format index.
			-- So, for example, item 20 would correspond to the color offset to use from
			-- the color table for the 20th character format.

	color_count: INTEGER
		-- Number of colors currently buffered.		

	color_text: STRING_32
		-- The RTF string correponding to all colors in the document.

			-- These attributes are used to stop multiple versions of the same font being
			-- generate in the RTF.

	hashed_fonts: HASH_TABLE [INTEGER, STRING_32]
			-- All fonts currently stored for buffering, accessible via the
			-- actual RTF output, in the form "\froman\fcharset0 System". The integer `item'
			-- corresponds to the offset of the font in `fonts'.

	font_offset: ARRAYED_LIST [INTEGER]
			-- All font indexes  in document,
			-- indexed by their corresponding character format index.
			-- So, for example, item 20 would correspond to the font offset to use from
			-- the font table for the 20th character format.

	font_count: INTEGER
		-- Number of fonts currently buffered.

	font_text:STRING_32
		-- The RTF string corresponding to all fonts in the document.

	is_current_format_underlined: BOOLEAN
	is_current_format_striked_through: BOOLEAN
	is_current_format_bold: BOOLEAN
	is_current_format_italic: BOOLEAN
	current_vertical_offset: INTEGER
		-- Booleans used to determine current formatting. These are used to prevent
		-- repeatedly opening the same tags each time a new format is encountered.

	screen: EV_SCREEN
			-- Once acces to EV_SCREEN object.
		once
			create Result
		end

	points_per_inch: INTEGER = 72
		-- Number of points per inch.

	initial_color_value: INTEGER = -1
		-- Value assigned to each color RGB component before loading.
		-- This permits us to determine if the first color is auto, as if
		-- so, the rgb values are all still set to this value.

invariant
	rich_text_not_void: rich_text /= Void

note
	copyright:	"Copyright (c) 1984-2020, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
