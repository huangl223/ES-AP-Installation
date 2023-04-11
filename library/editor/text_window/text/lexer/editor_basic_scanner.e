note
	description:"Basic texts scanners for TEXT_PANEL"
	author:     "Etienne Amodeo"
	date:       "$Date: 2012-12-28 08:01:32 +0000 (Fri, 28 Dec 2012) $"
	revision:   "$Revision: 90354 $"

class EDITOR_BASIC_SCANNER

inherit
	EDITOR_SCANNER
		redefine
			execute
		end

create
	make

feature -- Action

	execute (a_string: STRING)
			-- Analyze a string.		
		local
			l_token: EDITOR_TOKEN_TEXT
		do
			create l_token.make_from_utf_8 (a_string)
			first_token := l_token
			end_token := l_token
		end

	set_start_condition (a_c: INTEGER)
		do
		end

	start_condition: INTEGER

	scan
		do
		end

end
