note
	description: "Summary description for {NS_SCREEN_API}."
	author: "Daniel Furrer"
	date: "$Date: 2013-05-20 23:15:17 +0000 (Mon, 20 May 2013) $"
	revision: "$Revision: 92557 $"

class
	NS_SCREEN_API

feature -- Getting NSScreen Objects

	frozen screens: POINTER
			--+ (NSArray *)screens;		/* All screens; first one is "zero" screen */
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSScreen screens]"
		end

	frozen main_screen: POINTER
			--+ (NSScreen *)mainScreen;	/* Screen with key window */
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSScreen mainScreen];"
		end

	frozen deepest_screen: POINTER
			--+ (NSScreen *)deepestScreen;
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSScreen deepestScreen];"
		end

feature -- Getting Screen Information

--- (NSWindowDepth)depth;
	frozen frame (a_screen: POINTER; a_res: POINTER)
			--- (NSRect)frame;
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[
				{
					NSRect frame = [(NSScreen*)$a_screen frame];
					memcpy ($a_res, &frame, sizeof(NSRect));
				}
			]"
		end

	frozen visible_frame (a_screen: POINTER; a_res: POINTER)
			--- (NSRect)visibleFrame;
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[
				{
					NSRect frame = [(NSScreen*)$a_screen visibleFrame];
					memcpy ($a_res, &frame, sizeof(NSRect));
				}
			]"
		end

	frozen device_description (a_screen: POINTER): POINTER
			--- (NSDictionary *)deviceDescription;
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSScreen*)$a_screen deviceDescription];"
		end

--- (const NSWindowDepth *)supportedWindowDepths; /* 0 terminated */

--/* Returns scale factor applied by default to windows created on this screen
--*/
--- (CGFloat)userSpaceScaleFactor;

end
