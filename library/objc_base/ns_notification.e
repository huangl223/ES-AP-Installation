note
	description: "Wrapper for NSNotification."
	author: "Daniel Furrer"
	date: "$Date: 2013-05-20 23:15:17 +0000 (Mon, 20 May 2013) $"
	revision: "$Revision: 92557 $"

class
	NS_NOTIFICATION

inherit
	NS_OBJECT

create {NS_OBJECT, OBJC_CALLBACK_MARSHAL}
	make_from_pointer,
	share_from_pointer

feature -- Creating Notifications

	make_with_name_object (a_name: NS_STRING_BASE; a_an_object: NS_OBJECT)
			-- Returns a new notification object with a specified name and object.
		do
			share_from_pointer ({NS_NOTIFICATION_API}.notification_with_name_object (a_name.item, a_an_object.item))
		end

	make_with_name_object_user_info (a_name: NS_STRING_BASE; a_an_object: NS_OBJECT; a_user_info: NS_DICTIONARY)
			-- Returns a notification object with a specified name, object, and user information.
		do
			share_from_pointer ({NS_NOTIFICATION_API}.notification_with_name_object_user_info (a_name.item, a_an_object.item, a_user_info.item))
		end

feature -- Getting Notification Information

	name: NS_STRING_BASE
			-- Returns the name of the notification.
		do
			create Result.share_from_pointer ({NS_NOTIFICATION_API}.name (item))
		end

	object: detachable NS_OBJECT
			-- Returns the object associated with the notification.
		local
			l_window: POINTER
		do
			l_window := {NS_NOTIFICATION_API}.object (item)
			if l_window /= default_pointer then
				if attached {NS_OBJECT} callback_marshal.get_eiffel_object (l_window) as res then
					Result := res
				else
					create Result.share_from_pointer (l_window)
				end
			end
		end

	user_info: NS_DICTIONARY
			-- Returns the user information dictionary associated with the receiver.
		do
			create Result.share_from_pointer ({NS_NOTIFICATION_API}.user_info (item))
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
