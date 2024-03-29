note
	description: "Cookie generator."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date: 2008-12-29 20:27:11 +0000 (Mon, 29 Dec 2008) $"
	revision: "$Revision: 76420 $"

class
	ECOM_COOKIE_GENERATOR


create
	default_create


feature -- Access

	counter: INTEGER
			-- Current biggest key.
	
	available_key_pool: LINKED_LIST [INTEGER]
			-- Pool of available keys.
	

feature -- Basic operations

	next_key: INTEGER 
			-- Next available key.
		do
			if 
				available_key_pool = Void or else
				available_key_pool.is_empty
			then
				counter := counter + 1
				Result := counter
			else
				Result := available_key_pool.first
				available_key_pool.start
				available_key_pool.remove
			end
		ensure
			valid_counter: 0 < counter
			valid_key: Result <= counter
		end

	add_key_to_pool (a_key: INTEGER)
			-- Add `a_key' to available key pool.
		require
			valid_key: a_key >= 0 and a_key <= counter
		do
			if available_key_pool = Void then
				create available_key_pool.make
			end
			available_key_pool.force (a_key)
		ensure
			non_void_pool: available_key_pool /= Void
			pool_extended: available_key_pool.has (a_key)
		end
		
note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class ECOM_COOKIE_GENERATOR

