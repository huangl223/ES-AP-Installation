note
	description: "Wrapper for NSSecureTextField."
	author: "Daniel Furrer"
	date: "$Date: 2009-05-26 15:42:03 +0000 (Tue, 26 May 2009) $"
	revision: "$Revision: 78864 $"

class
	NS_SECURE_TEXT_FIELD

inherit
	NS_TEXT_FIELD
		redefine
			make
		end

create
	make

feature {NONE} -- Creation

	make
		do
			item := secure_text_field_new
		end

feature {NONE} -- Objective-C implementation

	frozen secure_text_field_new: POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSSecureTextField new];"
		end
end
