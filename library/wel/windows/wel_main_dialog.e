note
	description: "Modeless dialog box to use as a application's %
		%main window."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2013-01-07 22:30:41 +0000 (Mon, 07 Jan 2013) $"
	revision: "$Revision: 90426 $"

class
	WEL_MAIN_DIALOG

inherit
	WEL_MODELESS_DIALOG
		rename
			make_by_id as dialog_make_by_id,
			make_by_name as dialog_make_name
		redefine
			activate
		end

create
	make_by_id,
	make_by_name

feature {NONE} -- Initialization

	make_by_id (an_id: INTEGER)
			-- Initialize a loadable dialog box identified by
			-- `an_id'.
		do
			parent := Void
			resource_id := an_id
			create dialog_children.make
		ensure
			no_parent: parent = Void
			resource_id_set: resource_id = an_id
			dialog_children_not_void: dialog_children /= Void
		end

	make_by_name (a_name: READABLE_STRING_GENERAL)
			-- Initialize a loadable dialog box identified by
			-- `a_name'.
		require
			name_not_void: a_name /= Void
			name_not_empty: not a_name.is_empty
		do
			parent := Void
			create resource_name.make_from_string_general (a_name)
			create dialog_children.make
		ensure
			no_parent: parent = Void
			resource_name_set: attached resource_name as l_name and then l_name.same_string_general (a_name)
			dialog_children_not_void: dialog_children /= Void
		end

feature -- Basic operations

	activate
			-- Activate the dialog.
		do
			internal_dialog_make (parent, resource_id, resource_name)
		end

note
	copyright:	"Copyright (c) 1984-2010, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class WEL_MAIN_DIALOG

