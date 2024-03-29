note
	description:
		"Projection to a Printer."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "printer, output, projector"
	date: "$Date: 2017-05-03 15:56:14 +0000 (Wed, 03 May 2017) $"
	revision: "$Revision: 100317 $"

class
	EV_MODEL_PRINT_PROJECTOR

inherit

	EV_ANY
		redefine
			implementation
		end

	EV_MODEL_PROJECTOR
		undefine
			default_create,
			copy
		end

create
	make_with_context

feature {NONE} -- Initialization

	make_with_context (a_world: EV_MODEL_WORLD; a_context: EV_PRINT_CONTEXT)
			-- Create with `a_world' and `a_context'.
		require
			a_world_not_void: a_world /= Void
			a_context_not_void: a_context /= Void
			has_printer: not a_context.output_to_file implies (create {EV_ENVIRONMENT}).has_printer
			output_file_unique: a_context.output_to_file implies
						not file_path_exist (a_context.file_path)
		do
			world := a_world
			context := a_context.twin
			default_create
		end

feature -- Query

	file_exist (a_file_name: READABLE_STRING_GENERAL): BOOLEAN
			-- Does file named `a_file_name' exist?
		obsolete
			"Use `file_path_exist' instead. [2017-05-31]"
		local
			l_fu: FILE_UTILITIES
		do
			Result := l_fu.file_exists (a_file_name)
		end

	file_path_exist (a_file_name: PATH): BOOLEAN
			-- Does file named `a_file_name' exist?
		local
			l_fu: FILE_UTILITIES
		do
			Result := l_fu.file_path_exists (a_file_name)
		end

feature -- Basic operations

	project
			-- Make a standard projection of the world on the device.
		require
			not_destroyed: not is_destroyed
		do
			implementation.project
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	context: EV_PRINT_CONTEXT

	implementation: EV_MODEL_PRINT_PROJECTOR_I

feature {NONE} -- Implementation

	create_interface_objects
			-- <Precursor>
		do

		end

	create_implementation
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_MODEL_PRINT_PROJECTOR_IMP} implementation.make_with_context (world, context)
		end

note
	copyright:	"Copyright (c) 1984-2012, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class EV_PRINT_PROJECTOR





