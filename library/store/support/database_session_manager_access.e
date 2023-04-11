note
	description: "Session manager access"
	date: "$Date: 2013-05-20 23:15:17 +0000 (Mon, 20 May 2013) $"
	revision: "$Revision: 92557 $"

class
	DATABASE_SESSION_MANAGER_ACCESS

feature -- Access

	manager: DATABASE_SESSION_MANAGER
			-- The session manager
		once
			create Result
		end

end
