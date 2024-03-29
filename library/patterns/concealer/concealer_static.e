note
	description: "[
		An implementation of the {CONCEALER_I} pattern interface to provided direct access to a
		concealed object.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date: 2009-03-05 18:53:44 +0000 (Thu, 05 Mar 2009) $";
	revision: "$Revision $"

frozen class
	CONCEALER_STATIC [G]

inherit
	CONCEALER_I [G]

create
	make

feature {NONE} -- Initialization

	make (a_object: like object)
			-- Initializes the concealer with an actual object.
			--
			-- `a_object': The object the concealer will reveal on request.
		do
			object := a_object
			is_revealed := True
		ensure
			object_set: object = a_object
			is_revealed: is_revealed
		end

feature -- Access

	object: detachable G
			-- <Precursor>

feature -- Status report

	is_revealed: BOOLEAN
			-- <Precursor>

;note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
