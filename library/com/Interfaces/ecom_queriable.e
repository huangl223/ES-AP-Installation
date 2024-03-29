note
	description: "COM Queriable"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date: 2012-04-05 23:12:22 +0000 (Thu, 05 Apr 2012) $"
	revision: "$Revision: 88504 $"

deferred class
	ECOM_QUERIABLE

inherit
	ECOM_INTERFACE

	DISPOSABLE

feature  {NONE} -- Initialization

	make_from_other (other: ECOM_INTERFACE)
			-- Make from other Queriable.
		require
			non_void_other: other /= Void
		do
			if (other.item = default_pointer) and then attached {ECOM_STUB} other as l_stub then
				l_stub.create_item
			end
			make_from_pointer (other.item)
		ensure
			valid_initializer: initializer /= default_pointer
			exists: exists
		end

	make_from_pointer (a_pointer: POINTER)
			-- Make from interface pointer.
		require
			non_default_pointer: a_pointer /= default_pointer
		deferred
		ensure
			valid_initializer: initializer /= default_pointer
			exists: exists
		end

feature -- Access

	exists: BOOLEAN
			-- Is wrapped structure initialized?
		do
			Result := item /= default_pointer
		end;

	item: POINTER
			-- Pointer to COM object wrapper.

feature {NONE} -- Implementation

	initializer: POINTER;
			-- Pointer to C++ wrapper.

	dispose
			-- Delete C++ wrapper.
		do
			delete_wrapper
		end

	delete_wrapper
			-- Delete C++ wrapper.
		deferred
		end

invariant
	queriable_invariant: initializer /= default_pointer and then exists

note
	copyright:	"Copyright (c) 1984-2012, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class ECOM_QUERIABLE

