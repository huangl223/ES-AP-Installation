note
	description: "Wrapper for delegate methods of NSOutlineView."
	author: "Daniel Furrer"
	date: "$Date: 2009-05-27 14:14:24 +0000 (Wed, 27 May 2009) $"
	revision: "$Revision: 78895 $"

deferred class
	NS_OUTLINE_VIEW_DELEGATE

feature

	make
		do
			item := outline_view_delegate_new ($current, $selection_did_change)
		end

	selection_did_change
		deferred
		end


feature {NONE} -- Objective-C implementation

	frozen outline_view_delegate_new (an_object: POINTER; a_selection_did_change: POINTER): POINTER
		external
			"C inline use %"ns_outline_view_delegate.h%""
		alias
			"return [[OutlineViewDelegate new] initWithCallbackObject: $an_object andMethod: $a_selection_did_change];"
		end

feature {NS_OBJECT} -- Should be used by classes in native only

	item: POINTER
	 	-- The C-pointer to the Cocoa object
end
