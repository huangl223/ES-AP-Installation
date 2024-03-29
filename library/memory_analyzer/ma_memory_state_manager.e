note
	description: "[
					This is the managet of MEMORY_STATE which can save/open states from file

																							]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2017-01-13 13:16:55 +0000 (Fri, 13 Jan 2017) $"
	revision: "$Revision: 99720 $"

class
	MA_MEMORY_STATE_MANAGER

inherit
	MA_SINGLETON_FACTORY

create
	make

feature {NONE} -- Initialization

	make (n: INTEGER; a_main_window: like main_window)
			-- creation method
		do
			main_window := a_main_window
			create memory_states.make (1)
		end

	main_window: MA_WINDOW
			-- Main Window.

feature -- Access

	states: like memory_states
			-- Get the MEMORY_STATE's ARRAYED_LIST
		do
			Result := memory_states
		ensure
			result_not_void: Result /= Void
		end

	extend (a_state: MA_MEMORY_STATE)
			-- Add a memory state to the array_list
		do
			memory_states.extend (a_state)
		end

	i_th alias "[]" (i: INTEGER): MA_MEMORY_STATE
			-- The i_th memory state of the memory_states current hold.
		do
			Result := memory_states [i]
		end


feature -- Status report

	count: INTEGER
			-- The memory states already contorl by the memory manager
		do
			Result := memory_states.count
		end


--	is_user_click_ok: BOOLEAN is
--			-- Whether user click ok button on Open/Save file dialog.
--		do
--			Result := user_click_ok
--		end

feature -- Open/Save States

	save_states
			-- Save current states to a disk file.
		local
			l_dialog: EV_FILE_SAVE_DIALOG
		do
--			user_click_ok := False
			create l_dialog
			l_dialog.filters.extend (state_file_suffix)
			l_dialog.save_actions.extend (agent save_states_2_file (l_dialog))
			l_dialog.show_modal_to_window (main_window)
		end

	open_states
			-- Retreive the states from a disk file.
		local
			l_dialog: EV_FILE_OPEN_DIALOG
		do
			create l_dialog
			l_dialog.filters.extend (state_file_suffix)
			l_dialog.open_actions.extend (agent open_states_from_file (l_dialog))
			l_dialog.show_modal_to_window (main_window)
		end

feature {NONE} -- Implementation

	save_states_2_file (a_dialog: EV_FILE_SAVE_DIALOG)
			-- Save memory analyzer's datas to a file.
		local
			l_data_file: RAW_FILE
			l_suffix: STRING
		do
			l_suffix := state_file_suffix.filter
			l_suffix := l_suffix.substring (2, l_suffix.count)
			create l_data_file.make_create_read_write (a_dialog.file_name + l_suffix)
			memory_states.basic_store (l_data_file)
		end

	open_states_from_file (a_dialog: EV_FILE_OPEN_DIALOG)
			-- Open memory analyzer's datas from a file
		do
			if attached {like memory_states} memory_states.retrieve_by_name (a_dialog.file_name) as l_states then
				memory_states := l_states
			else
					--|FIXME: 2012/04/06 This should be removed when we handle corrupted files. See review#7644004.
				check memory_states_not_retrieved: False end
			end
		ensure
			states_not_void: memory_states /= Void
		end

	memory_states: MA_ARRAYED_LIST_STORABLE [MA_MEMORY_STATE]
			-- The memory states this managers hold.
invariant
	memory_states_not_void: memory_states /= Void

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
