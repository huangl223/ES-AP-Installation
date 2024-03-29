﻿note
	description: "[
			Objects representing constants.
		]"
	author: "Andreas Leitner"
	date: "$Date: 2019-08-02 08:08:17 +0000 (Fri, 02 Aug 2019) $"
	revision: "$Revision: 103380 $"

class ITP_CONSTANT

inherit
	ITP_EXPRESSION

	ERL_CONSTANTS

create

	make

feature {NONE} -- Initialization

	make (a_value: like value)
			-- Create new constant.
		do
			value := a_value
		ensure
			value_set: value = a_value
		end

feature -- Access

	value: detachable ANY
		-- Value

	type_name: STRING
			-- Type name of constant
		local
			l_value: like value
		do
			l_value := value
			if l_value = Void then
				Result := none_type_name
			else
				Result := {UTF_CONVERTER}.string_32_to_utf_8_string_8 (l_value.generating_type.name_32)
			end
		ensure
			Result_not_void: Result /= Void
			Result_not_empty: not Result.is_empty
		end

feature -- Processing

	process (a_processor: ITP_EXPRESSION_PROCESSOR)
			-- <Precursor>
		do
			a_processor.process_constant (Current)
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
