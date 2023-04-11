note
	description: "[
			Indexable containers with arbitrary bounds, whose elements are stored in a continuous memory area.
			Random access is constant time, but resizing requires memory reallocation and copying elements, and takes linear time.
			The logical size of array is the same as the physical size of the underlying memory area.
		]"
	author: "Nadia Polikarpova"
	revised_by: "Alexander Kogtenkov"
	model: sequence, lower_, closed
	manual_inv: true
	false_guards: true

frozen class
	V_ARRAY [G]

inherit
	V_MUTABLE_SEQUENCE [G]
		redefine
			is_equal_,
			upper,
			fill,
			clear,
			is_model_equal
		end

create
	make,
	make_filled,
	copy_

feature {NONE} -- Initialization

	make (l, u: INTEGER)
			-- Create array with indexes in [`l', `u']; set all values to default.
		note
			status: creator
		require
			valid_indexes: l <= u + 1
		do
			if l <= u then
				lower := l
				upper := u
			else
				lower := 1
				upper := 0
			end
			create area.make_filled (({G}).default, upper - lower + 1)
			create sequence.constant (({G}).default, u - l + 1)
		ensure
			sequence_domain_definition: sequence.count = u - l + 1
			sequence_definition: ∀ i: 1 |..| sequence.count ¦ sequence [i] = ({G}).default
			lower_definition: lower_ = if l <= u then l else 1 end
			no_observers: observers.is_empty
		end

	make_filled (l, u: INTEGER; v: G)
			-- Create array with indexes in [`l', `u']; set all values to `v'.
		note
			status: creator
		require
			valid_indexes: l <= u + 1
		do
			if l <= u then
				lower := l
				upper := u
			else
				lower := 1
				upper := 0
			end
			create area.make_filled (v, u - l + 1)
				-- Li *
				-- capacity := u - l + 1
			create sequence.constant (v, u - l + 1)
				-- *
		ensure
			sequence_domain_definition: sequence.count = u - l + 1
			sequence_definition: ∀ i: 1 |..| sequence.count ¦ sequence [i] = v
			lower_definition: lower_ = if l <= u then l else 1 end
			no_observers: observers.is_empty
		end

feature -- Initialization

	copy_ (other: like Current)
			-- Initialize by copying all the items of `other'.
			-- Reallocate memory unless count stays the same.
			-- note
			-- 	explicit: wrapping
		require
			observers_open: ∀ o: observers ¦ o.is_open
				-- Li
			other_not_void: other /= Void
		do
				-- unwrap
			if other /= Current then
				check other.inv end
				if area = Void or other.count /= upper - lower + 1 then
					create area.make_filled (({G}).default, other.count)
						-- Li *
					create sequence.default_create
						-- capacity := other.count
						-- fill_with(({G}).default, 0, other.count - 1)
						-- *
				end
				check area.inv end
				check area.is_wrapped end
				area.copy_data (other.area, 0, 0, other.count)
					-- Li *
				sequence := sequence.front (0) + other.sequence.interval (1, other.count) + sequence.tail (other.count + 1)
					-- *
				lower := other.lower
				upper := other.upper

				check other.is_wrapped end
					-- wrap
			end
		ensure
			observers_open: ∀ o: observers ¦ o.is_open
			sequence_effect: sequence ~ old other.sequence
			lower_effect: lower_ = old other.lower_
			lower_effect: lower = old other.lower
			modify_model (["sequence", "lower_", "closed"], Current)
		end

feature -- Access

	item alias "[]" (i: INTEGER): G assign put
			-- Value associated with `i'.
		require else
			valid_index: lower <= i and i <= upper
		do
			check inv end
			Result := area [i - lower]
		ensure then
			definition: Result = sequence [i - lower + 1]
		end

	subarray (l, u: INTEGER): V_ARRAY [G]
			-- Array consisting of elements of Current in index range [`l', `u'].
		note
			status: impure
		require
			l_not_too_small: l >= lower_
			u_not_too_large: u <= upper_
			l_not_too_large: l <= u + 1
		do
			create Result.make (l, u)
			check Result.inv end
			Result.copy_range (Current, l, u, Result.lower)
			check ∀ i: 1 |..| Result.sequence.count ¦ Result.sequence [i] = sequence [i - 1 + idx (l)] end
		ensure
			result_wrapped: Result.is_wrapped
			result_fresh: Result.is_fresh
			result_sequence_definition: Result.sequence ~ sequence.interval (idx (l), idx (u))
			result_lower_definition: l <= u implies Result.lower_ = l
			observers_unchanged: observers ~ old observers
			modify_model (["observers", "closed"], Current)
		end

feature -- Measurement

	lower: INTEGER
			-- Lower bound of index interval.

	upper: INTEGER
			-- Upper bound of index interval.

	count: INTEGER
			-- Number of elements.
		note
		    status: pure
			explicit: wrapping
		do
			check inv end
			Result := upper - lower + 1
		end

feature -- Iteration

	at (i: INTEGER): V_ARRAY_ITERATOR [G]
			-- New iterator pointing at position `i'.
		note
			status: impure
			explicit: wrapping
		do
			check inv end
			create Result.make (Current, i - lower + 1)
		end

feature -- Comparison

	is_equal_ (other: like Current): BOOLEAN
			-- Is array made of the same items as `other'?
			-- (Use reference comparison.)
		do
			check inv; other.inv end
			if other = Current then
				Result := True
			elseif lower = other.lower and upper = other.upper then
				Result := area.same_items (other.area, 0, 0, count)
			end
		end

feature -- Replacement

	put (v: G; i: INTEGER)
			-- Put `v' at position `i'.
			-- Li*
		require else
			in_domain: lower <= i and i <= upper
			-- *
		do
			area.put (v, i - lower)
				-- Li *
				-- check 1 <= i and i <= sequence.count end
			sequence := sequence.replaced_at (i - lower + 1, v)
				-- *
		ensure then
			modify_model (["closed"], Current)
		end

	fill (v: G; l, u: INTEGER)
			-- Put `v' at positions [`l', `u'].
			-- Li*
			--note
			--	explicit: wrapping
		require else
			start_index_non_negative: l - lower >= 0
			start_index_in_bound: l - lower <= count
			start_index_not_too_big: l - lower <= u - lower + 1
			-- *
		local
			i, nb: INTEGER
			l_count: like count
		do
			check area.inv end
			area.fill_with (v, l - lower, u - lower)

				-- Li*
				-- check l - lower >= 0 and  l - lower <= count and l - lower <= u - lower + 1 end
				-- *precondition of count fails*
				-- boogie assertion:
				-- function pre.fun.V_ARRAY^ANY^.count(heap: HeapType, current: ref) returns (bool) {
				--     is_closed(heap, current)
				-- }
			seq_fill_with (v, l - lower, u - lower)
				-- *
		ensure then
			modify_model (["sequence", "lower_", "closed"], Current)
		end

	clear (l, u: INTEGER)
			-- Put default value at positions [`l', `u'].
		do
			area.fill_with_default (l - lower, u - lower)
		ensure then
			modify_model (["sequence", "lower_", "closed"], Current)
		end

	copy_range_within (fst, lst, index: INTEGER)
			-- Copy items within the same array, from the interval [`fst', `lst'] to position `index'.
		require
			first_not_too_small: fst >= lower_
			last_not_too_large: lst <= upper_
			first_not_too_large: fst <= lst + 1
			index_not_too_small: index >= lower_
			enough_space: upper_ - index >= lst - fst
			observers_open: ∀ o: observers ¦ o.is_open
		do
			if lst >= fst then
				check area.inv end
				area.move_data (fst - lower_, index - lower_, lst - fst + 1)
					-- Li *
				sequence := sequence.front (index - lower) + sequence.interval (fst - lower + 1, lower + 1) + sequence.tail (index - lower + lst - fst + 2)
					-- *
			end
		ensure
			sequence_domain_effect: sequence.count = old sequence.count
			sequence_effect: ∀ i: 1 |..| sequence.count ¦ if idx (index) <= i and i < idx (index + lst - fst + 1)
					then sequence [i] = (old sequence) [i - index + fst]
					else sequence [i] = (old sequence) [i] end
			modify_model (["sequence", "closed"], Current)
		end

feature -- Resizing

	seq_fill_with (v: G; start_index, end_index: INTEGER)
			-- Set items between `start_index' and `end_index' with `v'.
		note
			explicit: wrapping
		local
			i, nb: INTEGER
			l_count: INTEGER
		do
			from
				i := start_index
				l_count := sequence.count.min (end_index + 1)
				nb := l_count
			until
				i = nb
			loop
				sequence := sequence.replaced_at (i + 1, v)
				i := i + 1
			end
			from
				i := l_count
				nb := end_index + 1
			until
				i = nb
			loop
				sequence := sequence & v
				i := i + 1
			end
		ensure
			modify_field (["sequence", "closed"], Current)

		end

	resize (l, u: INTEGER)
			-- Set index interval to [`l', `u']; keep values at old indexes; set to default at new indexes.
			-- Reallocate memory unless count stays the same.
		note
			explicit: wrapping
		require
			valid_indexes: l <= u + 1
			observers_open: ∀ o: observers ¦ o.is_open
		local
			new_count, x, y: INTEGER
			i, nb: INTEGER
			l_count: like count
		do
			new_count := u - l + 1
			if new_count = 0 then
				wipe_out
			else
				if new_count > area.count then
					area := area.aliased_resized_area_with_default (({G}).default, new_count)
						-- Li *
					sequence := sequence.front (new_count)
					seq_fill_with (({G}).default, sequence.count, new_count - 1)
						-- *
				end

				x := lower.max (l)
				y := upper.min (u)
				if x > y then
						-- No intersection
					area.fill_with_default (0, area.count - 1)
						-- Li *
					seq_fill_with (({G}).default, 0, sequence.count - 1)
						-- *
				else
						-- Intersection
					check area.inv end
					area.move_data (x - lower, x - l, y - x + 1)
						-- move_data (source_index, destination_index, n: INTEGER)
					area.fill_with_default (0, x - l - 1)
					area.fill_with_default (y - l + 1, area.count - 1)

						-- Li *
					sequence := sequence.front (x - l) + sequence.interval (x - lower + 1, y - lower + 1) +
						sequence.tail (y - l + 2)
					seq_fill_with (({G}).default, 0, x - l - 1)
					seq_fill_with (({G}).default, y - l + 1, sequence.count - 1)
						-- *

				end
				if new_count < area.count then
					area := area.resized_area (new_count)
						-- Li*
					sequence := sequence.front (0) + sequence.interval (1, new_count.min (count)) + sequence.tail (new_count.min (count) + 1)
						-- *
				end
				lower := l
				upper := u
			end
		ensure
			lower_effect: lower_ = if l <= u then l else 1 end
			upper_effect: upper_ = if l <= u then u else 0 end
			sequence_effect_old: ∀ k: 1 |..| sequence.count ¦ ∀ j: 1 |..| sequence.count ¦
						idx (old lower_) <= k and k <= idx (old upper_) and j = k + lower_ - old lower_ implies
						sequence [k] = (old sequence) [j]
			sequence_effect_new: ∀ k: 1 |..| sequence.count ¦
					k < idx (old lower_) or idx (old upper_) < k implies sequence [k] = ({G}).default
			modify_model (["sequence", "lower_", "closed"], Current)
		end

	include (i: INTEGER)
			-- Resize in a minimal way to include index `i'; keep values at old indexes; set to default at new indexes.
			-- Reallocate memory unless count stays the same.
		note
			explicit: wrapping
		require
			observers_open: ∀ o: observers ¦ o.is_open
		do
			check inv end
			if is_empty then
				resize (i, i)
			elseif i < lower then
				resize (i, upper)
			elseif i > upper then
				resize (lower, i)
			end
		ensure
			lower_effect: lower_ = if old sequence.is_empty then i else i.min (old lower_) end
			upper_effect: upper_ = if old sequence.is_empty then i else i.max (old upper_) end
			sequence_effect_old: ∀ k: 1 |..| sequence.count ¦ ∀ j: 1 |..| sequence.count ¦
						idx (old lower_) <= k and k <= idx (old upper_) and j = k + lower_ - old lower_ implies
						sequence [k] = (old sequence) [j]
			sequence_effect_new: ∀ k: 1 |..| sequence.count ¦
					k < idx (old lower_) or idx (old upper_) < k implies sequence [k] = ({G}).default
			modify_model (["sequence", "lower_", "closed"], Current)
		end

	force (v: G; i: INTEGER)
			-- Put `v' at position `i'; if position is not defined, include it.
			-- Reallocate memory unless count stays the same.
		note
			explicit: wrapping
		require
			observers_open: ∀ o: observers ¦ o.is_open
			-- Li *
			-- *
		do
			include (i)
			check 0 <= i and i <= sequence.count - 1 end
			put (v, i)
		ensure
			lower_effect: lower_ = if old sequence.is_empty then i else i.min (old lower_) end
			upper_effect: upper_ = if old sequence.is_empty then i else i.max (old upper_) end
			sequence_effect_i: sequence [idx (i)] = v
			sequence_effect_old: ∀ k: 1 |..| sequence.count ¦ ∀ j: 1 |..| sequence.count ¦
						k /= idx (i) and idx (old lower_) <= k and k <= idx (old upper_) and j = k + lower_ - old lower_ implies
						sequence [k] = (old sequence) [j]
			sequence_effect_new: ∀ k: 1 |..| sequence.count ¦
					k /= idx (i) and (k < idx (old lower_) or idx (old upper_) < k) implies sequence [k] = ({G}).default
			modify_model (["sequence", "lower_", "closed"], Current)
		end

	wipe_out
			-- Remove all elements.
		require
			observers_open: ∀ o: observers ¦ o.is_open
		do
			create area.make_empty (0)
			lower := 1
			upper := 0
		ensure
			sequence_effect: sequence.is_empty
			lower_effect: lower_ = 1
			modify_model (["sequence", "lower_", "closed"], Current)
		end

feature {V_CONTAINER, V_ITERATOR} -- Implementation

	area: V_SPECIAL [G]
			-- Memory area where elements are stored.

feature -- Specification

	is_model_equal (other: like Current): BOOLEAN
			-- Is the abstract state of `Current' equal to that of `other'?
		note
			status: ghost, functional
		do
			Result := sequence ~ other.sequence and lower_ = other.lower_
		end

invariant
	area_exists: area /= Void
	lower_definition: lower_ = lower
	upper_definition: upper = lower_ + sequence.count - 1
	owns_definition: owns ~ create {MML_SET [ANY]}.singleton (area)
	sequence_implementation: sequence ~ area.sequence
	-- sequence_implementation makes connection between abstract state and concrete state,
	-- however, area.sequence is also an abstract state
	-- thus, this relation expresses the equality between two abstract sequences
	-- solution: provide two sequences implementation

note
	explicit: observers
	date: "$Date: 2021-07-15 20:57:26 +0800 (周四, 15 7月 2021) $"
	revision: "$Revision: 105637 $"
	copyright: "Copyright (c) 1984-2021, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
