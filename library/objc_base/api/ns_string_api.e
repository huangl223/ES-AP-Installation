note
	description: "Summary description for {NS_STRING_API}."
	author: "Daniel Furrer"
	date: "$Date: 2013-05-20 23:15:17 +0000 (Mon, 20 May 2013) $"
	revision: "$Revision: 92557 $"

class
	NS_STRING_API

inherit
	NS_OBJECT_BASIC_TYPE

feature -- Creating and Initializing Strings

	frozen create_with_c_string (a_c_string: POINTER; a_encoding: INTEGER): POINTER
		external
			"C inline use <Foundation/NSString.h>"
		alias
			"return [[NSString alloc] initWithCString: $a_c_string encoding: $a_encoding];"
		end

	frozen create_with_characters (a_characters: POINTER; a_length: like ns_uinteger): POINTER
			-- - (id)stringWithCharacters:(const unichar *)characters length:(NSUInteger)length
		external
			"C inline use <Foundation/NSString.h>"
		alias
			"return [[NSString alloc] initWithCharacters: $a_characters length: $a_length];"
		end


 feature -- Creating and Initializing a String from a File

 feature -- Creating and Initializing a String from an URL

 feature -- Writing to a File or URL

feature -- Getting a String's Length

	frozen length (a_ns_string: POINTER): like ns_uinteger
			-- - (NSUInteger)length
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSString*)$a_ns_string length];"
		end

feature -- Getting Characters and Bytes

	frozen character_at_index (a_ns_string: POINTER; a_index: like ns_uinteger): NATURAL_16
			-- - (unichar)characterAtIndex: (NSUInteger) index
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSString*)$a_ns_string characterAtIndex: $a_index];"
		end

 feature -- Getting C Strings

	frozen c_string_using_encoding (a_ns_string: POINTER; a_encoding: INTEGER): POINTER
		external
			"C inline use <Foundation/NSString.h>"
		alias
			"return (char*) [(NSString*)$a_ns_string cStringUsingEncoding: $a_encoding];"
		end

 feature -- Combining Strings

 feature -- Dividing Strings

 feature -- Finding Characters and Substrings

 feature -- Replacing Substrings

 feature -- Determining Line and Paragraph Ranges

 feature -- Determining Composed Character Sequences

 feature -- Converting String Contents Into a Property List

 feature -- Identifying and Comparing Strings

 feature -- Folding Strings

 feature -- Getting a Shared Prefix

 feature -- Changing Case

 feature -- Getting Strings with Mapping

 feature -- Getting Numeric Values

 feature -- Working with Encodings

 feature -- Working with Paths

 feature -- Working with URLs

	frozen UTF8_string_encoding: INTEGER
			-- NSUTF8StringEncoding
			-- An 8-bit representation of Unicode characters, suitable for transmission or storage by ASCII-based systems.
		external
			"C inline use <Foundation/NSString.h>"
		alias
			"return NSUTF8StringEncoding;"
		end

	frozen UTF32_string_encoding: INTEGER
			-- NSUTF32StringEncoding
			-- 32-bit UTF encoding.
		external
			"C inline use <Foundation/NSString.h>"
		alias
			"return NSUTF32StringEncoding;"
		end

	frozen UTF32_big_endian_string_encoding: INTEGER
			-- NSUTF32BigEndianStringEncoding
			-- NSUTF32StringEncoding encoding with explicit endianness specified.
		external
			"C inline use <Foundation/NSString.h>"
		alias
			"return NSUTF32BigEndianStringEncoding;"
		end

	frozen UTF32_little_endian_string_encoding: INTEGER
			-- NSUTF32LittleEndianStringEncoding
			-- NSUTF32StringEncoding encoding with explicit endianness specified.
		external
			"C inline use <Foundation/NSString.h>"
		alias
			"return NSUTF32LittleEndianStringEncoding;"
		end

end
