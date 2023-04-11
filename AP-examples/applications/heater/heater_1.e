note
    description: "[
                    Failure 1: turn_on_off, postcondition heater_remains_off may be violated.
                   ]"

class
	HEATER_1

create
	make

feature
	make
			-- By default, desired temperature is 20 degree, deviation is 2 and heater is off
		do
			desired_temp := 20
			is_on := False
		ensure
			default_condition: desired_temp = 20 and is_on = False
		end

feature

	temperature: INTEGER
			-- Current temperature

	desired_temp: INTEGER
			-- Temperature defined by the user

	is_on: BOOLEAN
			-- Is heater turned on?

	Deviation: INTEGER = 2
			-- Deviation for turning on/off the heater

feature

	set_temperature (a_value: INTEGER)
			-- Set the `temperature' to `a_value'
		do
			temperature := a_value
		end

	set_desired_temperature (value: INTEGER)
			-- Set the `desired_temp' to `value'
		require
			valid_value: value >= 10 and value <= 100
		do
			desired_temp := value
		ensure
			temperature_set: desired_temp = value
		end

	turn_on_off
			-- Turn on or turn off the heater automatically based on the current temperature
		require
			desired_temp_valid: desired_temp >= 10 and desired_temp <= 100
		do
			if is_on then
				if temperature > desired_temp + deviation then
					is_on := False
				end
			else
				if temperature <= desired_temp - deviation then
					is_on := True
				end
			end
		ensure
			heater_is_turned_off: old (is_on and temperature > desired_temp + deviation) implies (not is_on)
			heater_remains_on: old (is_on and temperature <= desired_temp + deviation) implies is_on
			heater_is_turned_on: old (not is_on and temperature < desired_temp - deviation) implies is_on
			heater_remains_off: old (not is_on and temperature >= desired_temp - deviation) implies (not is_on)
		end

invariant
	desired_temp_in_bound: desired_temp >= 10 and desired_temp <= 100

end
