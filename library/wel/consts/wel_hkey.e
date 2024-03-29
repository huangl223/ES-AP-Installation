﻿note
	description: "Registry keys constants"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2017-12-25 09:53:13 +0000 (Mon, 25 Dec 2017) $"
	revision: "$Revision: 101206 $"

class
	WEL_HKEY

feature -- Status

	basic_valid_value_for_hkey (value: POINTER): BOOLEAN
		-- Return True if 'value' is one of the basic following values.
		do
			if
				value = Hkey_classes_root or else
				value = Hkey_dyn_data or else
				value = Hkey_current_config or else
				value = Hkey_performance_data or else
				value = Hkey_users or else
				value = Hkey_current_user or else
				value = Hkey_local_machine
			then
				Result := True
			end
		end

	basic_valid_name_for_hkey (name: READABLE_STRING_GENERAL): BOOLEAN
			-- Return True if 'name' correspond to one of the
			-- value names below.
		require
			name_possible: name /= Void
			name_valid: name.is_valid_as_string_8
		do
			if
				name.is_case_insensitive_equal ("hkey_classes_root") or else
				name.is_case_insensitive_equal ("hkey_dyn_data") or else
				name.is_case_insensitive_equal ("hkey_current_config") or else
				name.is_case_insensitive_equal ("hkey_performance_data") or else
				name.is_case_insensitive_equal ("hkey_users") or else
				name.is_case_insensitive_equal ("hkey_current_user") or else
				name.is_case_insensitive_equal ("hkey_local_machine")
			then
				Result := True
			end
		end

	index_value_for_root_keys (name: READABLE_STRING_GENERAL): POINTER
			-- Return the index corresponding to a root key.
		require
			name_not_void: name /= Void
			name_valid: name.is_valid_as_string_8
			valid_key: basic_valid_name_for_hkey (name)
		do
			if name.is_case_insensitive_equal ("hkey_classes_root") then
					Result := Hkey_classes_root
			elseif name.is_case_insensitive_equal ("hkey_dyn_data") then
					Result := Hkey_dyn_data
			elseif name.is_case_insensitive_equal ("hkey_current_config") then
					Result := Hkey_current_config
			elseif name.is_case_insensitive_equal ("hkey_performance_data") then
					Result := Hkey_performance_data
			elseif name.is_case_insensitive_equal ("hkey_users") then
					Result := Hkey_users
			elseif name.is_case_insensitive_equal ("hkey_current_user") then
					Result := Hkey_current_user
			elseif name.is_case_insensitive_equal ("hkey_local_machine") then
					Result := Hkey_local_machine
			end
		end

feature -- Access

	frozen Hkey_classes_root: POINTER
		external
			"C [macro %"winreg.h%"] : EIF_POINTER"
		alias
			"HKEY_CLASSES_ROOT"
		ensure
			is_class: class
		end

	frozen Hkey_current_user: POINTER
		external
			"C [macro %"winreg.h%"] : EIF_POINTER"
		alias
			"HKEY_CURRENT_USER"
		ensure
			is_class: class
		end

	frozen Hkey_local_machine: POINTER
		external
			"C [macro %"winreg.h%"] : EIF_POINTER"
		alias
			"HKEY_LOCAL_MACHINE"
		ensure
			is_class: class
		end

	frozen Hkey_users: POINTER
		external
			"C [macro %"winreg.h%"] : EIF_POINTER"
		alias
			"HKEY_USERS"
		ensure
			is_class: class
		end

	frozen Hkey_performance_data: POINTER
		external
			"C [macro %"winreg.h%"] : EIF_POINTER"
		alias
			"HKEY_PERFORMANCE_DATA"
		ensure
			is_class: class
		end

	frozen Hkey_current_config: POINTER
		external
			"C [macro %"winreg.h%"] : EIF_POINTER"
		alias
			"HKEY_CURRENT_CONFIG"
		ensure
			is_class: class
		end

	frozen Hkey_dyn_data: POINTER
		external
			"C [macro %"winreg.h%"] : EIF_POINTER"
		alias
			"HKEY_DYN_DATA"
		ensure
			is_class: class
		end

note
	copyright:	"Copyright (c) 1984-2017, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
