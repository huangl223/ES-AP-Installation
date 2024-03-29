note
	description: "[
		C CURLMSG enum
	]"
	date: "$Date: 2017-08-24 08:03:16 +0000 (Thu, 24 Aug 2017) $"
	revision: "$Revision: 100665 $"

class
	CURL_MSG

feature -- Query

	curlmsg_done: INTEGER
			-- Declared as CURLMSG_DONE.
			-- This easy handle has completed.
			-- 'result' contains the CURLcode of the transfer			
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLMSG_DONE;"
		end

	curlmsg_none: INTEGER
			-- Declared as CURLMSG_NONE.
			-- First, not used
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLMSG_NONE;"
		end

	curlmsg_last: INTEGER
			-- Declared as CURLMSG_LAST.
			-- Last, not used
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLMSG_LAST;"
		end

note
	copyright: "Copyright (c) 1984-2017, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
