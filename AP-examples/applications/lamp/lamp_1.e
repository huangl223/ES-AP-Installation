note
    description: "[
                    Failure 1: turn_on_off, postcondition lamp_is_turned_on may be violated.
                              incorrect implementation of the outer-most else-branch in LAMP.turn_on_off;
                              previous_light_intensity should be updated before light_intensity is set to 0.
                   ]"
class
	LAMP_1

feature

	light_intensity: INTEGER
			-- Light intensity of the lamp

	is_on: BOOLEAN
			-- Is the lamp on?

	previous_light_intensity: INTEGER
			-- Light intensity of the lamp before it was last turned off

	High_intensity: INTEGER = 100
			-- High light intensity

	Medium_intensity: INTEGER = 75
			-- Medium light intensity

	Low_intensity: INTEGER = 25
			-- Low light intensity

	Zero_intensity: INTEGER = 0
			-- Zero light intensity

feature

	turn_on_off
			-- Turn on the lamp if it is off; turn off the lamp if it is on
		do
			if not is_on then
				is_on := True
				if previous_light_intensity > 0 then
					light_intensity := previous_light_intensity
				else
					light_intensity := Low_intensity
				end
			else
				is_on := False
				light_intensity := Zero_intensity
				previous_light_intensity := light_intensity
			end
		ensure
			turn_on_1: old (not is_on and previous_light_intensity > 0) implies (is_on and light_intensity = old previous_light_intensity)
			turn_on_2: old (not is_on and previous_light_intensity = 0) implies (is_on and light_intensity = Low_intensity)
			turn_off: old is_on implies (not is_on and previous_light_intensity = old light_intensity and light_intensity = Zero_intensity)
		end

	adjust_light
			-- Adjust the light intensity
		require
			lamp_is_on: is_on = True
		do
			if light_intensity = Low_intensity then
				light_intensity := Medium_intensity
			elseif light_intensity = Medium_intensity then
				light_intensity := High_intensity
			elseif light_intensity = High_intensity then
				light_intensity := Low_intensity
			end
		ensure
			from_low_to_medium: old light_intensity = Low_intensity implies light_intensity = Medium_intensity
			from_medium_to_high: old light_intensity = Medium_intensity implies light_intensity = High_intensity
			from_high_to_low: old light_intensity = High_intensity implies light_intensity = Low_intensity
		end

invariant
	value_of_light_intensity: light_intensity = Zero_intensity or light_intensity = Low_intensity
		or light_intensity = Medium_intensity or light_intensity = High_intensity
	value_of_previous_intensity: previous_light_intensity = Zero_intensity or previous_light_intensity = Low_intensity
		or previous_light_intensity = Medium_intensity or previous_light_intensity = High_intensity
	light_intensity_when_off: is_on = (light_intensity /= Zero_intensity)

end
