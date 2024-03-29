note
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date: 2008-12-29 20:27:11 +0000 (Mon, 29 Dec 2008) $"
	revision: "$Revision: 76420 $"

deferred class
	BASIC_KEY

inherit
	KEY

feature -- Initialization

	make (type: like item)
			-- Initialize
		do
			item:=type	
		end

feature --Access

	item : HASHABLE

	hash_code: INTEGER
			-- Hash code value
		do
			Result := item.hash_code 
		end

	is_basic: BOOLEAN = True;

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




end -- class BASIC_KEY


