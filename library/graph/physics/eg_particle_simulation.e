﻿note
	description: "[
		In an EG_PARTICLE_SIMULATION any number of EG_PARTICLEs are interacting with each
		other in a way that is defined by the implementer of `n_body_force'. The force
		affecting `a_particle' can be retrieved by querying `force' resulting a NUMERIC
		describing the force. Currently there are two implementation for `n_body_force_solver':

											(best case) runtime
			EG_PARTICLE_SIMULATION_N2			O (n^2)
			EG_PARTICLE_SIMULATION_BH			O (n log n)

		EG_PARTICLE_SIMULATION_N2 uses the straight forward way to calculating the force, meaning
			comparing each particle with each other.
		EG_PARTICLE_SIMULATION_BH uses the method proposed by Barnes and Hut (see comment there for
			more information).
		EG_PARTICLE_SIMULATION works for EG_PARTICLE located in a two dimensional space.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Benno Baumgartner"
	date: "$Date: 2017-01-05 17:52:29 +0000 (Thu, 05 Jan 2017) $"
	revision: "$Revision: 99702 $"

deferred class
	EG_PARTICLE_SIMULATION [G -> NUMERIC]

feature {NONE} -- Initialization

	make_with_particles (a_particles: like particles)
			-- Make an EG_PARTICLE_SIMULATION with `a_particles' interacting with each other.
		require
			a_particles_not_void: a_particles /= Void
			not_empty: not a_particles.is_empty
		do
			default_create
			set_particles (a_particles)
		ensure
			set: particles = a_particles
		end

feature -- Access

	force (a_particle: like particle_type): G
			-- The force affecting `a_particle'.
		do
			Result := external_force (a_particle) + nearest_neighbor_force (a_particle)
			if attached n_body_force_solver (a_particle) as v then
				Result := Result + v
			end
		ensure
			Result_exists: Result /= Void
		end

		feature -- Access

	particles: LIST [like particle_type]
		-- Particles in the system.

feature -- Element change.

	set_particles (a_particles: like particles)
			-- Set `particles' to `a_particles'
		require
			a_particles_not_void: a_particles /= Void
			not_empty: not a_particles.is_empty
		do
			particles := a_particles
		ensure
			set: particles = a_particles
		end

feature {NONE}

	external_force (a_particle: like particle_type): G
			-- Initial force for `a_particle'
		deferred
		ensure
			Result_exists: Result /= Void
		end

	nearest_neighbor_force (a_particle: like particle_type): G
			-- Force between `a_particle' and its neighbors.
		deferred
		ensure
			Result_exists: Result /= Void
		end

	n_body_force (a_particle, an_other: EG_PARTICLE): G
			-- Force between `a_particle' and `an_other' particle.
		deferred
		ensure
			Result_exists: Result /= Void
		end

	n_body_force_solver (a_particle: EG_PARTICLE): detachable G
			-- Solve n_nody_force for `a_particle'.
		deferred
		end

feature {NONE} -- Implementation

	particle_type: EG_PARTICLE
			-- Type of particles.
		require
			is_used_as_type_anchor: False
		do
			check is_used_as_type_anchor: False then end
		ensure
			is_used_as_type_anchor: False
		end

invariant
	particles_exist: particles /= Void
	particles_not_empty: not particles.is_empty

note
	copyright:	"Copyright (c) 1984-2016, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
