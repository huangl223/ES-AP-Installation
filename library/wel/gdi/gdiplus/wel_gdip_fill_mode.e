﻿note
	description: "[
			Enumeration specifies how the interior of a closed path is filled.
			Please see MSDN:
			http://msdn.microsoft.com/en-us/library/system.drawing.drawing2d.fillmode.aspx
		]"
	eis: "protocol=uri", "src=http://msdn.microsoft.com/en-us/library/system.drawing.drawing2d.fillmode.aspx"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2018-09-21 13:06:47 +0000 (Fri, 21 Sep 2018) $"
	revision: "$Revision: 102203 $"

class
	WEL_GDIP_FILL_MODE

feature -- Enumeration

	Alternate: INTEGER = 0
			-- Specifies the alternate fill mode.

	Winding: INTEGER = 1
			-- Specifies the winding fill mode.

feature -- Query

	is_valid (mode: INTEGER): BOOLEAN
			-- If value `mode` a valid fill mode?
		do
			Result := mode = Alternate or mode = Winding
		ensure
			instance_free: class
		end

;note
	copyright:	"Copyright (c) 1984-2018, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
