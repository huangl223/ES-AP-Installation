note
	description: "Helper class Monitor DPI gtk Implementation "
	date: "$Date: 2019-03-01 12:44:29 +0000 (Fri, 01 Mar 2019) $"
	revision: "$Revision: 102865 $"

class
	EV_MONITOR_DPI_DETECTOR_IMP

inherit

	EV_MONITOR_DPI_DETECTOR

feature -- Access

	dpi: NATURAL
			-- <Precursor>
		local
			ev: EV_SCREEN_IMP
		do
			create ev.make
			Result := ev.horizontal_resolution.to_natural_32
		end

note
	copyright: "Copyright (c) 1984-2019, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
