note
	description: "Summary description for {I18N_TEST_TRANSLATION}."
	date: "$Date: 2013-05-20 23:15:17 +0000 (Mon, 20 May 2013) $"
	revision: "$Revision: 92557 $"

class
	I18N_TEST_TRANSLATION

inherit
	EQA_TEST_SET

	I18N_TEST_UTILITIES
		undefine
			default_create
		end

feature

	test_translation
			-- New test routine
		do
			test
		end

	test_translation_with_context
			-- Test translation in context
		do
			test_in_context
		end

feature {NONE}

	test
		local
			l_mnger: I18N_LOCALE_MANAGER
			l_locale: I18N_LOCALE
			l_locale_id: I18N_LOCALE_ID
			l_string_32: STRING_32
		do
			create l_mnger.make (tests_folder)
			create l_locale_id.make_from_string ("zh_CN")
			l_locale := l_mnger.locale (l_locale_id)

				-- Normal translation.
			l_string_32 := l_locale.translation ("Testing")
			assert ("Tranlation result was incorrect.", testing ~ l_string_32)

				-- Singular translation.
			l_string_32 := l_locale.formatted_string (l_locale.plural_translation ("$1 feature", "$1 features", 1), [1])
			assert ("Tranlation result was incorrect.", singular_feature ~ l_string_32)

				-- Plural translation.
			l_string_32 := l_locale.formatted_string (l_locale.plural_translation ("$1 feature", "$1 features", 2), [2])
			assert ("Tranlation result was incorrect.", plural_features ~ l_string_32)
		end

	test_in_context
		local
			l_mnger: I18N_LOCALE_MANAGER
			l_locale: I18N_LOCALE
			l_locale_id: I18N_LOCALE_ID
			l_string_32: STRING_32
		do
			create l_mnger.make (tests_folder)
			create l_locale_id.make_from_string ("zh_CN")
			l_locale := l_mnger.locale (l_locale_id)

				-- Normal translation.
			l_string_32 := l_locale.translation_in_context ("Testing", "Used for menu")
			assert ("Tranlation result was incorrect.", testing_in_context ~ l_string_32)

				-- Singular translation.
			l_string_32 := l_locale.formatted_string (l_locale.plural_translation_in_context ("$1 feature", "$1 features", "Used for Metric tool", 1), [1])
			assert ("Tranlation result was incorrect.", singular_feature_in_context ~ l_string_32)

				-- Plural translation.
			l_string_32 := l_locale.formatted_string (l_locale.plural_translation_in_context ("$1 feature", "$1 features", "Used for Metric tool", 2), [2])
			assert ("Tranlation result was incorrect.", plural_features_in_context ~ l_string_32)
		end

feature {NONE} -- Results

	testing: STRING_32
			-- UTF32 encoding of Chinese translation of `Testing'.
		once
			create Result.make (2)
			Result.append_code ({NATURAL_32} 0x6D4B)
			Result.append_code ({NATURAL_32} 0x8BD5)
		end

	singular_feature: STRING_32
			-- UTF32 encoding of Chinese translation of `1 feature'.
		once
			create Result.make (4)
			Result.append_code ({NATURAL_32} 0x31)
			Result.append_code ({NATURAL_32} 0x4E2A)
			Result.append_code ({NATURAL_32} 0x65B9)
			Result.append_code ({NATURAL_32} 0x6CD5)
		end

	plural_features: STRING_32
			-- UTF32 encoding of Chinese translation of `2 features'.
		once
			create Result.make (7)
			Result.append_code ({NATURAL_32} 0x32)
			Result.append_code ({NATURAL_32} 0x4E2A)
			Result.append_code ({NATURAL_32} 0x65B9)
			Result.append_code ({NATURAL_32} 0x6CD5)
			Result.append_code ({NATURAL_32} 0x28)
			Result.append_code ({NATURAL_32} 0x590D)
			Result.append_code ({NATURAL_32} 0x29)
		end

	testing_in_context: STRING_32
			-- UTF32 encoding of Chinese translation of `Testing' in context "Used for menu"
		once
			Result := testing.twin
			Result.append_character ('m')
		end

	singular_feature_in_context: STRING_32
			-- UTF32 encoding of Chinese translation of `1 feature' in context "Used for Metric tool"
		once
			Result := singular_feature.twin
			Result.append_character ('m')
		end

	plural_features_in_context: STRING_32
			-- UTF32 encoding of Chinese translation of `2 features' in context "Used for Metric tool"
		once
			Result := plural_features.twin
			Result.append_character ('m')
		end

note
	copyright: "Copyright (c) 1984-2012, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
