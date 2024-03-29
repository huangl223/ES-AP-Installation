note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date: 2013-05-20 23:15:17 +0000 (Mon, 20 May 2013) $"
	revision: "$Revision: 92557 $"
	testing: "type/manual"

class
	TEST_NS_BOX

inherit
	EQA_TEST_SET

feature -- Test routines

	test_make
		local
			box: NS_BOX
		do
			create box.make
		end

	test_set_border_type_no_border
		local
			box: NS_BOX
		do
			create box.make
			box.set_border_type (box.no_border)
		end

	test_set_border_type_bezel_border
		local
			box: NS_BOX
		do
			create box.make
			box.set_border_type (box.bezel_border)
		end

	test_set_border_type_groove_border
		local
			box: NS_BOX
		do
			create box.make
			box.set_border_type (box.groove_border)
		end

	test_set_border_type_line_border
		local
			box: NS_BOX
		do
			create box.make
			box.set_border_type (box.line_border)
		end
end
