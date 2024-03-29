note
	description: "[
		Processor for expressions (Visitor Pattern)
		]"
	author: "Andreas Leitner"
	date: "$Date: 2013-05-20 23:15:17 +0000 (Mon, 20 May 2013) $"
	revision: "$Revision: 92557 $"

deferred class ITP_EXPRESSION_PROCESSOR

feature {ITP_EXPRESSION} -- Processing

	process_constant (a_value: ITP_CONSTANT)
			-- Process `a_value'.
		require
			a_value_not_void: a_value /= Void
		deferred
		end

	process_variable (a_value: ITP_VARIABLE)
			-- Process `a_value'.
		require
			a_value_not_void: a_value /= Void
		deferred
		end

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
