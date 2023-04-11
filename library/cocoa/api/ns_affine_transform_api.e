note
	description: "Summary description for {NS_AFFINE_TRANSFORM_API}."
	author: "Daniel Furrer"
	date: "$Date: 2013-05-20 23:15:17 +0000 (Mon, 20 May 2013) $"
	revision: "$Revision: 92557 $"

class
	NS_AFFINE_TRANSFORM_API

feature -- Creating an NSAffineTransform Object

	frozen transform: POINTER
			-- + (NSAffineTransform *)transform
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSAffineTransform transform];"
		end

feature -- Accumulating Transformations

	frozen translate_by_xy (target: POINTER; x, y: REAL)
			-- - (void)translateXBy:(CGFloat)deltaX yBy:(CGFloat)deltaY
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSAffineTransform*)$target translateXBy: $x yBy: $y];"
		end

	frozen scale_by_xy (target: POINTER; x, y: REAL)
			-- - (void)scaleXBy:(CGFloat)scaleX yBy:(CGFloat)scaleY
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSAffineTransform*)$target scaleXBy: $x yBy: $y];"
		end

feature -- Setting and Building the Current Transformation Matrix (AppKit cetegory)

	frozen concat (target: POINTER)
			-- - (void)concat
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSAffineTransform*)$target concat];"
		end

end
