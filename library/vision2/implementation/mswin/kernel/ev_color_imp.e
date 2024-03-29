note
	description: "Eiffel Vision color. Mswindows implementation"
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date: 2017-03-27 17:23:22 +0000 (Mon, 27 Mar 2017) $";
	revision: "$Revision: 100056 $"

class
	EV_COLOR_IMP

inherit
	EV_COLOR_I

	WEL_COLOR_REF
		rename
			make as wel_make,
			red as red_8_bit,
			green as green_8_bit,
			blue as blue_8_bit,
			set_red as wel_set_red,
			set_blue as wel_set_blue,
			set_green as wel_set_green
		end

create
	make

feature -- Initialization

	old_make (an_interface: attached like interface)
			-- Create `Current' with interface `an_interface'.
		do
			assign_interface (an_interface)
		end

	make
			-- Initialize `Current'.
		do
			wel_make
			name := default_name
			set_is_initialized (True)
		end

feature {EV_COLOR} -- Access

	red: REAL
			-- Intensity of red component.
			-- Range: [0,1]
		do
			Result := red_8_bit / {REAL_32} 255.0
		end

	green: REAL
			-- Intensity of green component.
			-- Range: [0,1]
		do
			Result := green_8_bit / {REAL_32} 255.0
		end

	blue: REAL
			-- Intensity of blue component.
			-- Range: [0,1]
		do
			Result := blue_8_bit / {REAL_32} 255.0
		end

	name: STRING_32
			-- A textual description.

feature {EV_COLOR} -- Element change

	set_red (a_red: REAL)
			-- Assign `a_red' to `red'.
		do
			wel_set_red ((a_red * 255).rounded)
		end

	set_green (a_green: REAL)
			-- Assign `a_green' to `green'.
		do
			wel_set_green ((a_green * 255).rounded)
		end

	set_blue (a_blue: REAL)
			-- Assign `a_blue' to `blue'.
		do
			wel_set_blue ((a_blue * 255).rounded)
		end

	set_name (a_name: READABLE_STRING_GENERAL)
			-- Assign `a_name' to `name'.
		do
			name.wipe_out
			name.append_string_general (a_name)
		end

feature {EV_ANY_I, EV_STOCK_COLORS_IMP}

	set_with_system_id (id: INTEGER)
		local
			wcr: WEL_COLOR_REF
		do
			create wcr.make_system (id)
			wel_set_red (wcr.red)
			wel_set_green (wcr.green)
			wel_set_blue (wcr.blue)
		end

feature {EV_COLOR} -- Conversion

	rgb_24_bit: INTEGER
			-- `red', `green' and `blue' intensities packed into 24 bits
			-- with 8 bits per colour and blue in the least significant 8 bits.
		do
			Result := (red_8_bit * 65536) + (green_8_bit * 256) + blue_8_bit
		end

	set_rgb_with_24_bit (a_24_bit_rgb: INTEGER)
			-- Set intensities from `a_24_bit_rgb' value
			-- with blue in the least significant 8 bits.
		local
			counter: INTEGER
		do
			counter :=a_24_bit_rgb
			wel_set_blue (counter & 0x000000ff)
			counter := counter |>> 8
			wel_set_green (counter & 0x000000ff)
			counter := counter |>> 8
			wel_set_red (counter & 0x000000ff)
		end

	set_red_with_8_bit (an_8_bit_red: INTEGER)
			-- Set `red' from `an_8_bit_red' intinsity.
		do
			wel_set_red (an_8_bit_red)
		end

	set_green_with_8_bit (an_8_bit_green: INTEGER)
			-- Set `green' from `an_8_bit_green' intinsity.
		do
			wel_set_green (an_8_bit_green)
		end

	set_blue_with_8_bit (an_8_bit_blue: INTEGER)
			-- Set `blue' from `an_8_bit_blue' intinsity.
		do
			wel_set_blue (an_8_bit_blue)
		end

	red_16_bit: INTEGER
			-- Intensity of red component
			-- as a 16 bit unsigned integer.
			-- Range [0,65535]
		do
			Result := red_8_bit * 256
		end

	green_16_bit: INTEGER
			-- Intensity of green component
			-- as a 16 bit unsigned integer.
			-- Range [0,65535]
		do
			Result := green_8_bit * 256
		end

	blue_16_bit: INTEGER
			-- Intensity of blue component
			-- as a 16 bit unsigned integer.
			-- Range [0,65535]
		do
			Result := blue_8_bit * 256
		end

	set_red_with_16_bit (a_16_bit_red: INTEGER)
			-- Set `red' from `a_8_bit_red' intinsity.
		do
			wel_set_red (a_16_bit_red // 256)
		end

	set_green_with_16_bit (a_16_bit_green: INTEGER)
			-- Set `green' from `a_16_bit_green' intinsity.
		do
			wel_set_green (a_16_bit_green // 256)
		end

	set_blue_with_16_bit (a_16_bit_blue: INTEGER)
			-- Set `blue' from `a_16_bit_blue' intinsity.
		do
			wel_set_blue (a_16_bit_blue // 256)
		end

feature -- Status setting

	destroy
			-- Render `Current' unusable.
			-- No externals to deallocate, just set the flags.
		do
			set_is_destroyed (True)
		end

feature {NONE} -- Implementation

	delta: REAL
			-- Amount by which two intensities can differ but still be
			-- considered equal by `is_equal'.
		do
			Result := {REAL_32} 1.0 / {REAL_32} 255.0
		end

note
	copyright:	"Copyright (c) 1984-2017, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class EV_COLOR_IMP
