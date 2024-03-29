note
	description:
		"[
			Displays two widgets side by side, separated by an adjustable divider.
		"]
	apearance:
		"[
			------------------------------
			|             ||             |
			|    first    ||   second    |
			|             ||             |
			------------------------------
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2013-01-29 01:14:10 +0000 (Tue, 29 Jan 2013) $"
	revision: "$Revision: 91071 $"

class
	EV_HORIZONTAL_SPLIT_AREA

inherit
	EV_SPLIT_AREA
		redefine
			implementation
		end


create
	default_create

feature {EV_ANY, EV_ANY_I} -- Implementation

	implementation: EV_HORIZONTAL_SPLIT_AREA_I
			-- Responsible for interaction with native graphics toolkit.

feature {NONE} -- Implementation

	create_implementation
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_HORIZONTAL_SPLIT_AREA_IMP} implementation.make
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




end -- class EV_HORIZONTAL_SPLIT_AREA_I








