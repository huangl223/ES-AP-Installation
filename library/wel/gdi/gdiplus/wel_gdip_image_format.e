note
	description: "Image format used by Gdi+"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2015-08-19 05:18:55 +0000 (Wed, 19 Aug 2015) $"
	revision: "$Revision: 97838 $"

class
	WEL_GDIP_IMAGE_FORMAT

obsolete
	"Use {WEL_GDIP_IMAGE_ENCODER} instead"

create
	make

feature {NONE} -- Initlization

	make (a_guid: WEL_GUID)
			-- Creation method
		require
			not_void: a_guid /= Void
		do
			guid := a_guid
		ensure
			set: guid = a_guid
		end

feature -- Query

	guid: WEL_GUID
			-- Guid

	find_encoder: detachable WEL_GDIP_IMAGE_CODEC_INFO
			-- Find image encoder related.
		local
			l_all_encoders: ARRAYED_LIST [WEL_GDIP_IMAGE_CODEC_INFO]
			l_image: WEL_GDIP_IMAGE
		do
			from
				create l_image
				l_all_encoders := l_image.all_image_encoders
				l_all_encoders.start
			until
				l_all_encoders.after or Result /= Void
			loop
				if l_all_encoders.item.format_id ~ guid then
					Result := l_all_encoders.item
				end
				l_all_encoders.forth
			end
		end

note
	copyright:	"Copyright (c) 1984-2015, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"


end
