note
	description: "An abstraction for Cocoa's Action/Target mechanism."
	author: "Daniel Furrer"
	date: "$Date: 2015-12-17 13:34:17 +0000 (Thu, 17 Dec 2015) $"
	revision: "$Revision: 98279 $"

deferred class
	TARGET_ACTION_SUPPORT

inherit
	ANY
		undefine
			copy
		end

feature --

	set_action (an_action: PROCEDURE)
			-- Sets
		require
			an_action /= void
		do
			action := an_action
			c_set_target (item, target_new ($current, $target))
			c_set_action (item)
		end

feature {NONE} -- Callback

	target
		do
			if attached {PROCEDURE} action as l_action then
				l_action.call([])
			end
		end

	action: detachable PROCEDURE

	item: POINTER
		deferred
		end

feature {NONE} -- Externals

	frozen target_new (a_object: POINTER; a_method: POINTER): POINTER
		external
			"C inline use %"actions.h%""
		alias
			"return [[SelectorWrapper new] initWithCallbackObject: $a_object andMethod: $a_method];"
		end

	frozen c_set_target (a_menu_item: POINTER; a_target: POINTER)
			-- - (void)setTarget:(id)anObject;
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSMenuItem*)$a_menu_item setTarget: $a_target];"
		end

	frozen c_set_action (a_menu_item: POINTER)
			-- - (void)setAction:(SEL)aSelector;
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSMenuItem*)$a_menu_item setAction:@selector(handle_action_event:)];"
		end

end
