	note
	description: "Class that store all singletons in the system.%
				 %Class want to use the singletons it contains should inherit this class."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2017-05-03 08:43:46 +0000 (Wed, 03 May 2017) $"
	revision: "$Revision: 100308 $"

class
	MA_SINGLETON_FACTORY

feature  -- Singletons

	filter: MA_FILTER_SINGLETON
			-- FILTER_SINGLETON instance
		local
			l_item: detachable MA_FILTER_SINGLETON
		do
			l_item := internal_filter.item
			if attached l_item then
				Result := l_item
			else
				l_item := create {MA_FILTER_SINGLETON}.make
				internal_filter.put (l_item)
				Result := l_item
			end
		ensure
			filter_not_void: Result /= Void
		end

	filter_window: MA_FILTER_WINDOW
			-- FILTER_WINDOW instance
		local
			l_item: detachable MA_FILTER_WINDOW
		do
			l_item := internal_filter_window.item
			if attached l_item then
				Result := l_item
			else
				l_item := create {MA_FILTER_WINDOW}.make
				internal_filter_window.put (l_item)
				Result := l_item
			end
		ensure
			filter_window_not_void: Result /= Void
		end

	grid_util: MA_GRID_UTIL_SINGLETON
			-- GRID_UTIL_SINGLETON instance
		once
			create Result
		ensure
			grid_util_not_void: Result /= Void
		end

	object_finder: MA_OBJECT_FINDER_SINGLETON
			-- OBJECT_FINDER_SINGLETON instance
		once
			create Result
		ensure
			object_finder_not_void: Result /= Void
		end

	system_util: MA_SYSTEM_UTIL_SINGLETON
			-- SYSTEM_UTIL_SINGLETON instance
		once
			create Result
		ensure
			system_util_not_void: Result /= Void
		end

	internal: INTERNAL
			-- INTERNAL instance
		once
			create Result
		ensure
			internal_made: internal /= Void
		end

	memory: MEMORY
			-- MEMORY singleton
		once
			create Result
		ensure
			memory_not_void: Result /= Void
		end

	icons: MA_ICONS_SINGLETON
			-- ICONS_SINGLETON instance
		once
			create Result
		ensure
			icons_not_void: Result /= Void
		end

feature -- Cursors

	accept_node: EV_POINTER_STYLE
			-- Icon used when picking
		once
			create Result.make_with_pixmap (icons.eiffel_pebble_icon, 8, 8)
		ensure
			accept_node_not_void: Result /= Void
		end

	deny_node: EV_POINTER_STYLE
			-- Icon used when picking
		once
			create Result.make_with_pixmap (icons.eiffel_pebble_x_icon, 8, 8)
		ensure
			deny_node_not_void: Result /= Void
		end

	accept_node_class: EV_POINTER_STYLE
			-- Icon used when picking
		local
			pix: EV_PIXMAP
		once
			create pix
			create Result.make_with_pixmap (icons.object_grid_class_icon, 8, 8)
		ensure
			accept_node_class: Result /= Void
		end

	deny_node_class: EV_POINTER_STYLE
			-- Icon used when picking
		once
			create Result.make_with_pixmap (icons.object_grid_class_x_icon, 8, 8)
		ensure
			deny_node_class: Result /= Void
		end

feature -- Colors

	increased_color: EV_COLOR
			-- Color used when object count increased.
		once
			Result := (create {EV_STOCK_COLORS}).red
		ensure
			red_color_set: Result /= Void
		end

	decreased_color: EV_COLOR
			-- Color used when obejct count decreased.
		once
			Result := (create {EV_STOCK_COLORS}).dark_green
		ensure
			green_color_set: Result /= Void
		end

feature {NONE} -- misc

	internal_filter: CELL [detachable MA_FILTER_SINGLETON]
			-- MA_FILTER_SINGLETON instance's cell.
		once
			create Result.put (Void)
		end

	internal_filter_window: CELL [detachable MA_FILTER_WINDOW]
			-- MA_FILTER_WINDOW instance'e cell.
		once
			create Result.put (Void)
		end

	state_file_suffix: TUPLE [filter: STRING; text: STRING]
			-- Suffix of the States File name.
		once
			Result := ["*.ema", "Eiffel Memory Analyzer Datas (*.ema)"]
		end

	filter_filter_suffix: TUPLE [filter: STRING; text: STRING]
			-- Suffix of the Filter File name.
		once
			Result := ["*.emf", "Eiffel Memory Analyzer Filter (*.emf)"]
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
