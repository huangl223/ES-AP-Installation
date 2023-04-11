note
	description: "Summary description for {NS_IMAGE_CONSTANTS}."
	author: "Daniel Furrer"
	date: "$Date: 2013-05-20 23:15:17 +0000 (Mon, 20 May 2013) $"
	revision: "$Revision: 92557 $"

class
	NS_IMAGE_CONSTANTS

feature -- Access

	image_name_info: NS_STRING
		once
			create Result.make_weak_from_pointer ({NS_IMAGE}.image_name_info)
		end

end
