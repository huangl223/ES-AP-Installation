note
	description: "Provides the constants for I18N_NLS_GET_LOCALE_INFO"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2009-02-19 04:16:06 +0000 (Thu, 19 Feb 2009) $"
	revision: "$Revision: 77196 $"

class
	SHARED_I18N_NLS_LC_CTYPE_CONSTANTS

feature -- Shared object

	nls_constants: I18N_NLS_LC_CTYPE_CONSTANTS
		once
			create Result
		end

note
	library:   "Internationalization library"
	copyright: "Copyright (c) 1984-2009, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
