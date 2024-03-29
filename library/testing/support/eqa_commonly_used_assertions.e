note
	description: "[
		Assertions commonly used in testing routines.
	]"
	date: "$Date: 2017-05-03 14:51:35 +0000 (Wed, 03 May 2017) $"
	revision: "$Revision: 100315 $"

class
	EQA_COMMONLY_USED_ASSERTIONS

inherit
	EQA_ASSERTIONS

feature -- Equality

	assert_equal (a_tag: READABLE_STRING_GENERAL; expected, actual: detachable ANY)
			-- Check that `expected ~ actual'.
		require
			a_tag_not_void: a_tag /= Void
		do
			assert (assert_equal_message (a_tag, expected, actual), expected ~ actual)
		end

	assert_not_equal (a_tag: READABLE_STRING_GENERAL; expected, actual: detachable ANY)
			-- Check that `expected /~ actual'.
		require
			a_tag_not_void: a_tag /= Void
		do
			disassert (assert_not_equal_message (a_tag, expected, actual), expected ~ actual)
		end

	assert_reference_equal (a_tag: READABLE_STRING_GENERAL; expected, actual: detachable ANY)
			-- Check that `expected = actual'.
		require
			a_tag_not_void: a_tag /= Void
		do
			assert (assert_equal_message (a_tag, expected, actual), expected = actual)
		end

	assert_not_reference_equal (a_tag: READABLE_STRING_GENERAL; expected, actual: detachable ANY)
			-- Check that `expected /= actual'.
		require
			a_tag_not_void: a_tag /= Void
		do
			disassert (assert_not_equal_message (a_tag, expected, actual), expected = actual)
		end

	assert_integers_equal (a_tag: READABLE_STRING_GENERAL; expected, actual: INTEGER)
			-- Check that `expected = actual'.
		require
			a_tag_not_void: a_tag /= Void
		do
			assert (assert_strings_equal_message (a_tag, expected.out, actual.out), expected = actual)
		end

	assert_integers_not_equal (a_tag: READABLE_STRING_GENERAL; expected, actual: INTEGER)
			-- Check that `expected /= actual'.
		require
			a_tag_not_void: a_tag /= Void
		do
			disassert (assert_strings_not_equal_message (a_tag, expected.out, actual.out), expected = actual)
		end

	assert_strings_equal (a_tag: READABLE_STRING_GENERAL; expected, actual: READABLE_STRING_GENERAL)
			-- Check that `expected' and `actual' are the same string.
		require
			a_tag_not_void: a_tag /= Void
		do
			assert (assert_strings_equal_message (a_tag, expected, actual), expected.same_string (actual))
		end

	assert_strings_not_equal (a_tag: READABLE_STRING_GENERAL; expected, actual: READABLE_STRING_GENERAL)
			-- Check that `expected' and `actual' are not the same string.
		require
			a_tag_not_void: a_tag /= Void
		do
			disassert (assert_strings_not_equal_message (a_tag, expected, actual), expected.same_string (actual))
		end

	assert_strings_case_insensitive_equal (a_tag: READABLE_STRING_GENERAL; expected, actual: READABLE_STRING_GENERAL)
			-- Check that `expected' and `actual' are the same string (case insensitive).
		require
			a_tag_not_void: a_tag /= Void
		do
			assert (assert_strings_equal_message (a_tag, expected, actual), expected.is_case_insensitive_equal (actual))
		end

	assert_characters_equal (a_tag: READABLE_STRING_GENERAL; expected, actual: CHARACTER)
			-- Check that `expected = actual'
		require
			a_tag_not_void: a_tag /= Void
		do
			assert (assert_strings_equal_message (a_tag, expected.out, actual.out), expected = actual)
		end

	assert_characters_not_equal (a_tag: READABLE_STRING_GENERAL; expected, actual: CHARACTER)
			-- Check that `expected /= actual'
		require
			a_tag_not_void: a_tag /= Void
		do
			disassert (assert_strings_not_equal_message (a_tag, expected.out, actual.out), expected = actual)
		end

	assert_booleans_equal (a_tag: READABLE_STRING_GENERAL; expected, actual: BOOLEAN)
			-- Check that `expected = actual'
		require
			a_tag_not_void: a_tag /= Void
		do
			assert (assert_strings_equal_message (a_tag, expected.out, actual.out), expected = actual)
		end

	assert_booleans_not_equal (a_tag: READABLE_STRING_GENERAL; expected, actual: BOOLEAN)
			-- Check that `expected /= actual'
		require
			a_tag_not_void: a_tag /= Void
		do
			disassert (assert_strings_not_equal_message (a_tag, expected.out, actual.out), expected = actual)
		end

	assert_attached (a_tag: READABLE_STRING_GENERAL; object: detachable ANY)
			-- Check that `object' is attached.
		require
			a_tag_not_void: a_tag /= Void
		do
			assert (a_tag, object /= Void)
		end

	assert_void (a_tag: READABLE_STRING_GENERAL; object: detachable ANY)
			-- Check that `object' is detached.
		require
			a_tag_not_void: a_tag /= Void
		do
			assert (a_tag, object = Void)
		end

	assert_predicate (a_tag: READABLE_STRING_GENERAL; pred: PREDICATE)
			-- Check that `pred' evaluates to True.
		require
			a_tag_not_void: a_tag /= Void
			pred_not_void: pred /= Void
			pred_no_argument: pred.open_count = 0
		do
			assert (a_tag, pred.item (Void))
		end

feature -- Containers

	assert_arrays_equal (a_tag: READABLE_STRING_GENERAL; expected, actual: ARRAY [detachable ANY])
			-- Check that `expected' and `actual' have the same items
			-- in the same order (use `equal' for item comparison).
		require
			a_tag_not_void: a_tag /= Void
			expected_not_void: expected /= Void
			actual_not_void: actual /= Void
		local
			i, nb: INTEGER
			i1, i2: INTEGER
			new_tag: STRING_32
			a_message: detachable STRING_32
			expected_item, actual_item: detachable ANY
		do
			if expected.count /= actual.count then
				create new_tag.make (15)
				new_tag.append_string_general (a_tag)
				new_tag.append_string_general ("-count")
				a_message := assert_strings_equal_message (new_tag, expected.count.out, actual.count.out)
			else
				i1 := expected.lower
				i2 := actual.lower
				nb := expected.count
				from i := 1 until i > nb loop
					expected_item := expected.item (i1)
					actual_item := actual.item (i1)
					if expected_item /~ actual_item then
						create new_tag.make (15)
						new_tag.append_string_general (a_tag)
						new_tag.append_string_general ("-item #")
						new_tag.append_integer (i)
						a_message := assert_equal_message (new_tag, expected_item, actual_item)
						i := nb + 1
					else
						i1 := i1 + 1
						i2 := i2 + 1
						i := i + 1
					end
				end
			end
			if a_message /= Void then
				assert (a_message, False)
			end
		end

	assert_arrays_reference_equal (a_tag: READABLE_STRING_GENERAL; expected, actual: ARRAY [detachable ANY])
			-- Check that `expected' and `actual' have the same items
			-- in the same order (use '=' for item comparison).
		require
			a_tag_not_void: a_tag /= Void
			expected_not_void: expected /= Void
			actual_not_void: actual /= Void
		local
			i, nb: INTEGER
			i1, i2: INTEGER
			new_tag: STRING_32
			a_message: detachable STRING_32
			expected_item, actual_item: detachable ANY
		do
			if expected.count /= actual.count then
				create new_tag.make (15)
				new_tag.append_string_general (a_tag)
				new_tag.append_string_general ("-count")
				a_message := assert_strings_equal_message (new_tag, expected.count.out, actual.count.out)
			else
				i1 := expected.lower
				i2 := actual.lower
				nb := expected.count
				from i := 1 until i > nb loop
					expected_item := expected.item (i1)
					actual_item := actual.item (i1)
					if expected_item /= actual_item then
						create new_tag.make (15)
						new_tag.append_string_general (a_tag)
						new_tag.append_string_general ("-item #")
						new_tag.append_integer (i)
						a_message := assert_equal_message (new_tag, expected_item, actual_item)
						i := nb + 1
					else
						i1 := i1 + 1
						i2 := i2 + 1
						i := i + 1
					end
				end
			end
			if a_message /= Void then
				assert (a_message, False)
			end
		end

feature {NONE} -- Messages

	void_or_out (an_any: detachable ANY): detachable STRING_32
			-- Return `an_any.out' or Void if `an_any' is Void.
		do
			if an_any /= Void then
				if attached {READABLE_STRING_GENERAL} an_any as l_str then
					create Result.make_from_string_general (l_str)
				else
					create Result.make_from_string_general (an_any.out)
				end
			end
		end

	assert_equal_message (a_tag: READABLE_STRING_GENERAL; expected, actual: detachable ANY): STRING_32
			-- Message stating that `expected' and `actual' should be equal.
		require
			a_tag_not_void: a_tag /= Void
		do
			Result := assert_strings_equal_message (a_tag, void_or_out (expected), void_or_out (actual))
		end

	assert_not_equal_message (a_tag: READABLE_STRING_GENERAL; expected, actual: detachable ANY): STRING_32
			-- Message stating that `expected' and `actual' should not be equal.
		require
			a_tag_not_void: a_tag /= Void
		do
			Result := assert_strings_not_equal_message (a_tag, void_or_out (expected), void_or_out (actual))
		end

	assert_strings_equal_message (a_tag: READABLE_STRING_GENERAL; expected, actual: detachable READABLE_STRING_GENERAL): STRING_32
			-- Message stating that `expected' and `actual' should be equal.
		require
			a_tag_not_void: a_tag /= Void
		do
			create Result.make (50)
			Result.append_string_general (a_tag)
			Result.append_string_general ("%N   expected: ")
			if expected = Void then
				Result.append_string_general ("Void")
			else
				Result.append_string_general (expected)
			end
			Result.append_string_general ("%N   but  got: ")
			if actual = Void then
				Result.append_string_general ("Void")
			else
				Result.append_string_general (actual)
			end
		ensure
			message_not_void: Result /= Void
		end

	assert_strings_not_equal_message (a_tag: READABLE_STRING_GENERAL; expected, actual: detachable READABLE_STRING_GENERAL): STRING_32
			-- Message stating that `expected' and `actual' should not be equal.
		require
			a_tag_not_void: a_tag /= Void
		do
			create Result.make (50)
			Result.append_string_general (a_tag)
			Result.append_string_general ("%N   got actual value: ")
			if actual = Void then
				Result.append_string_general ("Void")
			else
				Result.append_string_general (actual)
			end
			Result.append_string_general ("%N   should not match: ")
			if expected = Void then
				Result.append_string_general ("Void")
			else
				Result.append_string_general (expected)
			end
		ensure
			message_not_void: Result /= Void
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
