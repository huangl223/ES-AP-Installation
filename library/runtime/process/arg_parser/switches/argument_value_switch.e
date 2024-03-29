﻿note
	description: "A command line switch that accepts a value."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2017-04-14 08:31:31 +0000 (Fri, 14 Apr 2017) $"
	revision: "$Revision: 100187 $"

class
	ARGUMENT_VALUE_SWITCH

inherit
	ARGUMENT_SWITCH
		rename
			make as make_base,
			make_hidden as make_hidden_base
		end

create
	make,
	make_hidden

feature {NONE} -- Initialization

	make (a_id: like id; a_desc: like description;
			a_optional: like optional; a_allow_mutliple: like allow_multiple;
			a_arg_name: like arg_name; a_arg_desc: like arg_description; a_val_optional: like is_value_optional
			)
			-- Initialize a new value option.
			--
			-- Note: To use long and short names set name `a_id' := "s|long"
		require
			a_id_attached: a_id /= Void
			not_a_id_is_empty: not a_id.is_empty
			a_id_is_valid_id: is_valid_id (a_id)
			a_desc_attached: a_desc /= Void
			not_a_desc_is_empty: not a_desc.is_empty
			a_arg_name_attached: a_arg_name /= Void
			not_a_arg_name_is_empty: not a_arg_name.is_empty
			a_arg_desc_attached: a_arg_desc /= Void
			not_a_arg_desc_is_empty: not a_arg_desc.is_empty
		do
			make_base (a_id, a_desc, a_optional, a_allow_mutliple)
			arg_name := a_arg_name
			arg_description := a_arg_desc
			is_value_optional := a_val_optional
		ensure
			id_set: id ~ a_id
			description_set: description ~ a_desc
			optional: optional = a_optional
			arg_name_set: arg_name ~ a_arg_name
			arg_description_set: arg_description ~ a_arg_desc
			is_value_optional_set: is_value_optional = a_val_optional
			allow_multiple_set: allow_multiple = a_allow_mutliple
			not_is_hidden: not is_hidden
		end

	make_hidden (a_id: like id; a_optional: like optional; a_allow_mutliple: like allow_multiple; a_arg_name: like arg_name; a_val_optional: like is_value_optional)
			-- Initialize a new value option.
			--
			-- Note: To use long and short names set name `a_id' := "s|long"
		require
			a_id_attached: a_id /= Void
			not_a_id_is_empty: not a_id.is_empty
			a_id_is_valid_id: is_valid_id (a_id)
			a_arg_name_attached: a_arg_name /= Void
			not_a_arg_name_is_empty: not a_arg_name.is_empty
		do
			make (a_id, internal_switch_description, a_optional, a_allow_mutliple, a_arg_name, internal_argument_description, a_val_optional)
			is_hidden := True
		ensure
			nid_set: id ~ a_id
			optional: optional = a_optional
			arg_name_set: arg_name ~ a_arg_name
			is_value_optional_set: is_value_optional = a_val_optional
			allow_multiple_set: allow_multiple = a_allow_mutliple
			is_hidden: is_hidden
		end

feature -- Access

	arg_name: IMMUTABLE_STRING_32
			-- Value argument description name.

	arg_description: IMMUTABLE_STRING_32
			-- Value argument description.

feature {ARGUMENT_BASE_PARSER} -- Access

	value_validator: ARGUMENT_VALUE_VALIDATOR
			-- Retrieves an validator used to check current switch value.
		once
			create {ARGUMENT_DEFAULT_VALIDATOR} Result
		ensure
			result_attached: Result /= Void
		end

feature -- Status Report

	is_value_optional: BOOLEAN
			-- Indicates if a option value is optional

feature {ARGUMENT_BASE_PARSER} -- Factory Functions

	new_value_option (a_value: READABLE_STRING_GENERAL): ARGUMENT_OPTION
			-- Creates a new argument option given a value for the current switch.
			--
			-- `a_value': The user passed switch value.
			-- `Result': An argument option with the set value
		require
			a_value_attached: a_value /= Void
			not_a_value_is_empty: not a_value.is_empty
		do
			create Result.make_with_value (a_value, Current)
		ensure
			result_attached: Result /= Void
			result_has_value: Result.has_value
			result_value_set: Result.value ~ a_value
		end

invariant
	arg_name_attached: arg_name /= Void
	not_arg_name_is_empty: not arg_name.is_empty
	arg_description_attached: arg_description /= Void
	not_arg_description_is_empty: not arg_description.is_empty

note
	copyright: "Copyright (c) 1984-2017, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
