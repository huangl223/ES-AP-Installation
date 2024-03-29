note
	description: "[
		The service interface for retrieving the global service container.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date: 2015-12-17 13:34:17 +0000 (Thu, 17 Dec 2015) $";
	revision: "$Revision: 98279 $"

frozen class
	SERVICE_CONTAINER_S

inherit
	SERVICE_I

	SERVICE_CONTAINER_I

	DISPOSABLE_SAFE
		redefine
			is_interface_usable
		end

create
	make

feature {NONE} -- Initialization

	make (a_container: like container)
			-- Initializes the service container service with an actual container.
			--
			-- `a_container': The actual service container use to delegate calls to.
		require
			a_container_attached: a_container /= Void
		do
			container := a_container
		ensure
			container_set: container = a_container
		end

feature {NONE} -- Clean up

	safe_dispose (a_explicit: BOOLEAN)
			-- <Precursor>
		do
		end

feature {NONE} -- Access

	container: SERVICE_CONTAINER_I
			-- Actual service container to perform operations on.

feature -- Status report

	is_interface_usable: BOOLEAN
			-- <Precursor>
		do
			Result := Precursor and then
				attached {USABLE_I} container as l_usable implies l_usable.is_interface_usable
		ensure then
			container_is_interface_usable: attached {USABLE_I} container as l_usable implies l_usable.is_interface_usable
		end
feature -- Extension

	register (a_type: TYPE [detachable SERVICE_I]; a_service: SERVICE_I; a_promote: BOOLEAN)
			-- <Precursor>
		do
			container.register (a_type, a_service, a_promote)
		end

	register_with_activator (a_type: TYPE [detachable SERVICE_I]; a_activator: FUNCTION [detachable SERVICE_I] a_promote: BOOLEAN)
			-- <Precursor>
		do
			container.register_with_activator (a_type, a_activator, a_promote)
		end

feature -- Removal

	revoke (a_type: TYPE [detachable SERVICE_I]; a_promote: BOOLEAN)
			-- <Precursor>
		do
			container.revoke (a_type, a_promote)
		end

feature -- Query

	is_service_proffered (a_type: TYPE [detachable SERVICE_I]; a_promote: BOOLEAN): BOOLEAN
			-- <Precursor>
		do
			Result := container.is_service_proffered (a_type, a_promote)
		end

invariant
	container_attached: container /= Void

;note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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

