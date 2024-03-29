﻿note
	description: "Objects that produces views for given models."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2019-08-02 08:08:17 +0000 (Fri, 02 Aug 2019) $"
	revision: "$Revision: 103380 $"

deferred class
	EG_FIGURE_FACTORY

feature -- Access

	world: detachable EG_FIGURE_WORLD
			-- World `Current' is a factory for.

	new_node_figure (a_node: EG_NODE): EG_LINKABLE_FIGURE
			-- Create a node figure for `a_node'.
		require
			a_node_not_void: a_node /= Void
		deferred
		ensure
			result_not_void: Result /= Void
		end

	new_cluster_figure (a_cluster: EG_CLUSTER): EG_CLUSTER_FIGURE
			-- Create a cluster figure for `a_cluster'.
		require
			a_cluster_not_void: a_cluster /= Void
		deferred
		ensure
			result_not_void: Result /= Void
		end

	new_link_figure (a_link: EG_LINK): EG_LINK_FIGURE
			-- Create a link figure for `a_link'.
		require
			a_link_not_void: a_link /= Void
		deferred
		ensure
			result_not_void: Result /= Void
		end

	model_from_xml (node: attached like xml_element_type): detachable EG_ITEM
			-- Create an EG_ITEM from `node' if possible.
		require
			node_not_void: node /= Void
		deferred
		end

	xml_element_type: XML_ELEMENT
			-- Element type for compilation purpose.
		do
			check should_not_be_used: False then end
		end

feature {EG_FIGURE_WORLD} -- Implementation

	set_world (a_world: like world)
			-- Set `world' to `a_world'.
		require
			a_world_not_void: a_world /= Void
		do
			world := a_world
		ensure
			set: world = a_world
		end

feature {NONE} -- Implementation

	linkable_with_name (a_name: READABLE_STRING_32): detachable EG_LINKABLE
			-- Linkable with name `a_name' in graph if any
		require
			a_name_not_void: a_name /= Void
			world_not_void: world /= Void
		local
			nodes: LIST [EG_NODE]
			clusters: LIST [EG_CLUSTER]
			l_world: like world
		do
			l_world := world
			if l_world /= Void and then attached l_world.model as l_world_model then
				nodes := l_world_model.flat_nodes
				if nodes /= Void then
					from
						nodes.start
					until
						nodes.after or else Result /= Void
					loop
						if nodes.item.name_32 ~ a_name then
							Result := nodes.item
						end
						nodes.forth
					end
				end
				if Result = Void then
					from
						clusters := l_world_model.flat_clusters
						clusters.start
					until
						clusters.after or else Result /= Void
					loop
						if clusters.item.name_32 ~ a_name then
							Result := clusters.item
						end
						clusters.forth
					end
				end
			else
				check world_not_void: world /= Void end -- Implied by precondition `world_not_void'
			end
		end

note
	copyright:	"Copyright (c) 1984-2019, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
