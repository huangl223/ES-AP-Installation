note
	description:
		"EiffelVision textable. Implementation interface."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "text, label, font, name, property"
	date: "$Date: 2017-03-27 17:23:22 +0000 (Mon, 27 Mar 2017) $"
	revision: "$Revision: 100056 $"

deferred class
	EV_TEXTABLE_I

inherit
	EV_ANY_I
		redefine
			interface
		end

feature -- Access

	text: STRING_32
			-- Text displayed in label.
		deferred
		ensure
			not_void: Result /= Void
			cloned: Result /= text
		end

feature -- Element change

	set_text (a_text: READABLE_STRING_GENERAL)
			-- Assign `a_text' to `text'.
		require
			a_text_not_void: a_text /= Void
			no_carriage_returns: not a_text.has_code (('%R').natural_32_code)
		deferred
		ensure
			text_cloned: attached a_text as l_text and then text.same_string_general (l_text) and then text /= l_text
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_TEXTABLE note option: stable attribute end;
            -- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'

note
	copyright:	"Copyright (c) 1984-2017, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class EV_TEXTABLE_I












