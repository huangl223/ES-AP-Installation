note
	description: "Objects that shares an instance of scale factories."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2008-12-29 20:27:11 +0000 (Mon, 29 Dec 2008) $"
	revision: "$Revision: 76420 $"

class
	EV_SHARED_SCALE_FACTORY

feature {NONE} -- Access

	font_factory: EV_SCALED_FONT_FACTORY
			-- Scaled font factory.
		once
			create Result
		ensure
			Result_not_Void: Result /= Void
		end
		
	pixmap_factory: EV_SCALED_PIXMAP_FACTORY
			-- Scaled pixmap factory.
		once
			create Result
		ensure
			Result_not_Void: Result /= Void
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




end -- class EV_SHARED_SCALE_FACTORY

