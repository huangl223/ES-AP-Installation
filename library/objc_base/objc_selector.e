note
	description: "Representation of an Objective-C selector at runtime."
	author: "Daniel Furrer <daniel.furrer@gmail.com>"
	date: "$Date: 2013-05-20 23:15:17 +0000 (Mon, 20 May 2013) $"
	revision: "$Revision: 92557 $"

class
	OBJC_SELECTOR

inherit
	ANY
		redefine
			is_equal
		end

	DEBUG_OUTPUT
		redefine
			is_equal
		end

create
	make_from_pointer,
	make

feature {NONE} -- Initialization

	make_from_pointer (a_ptr: POINTER)
			-- Initialize Current from an Objective-C selector `a_ptr'.
		require
			a_ptr_not_null: a_ptr /= default_pointer
		do
			item := a_ptr
		ensure
			item_set: item = a_ptr
		end

	make (a_method_name: READABLE_STRING_GENERAL)
			-- Registers a method with the Objective-C runtime system and maps the method name to a selector.
		do
			make_from_pointer ({NS_OBJC_RUNTIME}.sel_register_name ((create {C_STRING}.make (a_method_name)).item))
		end

feature -- Access

	name, debug_output: STRING
			-- The name of the method specified by a given selector.
		do
			Result := (create {C_STRING}.make_shared_from_pointer ({NS_OBJC_RUNTIME}.sel_get_name (item))).string
		end

	is_equal (other: like Current): BOOLEAN
			-- <Precursor>
		do
			Result := {NS_OBJC_RUNTIME}.sel_is_equal (item, other.item)
		end

feature {OBJC_SELECTOR, NS_OBJECT} -- Implementation: Access

	item: POINTER;
			-- Underlying SEL pointer.
end
