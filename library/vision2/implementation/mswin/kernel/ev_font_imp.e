note
	description: "Eiffel Vision font. Mswindows implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "character, face, height, family, weight, shape, bold, italic"
	date: "$Date: 2017-05-03 15:56:14 +0000 (Wed, 03 May 2017) $"
	revision: "$Revision: 100317 $"

class
	EV_FONT_IMP

inherit
	EV_FONT_I
		redefine
			string_size,
			copy_font
		end

	EV_FONT_CONSTANTS


	WEL_SHARED_FONTS
		export
			{NONE} all
		end

	WEL_FONT_FAMILY_CONSTANTS
		export
			{NONE} all
		end

	WEL_FONT_PITCH_CONSTANTS
		export
			{NONE} all
		end

	WEL_UNIT_CONVERSION
		rename
			vertical_resolution as sceeen_vertical_resolution,
			horizontal_resolution as screen_horizontal_resolution
		export
			{NONE} all
		end

create
	make

feature -- Initialization

	--|----------------------------------------------------------------
	--| Note on implementation. VB 10 jan 2000
	--|----------------------------------------------------------------
	--| All information is stored in wel_log_font, although
	--| wel_font is the actual font object. Every time there is
	--| is an update on wel_log_font, the wel_font has to be created
	--| again by: wel_font.set_indirect (wel_log_font). In the creation
	--| procedure, first the wel_font is created, because wel_log_font
	--| cannot be instantiated without arguments.
	--|----------------------------------------------------------------

	old_make (an_interface: attached like interface)
			-- Create `Current'.
		do
			assign_interface (an_interface)
		end

	make
			-- Initialize `Current'.
		do
			create wel_font.make_indirect (Default_wel_log_font)
			internal_face_name := Default_wel_log_font.face_name

				-- Create and setup the preferred font face mechanism
			create preferred_families
			preferred_families.internal_add_actions.extend (agent update_preferred_faces)
			preferred_families.internal_remove_actions.extend (preferred_families.internal_add_actions.first)

				-- Retrieve shape, weight and family from
				-- the default font returned by Windows.
			shape := convert_font_shape(Default_wel_log_font.italic)
			weight := convert_font_weight(Default_wel_log_font.weight)
			family := family_screen
			update_internal_is_proportional(Default_wel_log_font)
			set_is_initialized (True)
		end

feature -- Access

	family: INTEGER
			-- Preferred font category.

	char_set: INTEGER
			-- Charset
		do
			Result := wel_font.log_font.char_set
		end

	weight: INTEGER
			-- Preferred font thickness.

	shape: INTEGER
			-- Preferred font slant.

	height: INTEGER
			-- Preferred font height measured in screen pixels.
		do
			Result := wel_font.height
		end

	height_in_points: INTEGER
			-- Preferred font height measured in points.
		do
			Result := wel_font.point.abs
		end

feature -- Element change

	set_family (a_family: INTEGER)
			-- Set `a_family' as preferred font category.
		do
				-- retrieve current values
			Wel_log_font.update_by_font(wel_font)

				-- change value
			family := a_family

				-- commit changes to `Wel_log_font' into `wel_font'.
			update_font_face
		end

	set_weight (a_weight: INTEGER)
			-- Set `a_weight' as preferred font thickness.
		do
				-- retrieve current values
			Wel_log_font.update_by_font(wel_font)

				-- change value
			weight := a_weight
			inspect weight
			when weight_thin then
				Wel_log_font.set_weight (100)
			when weight_regular then
				Wel_log_font.set_weight (400)
			when weight_bold then
				Wel_log_font.set_weight (700)
			when weight_black then
				Wel_log_font.set_weight (900)
			else
				check impossible: False end
			end

				-- commit changes to `Wel_log_font' into `wel_font'.
			wel_font.set_indirect (Wel_log_font)
		end

	set_shape (a_shape: INTEGER)
			-- Set `a_shape' as preferred font slant.
		do
				-- retrieve current values
			Wel_log_font.update_by_font(wel_font)

				-- change value
			shape := a_shape
			inspect shape
			when shape_regular then
				Wel_log_font.set_not_italic
			when shape_italic then
				Wel_log_font.set_italic
			else
				check impossible: False end
			end

				-- commit changes to `Wel_log_font' into `wel_font'.
			wel_font.set_indirect (Wel_log_font)
		end

	set_height (a_height: INTEGER)
			-- Set `a_height' as preferred font size in pixels.
		do
			wel_font.set_height (a_height)
			Wel_log_font.update_by_font (wel_font)
		end

	set_height_in_points (a_height: INTEGER)
			-- Set `a_height_in_points' to `a_height'.
		do
			wel_font.set_height_in_points (a_height)
			wel_log_font.update_by_font (wel_font)
		end

	copy_font (other: attached like interface)
			-- Update `Current' with all attributes of `other'.
			-- Redefined on Windows as certain properties of fonts
			-- cannot be specified completely through the interface of
			-- EiffelVision2, such as `char_set'. As we use a single once log font
			-- internally, the previous charset is still used, and preforming this
			-- redefinition fixes the char_set issue and is also faster.
		local
			log_font: WEL_LOG_FONT
			new_wel_font: WEL_FONT
			l_preferred_families: like preferred_families
		do
			if attached {EV_FONT_IMP} other.implementation as font_imp then
				log_font := font_imp.wel_font.log_font
				create new_wel_font.make_indirect (log_font)
				set_by_wel_font (new_wel_font)

					-- Dispose of `log_font' as it is only required
					-- temporarily to create the WEL_FONT.
				log_font.dispose
			else
				check other_is_font_imp: False end
			end

				-- Make sure that `preferred_families' is copied over correctly.
			l_preferred_families := other.preferred_families
			if preferred_families /= l_preferred_families then
				copy_preferred_families (l_preferred_families)
			end
		end

feature -- Status report

	name: STRING_32
			-- Face name chosen by toolkit.
		do
			Result := internal_face_name
		end

	ascent: INTEGER
			-- Vertical distance from the origin of the drawing
			-- operation to the top of the drawn character.
		do
			Result := text_metrics.ascent
		end

	descent: INTEGER
			-- Vertical distance from the origin of the drawing
			-- operation to the bottom of the drawn character.
		do
			Result := text_metrics.descent
		end

	width: INTEGER
			-- Character width of current fixed-width font.
		do
			Result := wel_font.width
		end

	minimum_width: INTEGER
			-- Width of the smallest character in the font.
		do
			Result := wel_font.string_width ("l")
		end

	maximum_width: INTEGER
			-- Width of the biggest character in the font.
		do
			Result := wel_font.string_width ("W")
		end

	string_width (a_string: READABLE_STRING_GENERAL): INTEGER
			-- Width in pixels of `a_string' in the current font.
		do
			if a_string.count > 0 then
					-- Only non empty strings may have a width to match invariant.
				Result := wel_font.string_width (a_string)
			end
		end

	string_size (a_string: READABLE_STRING_GENERAL): TUPLE [width: INTEGER; height: INTEGER; left_offset: INTEGER; right_offset: INTEGER]
			-- [width, height, left_offset, right_offset] in pixels of `a_string' in the current font,
			-- taking into account line breaks ('%N').
			-- `width' and `height' correspond to the rectange used to bound `a_string', and
			-- should be used when placing strings next to each as part of a text.
			-- On some fonts, characters may extend outside of the bounds given by `width' and `height',
			-- for example certain italic letters may overhang other letters. Use `left_offset' and
			-- `right_offset' to determine if there is any overhang for `a_string'. a negative `left_offset'
			-- indicates overhang to the left, while a positive `right_offset' indicates an overhang to the right.
			-- To determine the complete bounding rectangle for `a_string' add negative `left_offset'
			-- and positive `right_offset' to `width'.
		do
			Result := wel_font.string_size_extended (a_string)
			Result.right_offset := 0 - Result.right_offset
		end

	string_size_no_offset (a_string: READABLE_STRING_GENERAL): TUPLE [width: INTEGER; height: INTEGER]
			-- [width, height] in pixels of `a_string' not taking left or right overhang of string in to account.
		do
			Result := wel_font.string_size (a_string)
		end

	horizontal_resolution: INTEGER
			-- Horizontal resolution of screen for which the font is designed.
		do
			Result := text_metrics.digitized_aspect_x
		end

	vertical_resolution: INTEGER
			-- Vertical resolution of screen for which the font is designed.
		do
			Result := text_metrics.digitized_aspect_y
		end

	is_proportional: BOOLEAN
			-- Can characters in the font have different sizes?
		do
			Result := internal_is_proportional
		end

feature {EV_ANY_I} -- Access

	wel_font: WEL_FONT
			-- Basic WEL font.

feature {EV_FONTABLE_IMP, EV_FONT_DIALOG_IMP, EV_CHARACTER_FORMAT_IMP, EV_ENVIRONMENT_IMP} -- Access

	set_by_wel_font (wf: WEL_FONT)
			-- Set state by passing an already created WEL_FONT.
		local
			l_log_font: like wel_log_font
		do
			wel_font := wf
			l_log_font := wel_log_font
			l_log_font.update_by_font (wf)
			shape := convert_font_shape (l_log_font.italic)
			weight := convert_font_weight (l_log_font.weight)
			family := convert_font_family (l_log_font.family,
				l_log_font.pitch)
			preferred_families.wipe_out
			internal_face_name := l_log_font.face_name
			preferred_families.extend (internal_face_name)
		end

feature {EV_ANY_I} -- Implementation

	Wel_log_font: WEL_LOG_FONT
			-- Structure used to specify font characteristics.
		once
			create Result.make_by_font (gui_font)
		end

	Default_wel_log_font: WEL_LOG_FONT
			-- Structure used to initialize fonts.
		once
			create Result.make_by_font (gui_font)

				-- set the WEL family associated to Vision2 Screen fonts.
			wel_screen_font_family := Result.family
			wel_screen_font_pitch := Result.pitch
		end

	destroy
			-- Destroy `Current'.
		do
			wel_font.delete
			set_is_destroyed (True)
		end

	update_preferred_faces (a_face: STRING_32)
		do
				-- retrieve current values
			Wel_log_font.update_by_font(wel_font)

				-- commit changes to `Wel_log_font' into `wel_font'.
			update_font_face
		end

	update_font_face
			-- Find a font face based on properties
			-- `preferred_face' and `family'.
		local
			found_face: detachable STRING_32
			found: BOOLEAN
			dc: WEL_MEMORY_DC
			text_metric: WEL_TEXT_METRIC
		do
				-- First, set the family
			inspect family
			when family_screen then
				Wel_log_font.set_family(wel_screen_font_family)
				Wel_log_font.set_pitch(wel_screen_font_pitch)

			when family_roman then
				Wel_log_font.set_roman_family
				Wel_log_font.set_variable_pitch

			when family_sans then
				Wel_log_font.set_swiss_family
				Wel_log_font.set_variable_pitch

			when family_typewriter then
				Wel_log_font.set_script_family
				Wel_log_font.set_fixed_pitch

			when family_modern then
				Wel_log_font.set_modern_family
				Wel_log_font.set_fixed_pitch
			else
				check impossible: False end
			end

				-- Then, set the face name (if any)
			if not preferred_families.is_empty then
				from
					preferred_families.start
				until
					found or preferred_families.after
				loop
					found_face := preferred_families.item.twin
					found := Font_enumerator.font_faces.has (found_face)
					preferred_families.forth
				end
				if found and found_face /= Void then
					Wel_log_font.set_face_name (found_face)
					if attached font_enumerator.text_metrics as l_text_metrics then
						if attached l_text_metrics.item (found_face) as l_text_metric then
							wel_log_font.set_char_set (l_text_metric.character_set)
						end
					end
				else
						-- Preferred face not found, leave Windows do
						-- its best.
					Wel_log_font.set_face_name ("")
				end
			else
					-- Leave Windows choose the font that best
					-- match our attributes.
				Wel_log_font.set_face_name ("")
			end

				-- commit changes to `Wel_log_font' into `wel_font'.
			wel_font.set_indirect (Wel_log_font)

				-- retrieve values set by windows
			Wel_log_font.update_by_font (wel_font)

			if found then
					-- `Current' may not always have the char set correctly set when created by passing a preferred family.
					-- To determine the actual char set from the face name, we must select the font into a DC,
					-- and query the DC directly. The new font we create now has the correct char set.
				create dc.make
				dc.select_font (wel_font)
				create text_metric.make (dc)
				wel_log_font.set_char_set (text_metric.character_set)
				dc.unselect_all
				dc.release
				create wel_font.make_indirect (wel_log_font)
					-- retrieve values set by windows
				Wel_log_font.update_by_font (wel_font)
			end

				-- Update internal attributes.
			internal_face_name := Wel_log_font.face_name.twin
			update_internal_is_proportional (Wel_log_font)
		end

	set_name (str: READABLE_STRING_GENERAL)
			-- sets the name of the current font
		do
				-- retrieve current values
			Wel_log_font.update_by_font(wel_font)

				-- change value
			Wel_log_font.set_face_name (str)

				-- commit changes to `Wel_log_font' into `wel_font'.
			update_font_face
		end

	remove_name
			-- Set face name on WEL font to NULL.
			-- Let toolkit find the best matching name.
		do
				-- retrieve current values
			Wel_log_font.update_by_font(wel_font)

				-- change value (Leave windows choose the font)
			Wel_log_font.set_face_name ("")

				-- commit changes to `Wel_log_font' into `wel_font'.
			update_font_face
		end

	internal_face_name: STRING_32
		-- Font face name.

	internal_is_proportional: BOOLEAN
		-- Is the font proportional? (or fixed).

	update_internal_is_proportional(logfont: Wel_log_font)
		do
			if logfont.pitch = Default_pitch then
				internal_is_proportional := not (logfont.family = Ff_modern)

			elseif logfont.pitch = Fixed_pitch then
				internal_is_proportional := False

			elseif logfont.pitch = Variable_pitch then
				internal_is_proportional := True
			end
		end

	maximum_line_width (dc: WEL_DC; str: READABLE_STRING_GENERAL; number_of_lines: INTEGER): INTEGER
			-- Calculate the width of the longest %N delimited string in
			-- `str' on `dc' given there are `number_of_lines' lines
		require
			efficient: number_of_lines > 1
		local
			i, pos, new_pos: INTEGER
			l_newline_code: NATURAL_32
			line: READABLE_STRING_GENERAL
		do
			from
				i := 1
				pos := 0
				l_newline_code := ('%N').natural_32_code
			until
				i > number_of_lines or pos + 1 > str.count
			loop
				new_pos := str.index_of_code (l_newline_code, pos +1)
				if new_pos = 0 then
					line := str.substring (pos+1, str.count)
					Result := Result.max (dc.string_width (line))
				elseif new_pos /= pos + 1 then
					line := str.substring (pos+1, new_pos-1)
					Result := Result.max (dc.string_width (line))
					pos := new_pos
				else
					pos := pos + 1
				end
				i := i + 1
			end
		end

	text_metrics: WEL_TEXT_METRIC
			-- Text metric object for current WEL font.
			--| Used to get `ascent' and `descent', horizontal_resolution
			--| and vertical_resolution.
		local
			sdc: WEL_SCREEN_DC
		do
			create sdc
			sdc.get
			sdc.select_font (wel_font)
			create Result.make (sdc)
			sdc.unselect_font
			sdc.release
		ensure
			result_exists: Result /= Void
		end

	wel_screen_font_family: INTEGER
			-- Windows Family (Ff_roman, Ff_swiss, ...) associated
			-- to family_screen.

	wel_screen_font_pitch: INTEGER
			-- Windows Pitch (Ff_roman, Ff_swiss, ...) associated
			-- to family_screen.


	convert_font_family(wel_family: INTEGER; wel_pitch: INTEGER): INTEGER
			-- Convert a Windows Font Family into a Vision2 Font Family.
		do
			if wel_family = wel_screen_font_family then
				Result := family_screen
			elseif wel_family = Ff_roman then
				Result := family_roman
			elseif wel_family = Ff_swiss then
				Result := family_sans
			elseif wel_family = Ff_modern then
				Result := family_modern
			elseif wel_family = Ff_script then
				Result := family_typewriter
			else
					-- none of the above match, so we take
					-- an arbitrary family
				Result := family_sans
			end
		end

	convert_font_weight(wel_weight: INTEGER): INTEGER
			-- Convert `wel_weight' (weight of a WEL_FONT) into
			-- a vision2 weight constant.
		do
			inspect wel_weight
			when 1..249 then
				Result := weight_thin
			when 250..549 then
				Result := weight_regular
			when 550..799 then
				Result := weight_bold
			when 800..1000 then
				Result := weight_black
			else
				check impossible: False end
			end
		end

	convert_font_shape(wel_italic: BOOLEAN): INTEGER
			-- Convert `wel_italic' (italic of a WEL_LOG_FONT) into
			-- a vision2 shape constant.
		do
			if wel_italic then
				Result := shape_italic
			else
				Result := shape_regular
			end
		end

feature {EV_TEXTABLE_IMP} -- Implementation

	string_width_and_height_ignore_new_line (a_string: READABLE_STRING_GENERAL):
		TUPLE [INTEGER, INTEGER]
			-- [width, height] of `a_string'.
			-- Treat `%N' as a character.
		require
			a_string_not_void: a_string /= Void
		local
			screen_dc: WEL_SCREEN_DC
			extent: WEL_SIZE
		do
			create screen_dc
			screen_dc.get
			screen_dc.select_font (wel_font)
			extent := screen_dc.string_size (a_string)
			screen_dc.unselect_font
			screen_dc.quick_release
			Result := [extent.width, extent.height]
		end

	Font_enumerator: EV_WEL_FONT_ENUMERATOR_IMP
			-- Enumerate Installed fonts
		once
			create Result
		end

feature -- Obsolete

	string_width_and_height (a_string: READABLE_STRING_GENERAL): TUPLE [INTEGER, INTEGER]
			-- [width, height] of `a_string'.
		obsolete
			"Use `string_size'. [2017-05-31]"
		do
			Result := wel_font.string_size (a_string)
		end

feature {NONE} -- Not used

	set_charset (a_charset: READABLE_STRING_GENERAL)
			-- Set the charset to a value based on `a_charset'.
		do
			if a_charset.same_string ("ansi") then
				Wel_log_font.set_ansi_character_set
			elseif a_charset.same_string ("oem") then
				Wel_log_font.set_oem_character_set
			elseif a_charset.same_string ("symbol") then
				Wel_log_font.set_symbol_character_set
			elseif a_charset.same_string ("unicode") then
				Wel_log_font.set_unicode_character_set
			else
				Wel_log_font.set_default_character_set
			end
		end

	set_clip_precision (a_clip_precision: READABLE_STRING_GENERAL)
			-- Set the clip precision based on `a_clip_precision'.
		do
			if a_clip_precision.same_string ("character") then
				Wel_log_font.set_character_clipping_precision
			elseif a_clip_precision.same_string ("stroke") then
				Wel_log_font.set_stroke_clipping_precision
			else
				Wel_log_font.set_default_clipping_precision
			end
		end

	set_escapement (an_escapement: READABLE_STRING_GENERAL)
			-- Set escapement based on value of `an_escapement'.
		local
			l_value: STRING_32
		do
			l_value := an_escapement.as_string_32
			if l_value /= Void and l_value.is_integer then
				Wel_log_font.set_escapement (l_value.to_integer)
			else
				Wel_log_font.set_escapement (0)
			end
		end

	set_orientation (an_orientation: READABLE_STRING_GENERAL)
			-- Set the orientation based on the value of `an_orientation'.
		local
			l_value: STRING_32
		do
			l_value := an_orientation.as_string_32
			if l_value /= Void and then l_value.is_integer then
				Wel_log_font.set_orientation (l_value.to_integer)
			else
				Wel_log_font.set_orientation (0)
			end
		end

	set_out_precision (a_precision: READABLE_STRING_GENERAL)
			-- Set the precision based on the value of `a_precision'.
		do
			if a_precision.same_string ("character") then
				Wel_log_font.set_character_output_precision
			elseif a_precision.same_string ("string") then
				Wel_log_font.set_string_output_precision
			elseif a_precision.same_string ("stroke") then
				Wel_log_font.set_stroke_output_precision
			else
				Wel_log_font.set_default_output_precision
			end
		end

	set_pitch (a_pitch: READABLE_STRING_GENERAL)
			-- Set pitch based on value in `a_pitch'.
		do
			if a_pitch.same_string ("fixed") then
				Wel_log_font.set_fixed_pitch
			elseif a_pitch.same_string ("variable") then
				Wel_log_font.set_variable_pitch
			else
				Wel_log_font.set_default_pitch
			end
		end

	set_quality (a_quality: READABLE_STRING_GENERAL)
			-- Set quality based on value in `a_quality'.
		do
			if a_quality.same_string ("draft") then
				Wel_log_font.set_draft_quality
			elseif a_quality.same_string ("proof") then
				Wel_log_font.set_proof_quality
			else
				Wel_log_font.set_default_quality
			end
		end

	set_styles (styles: READABLE_STRING_GENERAL)
			-- Set the style based on values in `styles'.
		do
			Wel_log_font.set_not_italic
			Wel_log_font.set_not_underlined
			Wel_log_font.set_not_strike_out
			if styles /= Void then
				if styles.has_code (('i').natural_32_code) then
					Wel_log_font.set_italic
				end
				if styles.has_code (('u').natural_32_code) then
					Wel_log_font.set_underlined
				end
				if styles.has_code (('s').natural_32_code) then
					Wel_log_font.set_strike_out
				end
			end
		end

invariant
	wel_log_font_exists: Wel_log_font /= Void
	wel_font_exists: wel_font /= Void

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




end -- class EV_FONT_IMP










