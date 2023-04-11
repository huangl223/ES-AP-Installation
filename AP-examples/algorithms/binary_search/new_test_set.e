class NEW_TEST_SET

inherit
	EQA_TEST_SET

feature -- Tests from failed proofs

	test_BINARY_SEARCH_6_binary_search_1
		local
			current_object: BINARY_SEARCH_6
			a: V_ARRAY[INTEGER_32]
			value: INTEGER_32
			binary_search_result: INTEGER_32
		do
			create current_object
			create a.make(1, 0)
			a.force(0, 1)
			a.force(0, 2)
			a.force(0, 3)
			a.force(0, 4)
			a.force(0, 5)
			a.force(0, 6)
			a.force(0, 7)
			a.force(0, 8)

			value := (-2147462410)
			binary_search_result := current_object.binary_search (a, value)
		end

end
