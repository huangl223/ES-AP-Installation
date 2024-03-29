note
	description: "Contains basic information about a physical font. All %
		%size are given in logical units; that is, they depend on the %
		%current mapping mode of the display context."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2011-03-29 00:28:02 +0000 (Tue, 29 Mar 2011) $"
	revision: "$Revision: 86040 $"

class
	WEL_TEXT_METRIC

inherit
	WEL_STRUCTURE
		rename
			make as structure_make
		end

create
	make,
	make_by_pointer,
	make_empty

feature {NONE} -- Initialization

	make_empty
			-- Create an empty text metric structure.
		do
			structure_make
		end

	make (a_dc: WEL_DC)
			-- Make a text metrics structure for `dc'.
		require
			a_dc_not_void: a_dc /= Void
			a_dc_exists: a_dc.exists
		do
			structure_make
			set_from_dc (a_dc)
		end

feature -- Status Setting

	set_from_dc (a_dc: WEL_DC)
			-- Set `Current' with `a_dc'.
		require
			a_dc_not_void: a_dc /= Void
			a_dc_exists: a_dc.exists
		do
			cwin_get_text_metric (a_dc.item, item)
		end

feature -- Access

	height: INTEGER
			-- Height (ascent + descent) of characters
		do
			Result := cwel_text_metric_get_tmheight (item)
		end

	ascent: INTEGER
			-- Ascent (units above the base line) of characters
		do
			Result := cwel_text_metric_get_tmascent (item)
		end

	descent: INTEGER
			-- Descent (units below the base line) of characters
		do
			Result := cwel_text_metric_get_tmdescent (item)
		end

	internal_leading: INTEGER
			-- Amount of leading (space) inside the bounds set by
			-- `height'
		do
			Result := cwel_text_metric_get_tminternalleading (item)
		end

	external_leading: INTEGER
			-- Amount of extra leading (space) that the application
			-- adds between rows
		do
			Result := cwel_text_metric_get_tmexternalleading (item)
		end

	average_character_width: INTEGER
			-- Average width of characters in the font (generally
			-- defined as the width of the letter x)
		do
			Result := cwel_text_metric_get_tmavecharwidth (item)
		end

	maximum_character_width: INTEGER
			-- Width of the widest character in the font
		do
			Result := cwel_text_metric_get_tmmaxcharwidth (item)
		end

	weight: INTEGER
			-- Weight of the font.
			-- See class WEL_FW_CONSTANTS for values.
		do
			Result := cwel_text_metric_get_tmweight (item)
		end

	overhang: INTEGER
			-- Extra width per string that may be added to some
			-- synthesized fonts
		do
			Result := cwel_text_metric_get_tmoverhang (item)
		end

	digitized_aspect_x: INTEGER
			-- Horizontal aspect of the device for which the
			-- font was designed
		do
			Result := cwel_text_metric_get_tmdigitizedaspectx (item)
		end

	digitized_aspect_y: INTEGER
			-- Vertical aspect of the device for which the font
			-- was designed
		do
			Result := cwel_text_metric_get_tmdigitizedaspecty (item)
		end

	first_character: INTEGER
			-- Value of the first character defined in the font
		do
			Result := cwel_text_metric_get_tmfirstchar (item)
		end

	last_character: INTEGER
			-- Value of the last character defined in the font
		do
			Result := cwel_text_metric_get_tmlastchar (item)
		end

	default_character: INTEGER
			-- Value of the character to be substituted for
			-- characters not in the font
		do
			Result := cwel_text_metric_get_tmdefaultchar (item)
		end

	break_character: INTEGER
			-- Value of the character that will be used to define
			-- word breaks for text justification
		do
			Result := cwel_text_metric_get_tmbreakchar (item)
		end

	italic: INTEGER
			-- Italic font if it is nonzero
		do
			Result := cwel_text_metric_get_tmitalic (item)
		end

	underlined: INTEGER
			-- Underlined font if it is nonzero
		do
			Result := cwel_text_metric_get_tmunderlined (item)
		end

	struckout: INTEGER
			-- Strikeout font if it is nonzero
		do
			Result := cwel_text_metric_get_tmstruckout (item)
		end

	pitch_and_family: INTEGER
			-- Information about the pitch, the technology, and
			-- the family of a physical font.
			-- See class WEL_TMPF_CONSTANTS for values.
		do
			Result := cwel_text_metric_get_tmpitchandfamily (item)
		end

	character_set: INTEGER
			-- Character set of the font
		do
			Result := cwel_text_metric_get_tmcharset (item)
		end

feature -- Measurement

	structure_size: INTEGER
			-- Size to allocate (in bytes)
		once
			Result := c_size_of_text_metric
		end

feature {NONE} -- Externals

	c_size_of_text_metric: INTEGER
		external
			"C [macro <tmetric.h>]"
		alias
			"sizeof (TEXTMETRIC)"
		end

	cwel_text_metric_get_tmheight (ptr: POINTER): INTEGER
		external
			"C [macro <tmetric.h>]"
		end

	cwel_text_metric_get_tmascent (ptr: POINTER): INTEGER
		external
			"C [macro <tmetric.h>]"
		end

	cwel_text_metric_get_tmdescent (ptr: POINTER): INTEGER
		external
			"C [macro <tmetric.h>]"
		end

	cwel_text_metric_get_tminternalleading (ptr: POINTER): INTEGER
		external
			"C [macro <tmetric.h>]"
		end

	cwel_text_metric_get_tmexternalleading (ptr: POINTER): INTEGER
		external
			"C [macro <tmetric.h>]"
		end

	cwel_text_metric_get_tmavecharwidth (ptr: POINTER): INTEGER
		external
			"C [macro <tmetric.h>]"
		end

	cwel_text_metric_get_tmmaxcharwidth (ptr: POINTER): INTEGER
		external
			"C [macro <tmetric.h>]"
		end

	cwel_text_metric_get_tmweight (ptr: POINTER): INTEGER
		external
			"C [macro <tmetric.h>]"
		end

	cwel_text_metric_get_tmoverhang (ptr: POINTER): INTEGER
		external
			"C [macro <tmetric.h>]"
		end

	cwel_text_metric_get_tmdigitizedaspectx (ptr: POINTER): INTEGER
		external
			"C [macro <tmetric.h>]"
		end

	cwel_text_metric_get_tmdigitizedaspecty (ptr: POINTER): INTEGER
		external
			"C [macro <tmetric.h>]"
		end

	cwel_text_metric_get_tmfirstchar (ptr: POINTER): INTEGER
		external
			"C [macro <tmetric.h>]"
		end

	cwel_text_metric_get_tmlastchar (ptr: POINTER): INTEGER
		external
			"C [macro <tmetric.h>]"
		end

	cwel_text_metric_get_tmdefaultchar (ptr: POINTER): INTEGER
		external
			"C [macro <tmetric.h>]"
		end

	cwel_text_metric_get_tmbreakchar (ptr: POINTER): INTEGER
		external
			"C [macro <tmetric.h>]"
		end

	cwel_text_metric_get_tmitalic (ptr: POINTER): INTEGER
		external
			"C [macro <tmetric.h>]"
		end

	cwel_text_metric_get_tmunderlined (ptr: POINTER): INTEGER
		external
			"C [macro <tmetric.h>]"
		end

	cwel_text_metric_get_tmstruckout (ptr: POINTER): INTEGER
		external
			"C [macro <tmetric.h>]"
		end

	cwel_text_metric_get_tmpitchandfamily (ptr: POINTER): INTEGER
		external
			"C [macro <tmetric.h>]"
		end

	cwel_text_metric_get_tmcharset (ptr: POINTER): INTEGER
		external
			"C [macro <tmetric.h>]"
		end

	cwin_get_text_metric (hdc, ptr: POINTER)
			-- SDK GetTextMetrics
		external
			"C [macro <wel.h>] (HDC, LPTEXTMETRIC)"
		alias
			"GetTextMetrics"
		end

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

end
