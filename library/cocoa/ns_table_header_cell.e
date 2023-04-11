note
	description: "Wrapper for NSTableHeaderCell."
	author: "Daniel Furrer"
	date: "$Date: 2013-05-20 23:15:17 +0000 (Mon, 20 May 2013) $"
	revision: "$Revision: 92557 $"

class
	NS_TABLE_HEADER_CELL

inherit
	NS_TEXT_FIELD_CELL

create
	make

feature {NONE} -- Creation

--	alloc
--		do
--			cocoa_object := table_header_cell_alloc
--		end

	make
		do
			make_from_pointer (table_header_cell_new)
		end

feature {NONE} -- Objective-C interface

	frozen table_header_cell_alloc: POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSTableHeaderCell alloc];"
		end

	frozen table_header_cell_new: POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSTableHeaderCell new];"
		end

end
