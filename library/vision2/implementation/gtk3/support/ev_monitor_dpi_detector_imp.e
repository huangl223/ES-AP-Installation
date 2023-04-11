note
	description: "Helper class Monitor DPI gtk3 Implementation "
	date: "$Date: 2021-11-18 14:22:34 +0000 (Thu, 18 Nov 2021) $"
	revision: "$Revision: 105966 $"

class
	EV_MONITOR_DPI_DETECTOR_IMP

inherit

	EV_MONITOR_DPI_DETECTOR

feature -- Access

	dpi: NATURAL
			-- <Precursor>
		do
			Result := dpi_cache
		end

	dpi_cache: NATURAL
		local
			ev: EV_SCREEN_IMP
		once
			create ev.make
			Result := ev.horizontal_resolution.to_natural_32
		ensure
			is_class: class
		end


note
	copyright: "Copyright (c) 1984-2021, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
