note
	description: "[
		Objects representing delayed calls to a boolean function,
		with some arguments possibly still open.
		]"
	library: "Free implementation of ELKS library"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date: 2017-06-01 07:24:49 +0000 (Thu, 01 Jun 2017) $"
	revision: "$Revision: 100440 $"

class
	PREDICATE [OPEN_ARGS -> detachable TUPLE create default_create end]

inherit
	FUNCTION [OPEN_ARGS, BOOLEAN]

create {NONE}
	set_rout_disp,
	set_rout_disp_final

note
	copyright: "Copyright (c) 1984-2015, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
