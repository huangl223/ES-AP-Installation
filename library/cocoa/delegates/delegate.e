note
	description: "Summary description for {DELEGATE}."
	author: ""
	date: "$Date: 2013-05-20 23:15:17 +0000 (Mon, 20 May 2013) $"
	revision: "$Revision: 92557 $"

deferred class
	DELEGATE

inherit
	ANY
		undefine
			copy
		end

feature -- Access


feature {NS_OBJECT}

	item: POINTER
		deferred
		end

end
