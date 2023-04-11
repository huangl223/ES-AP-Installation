class NEW_TEST_SET

inherit
	EQA_TEST_SET

feature -- Tests from failed proofs

	test_CLOCK_8_increase_minutes_1
		local
			current_object: CLOCK_8
		do
			create current_object.make
			{P_INTERNAL}.set_integer_field_ ("hours", current_object, 14)
				-- current_object.hours = 14
			{P_INTERNAL}.set_integer_field_ ("minutes", current_object, 59)
				-- current_object.minutes = 59
			{P_INTERNAL}.set_integer_field_ ("seconds", current_object, 39)
				-- current_object.seconds = 39
			current_object.increase_minutes
		end

end
