note
	description: "Wrapper for NSColorSpace."
	author: "Daniel Furrer"
	date: "$Date: 2013-05-20 23:15:17 +0000 (Mon, 20 May 2013) $"
	revision: "$Revision: 92557 $"

class
	NS_COLOR_SPACE

inherit
	NS_OBJECT

create
	device_rgb_color_space,
	generic_rgb_color_space

feature {NONE} -- Creation

	device_rgb_color_space
		do
			item := color_space_device_rgb_color_space
		end

	generic_rgb_color_space
		do
			item := color_space_generic_rgb_color_space
		end

feature {NONE} -- Implementation

	frozen color_space_device_rgb_color_space: POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSColorSpace deviceRGBColorSpace];"
		end

	frozen color_space_generic_rgb_color_space: POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSColorSpace genericRGBColorSpace];"
		end
end
