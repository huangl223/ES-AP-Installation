note
    description: "[
                    Failure 1: increase_seconds, precondition valid_seconds may be violated on call to set_seconds;
                                incorrect implementation (conditional statement) of increase_seconds.
                   ]"
    model: hours, minutes, seconds

class
	CLOCK_5

create make

feature {NONE} -- Initialization
	make
		note
			status: creator
		do
			hours := 0
			minutes := 0
			seconds := 0
		ensure
			modify_model (["hours", "minutes", "seconds"], Current)
			initialized: hours = 0 and minutes = 0 and seconds = 0
		end

feature -- Access

	hours: INTEGER
			-- Hours of clock.

	minutes: INTEGER
			-- Minutes of clock.

	seconds: INTEGER
			-- Seconds of clock.

feature -- Element change

	set_hours (a_value: INTEGER)
			-- Set `hours' to `a_value'.
		require
			valid_hours: 0 <= a_value and a_value < 24
		do
			hours := a_value
		ensure
			hours_set: hours = a_value
			modify_model ("hours", Current)
		end

	set_minutes (a_value: INTEGER)
			-- Set `minutes' to `a_value'.
		require
			valid_minutes: 0 <= a_value and a_value < 60
		do
			minutes := a_value
		ensure
			minutes_set: minutes = a_value
			modify_model ("minutes", Current)
		end

	set_seconds (a_value: INTEGER)
			-- Set `seconds' to `a_value'.
		require
			valid_seconds: 0 <= a_value and a_value < 60

		do
			seconds := a_value
		ensure
			seconds_set: seconds = a_value
			modify_model ("seconds", Current)
		end

feature -- Basic operations

	increase_hours
			-- Increase `hours' by one.
		note
			explicit: wrapping

		do
			if hours = 23 then
				set_hours (0)
			else
				set_hours (hours + 1)
			end
		ensure
			hours_increased: hours = (old hours + 1) \\ 24
			modify_model ("hours", Current)
		end

	increase_minutes
			-- Increase `minutes' by one.
		note
			explicit: wrapping

		do
			if minutes < 59 then
				set_minutes (minutes + 1)
					--	set_minutes (0)
					--	increase_hours
			else
				set_minutes (0)
				increase_hours
			end
		ensure
			hours_increased: old minutes = 59 implies hours = (old hours + 1) \\ 24
			hours_unchanged: old minutes < 59 implies hours = old hours
			minutes_increased: minutes = (old minutes + 1) \\ 60
			modify_model (["minutes", "hours"], Current)
		end

	increase_seconds
			-- Increase `seconds' by one.
		note
			explicit: wrapping

		do
			if seconds > 59 then
				set_seconds (0)
				increase_minutes
			else
				set_seconds (seconds + 1)
			end
		ensure
			hours_increased: old seconds = 59 and old minutes = 59 implies hours = (old hours + 1) \\ 24
			hours_unchanged: old seconds < 59 or old minutes < 59 implies hours = old hours
			minutes_increased: old seconds = 59 implies minutes = (old minutes + 1) \\ 60
			minutes_unchanged: old seconds < 59 implies minutes = old minutes
			seonds_inreased: seconds = (old seconds + 1) \\ 60
			modify_model (["seconds", "minutes", "hours"], Current)
		end

invariant
	hours_valid: 0 <= hours and hours <= 23
	minutes_valid: 0 <= minutes and minutes <= 59
	seconds_valid: 0 <= seconds and seconds <= 59

end
