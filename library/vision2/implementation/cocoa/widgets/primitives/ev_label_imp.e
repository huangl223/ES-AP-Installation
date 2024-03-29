note
	description: "EiffelVision label, Cocoa implementation."
	author:	"Daniel Furrer"
	id: "$Id: ev_label_imp.e 92557 2013-05-20 23:15:17Z manus $"
	date: "$Date: 2013-05-20 23:15:17 +0000 (Mon, 20 May 2013) $"
	revision: "$Revision: 92557 $"

class
	EV_LABEL_IMP

inherit
	EV_LABEL_I
		redefine
			interface
		end

	EV_PRIMITIVE_IMP
		redefine
			interface,
			make,
			set_default_minimum_size,
			set_background_color,
			set_foreground_color
		end

	EV_TEXTABLE_IMP
		redefine
			interface,
			set_text
		end

	EV_FONTABLE_IMP
		redefine
			interface,
			set_font
		end

	SINGLE_MATH

create
	make

feature {NONE} -- Initialization

	make
		do
			create text_field.make
			text_field.set_editable (false)
			--text_field.set_draws_background (false)
			text_field.set_bordered (false)
			text_field.set_background_color (create {NS_COLOR}.control_color)
			cocoa_view := text_field

			align_text_center

			Precursor {EV_PRIMITIVE_IMP}
			disable_tabable_from
			disable_tabable_to
		end

feature -- Minimum size

	set_default_minimum_size
			-- Resize to a default size.
		do
			accommodate_text (" ")
		end

	accommodate_text (a_text: READABLE_STRING_GENERAL)
			-- Change internal minimum size to make `a_text' fit.
		require
			a_text_not_void: a_text /= Void
			a_text_not_empty: not a_text.is_empty
		local
			t: TUPLE [width: INTEGER; height: INTEGER]
			a_width, a_height: INTEGER
		do
			t := font.string_size (a_text)
			a_width := t.width
			a_height := t.height
			internal_set_minimum_size (a_width.abs + 5, a_height.abs + 5)
		end

feature -- Status setting

	align_text_top
			-- Set vertical text alignment of current label to top.
		do
			check
				not_implemented: False
			end
		end

	align_text_vertical_center
			-- Set text alignment of current label to be in the center vertically.
		do
			check
				not_implemented: False
			end
		end

	align_text_bottom
			-- Set vertical text alignment of current label to bottom.
		do
			check
				not_implemented: False
			end
		end

	set_text (a_text: READABLE_STRING_GENERAL)
			-- Assign `a_text' to `text'.
		do
			if not a_text.same_string (text) then
				if a_text.is_empty then
					set_default_minimum_size
				else
					accommodate_text (a_text)
				end
				Precursor {EV_TEXTABLE_IMP} (a_text)
				text_field.set_string_value (a_text)
				-- invalidate
			end
		end

	set_background_color (a_color: EV_COLOR)
			-- Assign `a_color' to `background_color'
		local
			color: NS_COLOR
		do
			Precursor {EV_PRIMITIVE_IMP} (a_color)
			create color.color_with_calibrated_red_green_blue_alpha (a_color.red, a_color.green, a_color.blue, {REAL_32}1.0)
			text_field.set_background_color (color)
		end

	set_foreground_color (a_color: EV_COLOR)
			-- <Precursor>
		local
			color: NS_COLOR
		do
			Precursor {EV_PRIMITIVE_IMP} (a_color)
			create color.color_with_calibrated_red_green_blue_alpha (a_color.red, a_color.green, a_color.blue, {REAL_32}1.0)
			text_field.set_text_color (color)
		end

	set_font (a_font: EV_FONT)
			-- <Precursor>
		do
			Precursor {EV_FONTABLE_IMP} (a_font)
			if attached {EV_FONT_IMP} a_font.implementation as font_imp then
				text_field.set_font (font_imp.font)
			else
				check False end
			end
		end

feature {EV_ANY_I} -- Implementation

	text_field: NS_TEXT_FIELD

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_LABEL note option: stable attribute end;

end --class LABEL_IMP
