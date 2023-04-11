class NEW_TEST_SET

inherit
	EQA_TEST_SET

feature -- Tests from failed proofs

	test_HEATER_4_turn_on_off_1
		local
			current_object: HEATER_4
		do
			create current_object.make
			{P_INTERNAL}.set_integer_field_ ("desired_temp", current_object, 85)
				-- current_object.desired_temp = 85
			{P_INTERNAL}.set_boolean_field_ ("is_on", current_object, false)
				-- current_object.is_on = false
			{P_INTERNAL}.set_integer_field_ ("temperature", current_object, 86)
				-- current_object.temperature = 86
			current_object.turn_on_off
		end

end
