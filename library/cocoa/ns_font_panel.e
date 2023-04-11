note
	description: "Wrapper for NSFontPanel."
	author: "Daniel Furrer"
	date: "$Date: 2009-07-31 14:46:57 +0000 (Fri, 31 Jul 2009) $"
	revision: "$Revision: 80034 $"

class
	NS_FONT_PANEL

inherit
	NS_PANEL

create
	shared_font_panel
create {NS_OBJECT}
	share_from_pointer

feature {NONE} -- Creation

	shared_font_panel
		do
			share_from_pointer (font_panel_shared_font_panel)
		end

feature -- Objective-C implementation

	frozen font_panel_shared_font_panel: POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSFontPanel sharedFontPanel];"
		end

end
