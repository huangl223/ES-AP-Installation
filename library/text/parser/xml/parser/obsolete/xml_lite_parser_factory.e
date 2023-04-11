note
	description: "[
				Use XML_STANDARD_PARSER
			]"
	date: "$Date: 2013-05-20 23:15:17 +0000 (Mon, 20 May 2013) $"
	revision: "$Revision: 92557 $"

class
	XML_LITE_PARSER_FACTORY

obsolete "Use {XML_PARSER_FACTORY} [2012-oct]"

inherit
	XML_PARSER_FACTORY
		redefine
			new_parser
		end

feature -- Access

	new_parser, new_lite_parser: XML_LITE_PARSER
			-- New XML parser
		do
			create Result.make
		end

note
	copyright: "Copyright (c) 1984-2012, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
