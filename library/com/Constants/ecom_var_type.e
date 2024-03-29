note
	description: "VARTYPE constants"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2008-12-29 20:27:11 +0000 (Mon, 29 Dec 2008) $"
	revision: "$Revision: 76420 $"

class
	ECOM_VAR_TYPE

inherit
	ECOM_FLAGS

feature -- Access

	Vt_empty: INTEGER
			-- Not specified
		external
			"C [macro <wtypes.h>]"
		alias
			"VT_EMPTY"
		end
		
	Vt_null: INTEGER
			-- SQL style Null
		external
			"C [macro <wtypes.h>]"
		alias
			"VT_NULL"
		end
		
	Vt_i1: INTEGER
			-- Character
		external
			"C [macro <wtypes.h>]"
		alias
			"VT_I1"
		end

	Vt_i2: INTEGER
			-- 2-byte signed integer
		external
			"C [macro <wtypes.h>]"
		alias
			"VT_I2"
		end
		
	Vt_i4: INTEGER
			-- 4-byte signed integer
		external
			"C [macro <wtypes.h>]"
		alias
			"VT_I4"
		end
		
	Vt_i8: INTEGER
			-- 8-byte signed integer
			-- may appear in TYPEDESC only
		external
			"C [macro <wtypes.h>]"
		alias
			"VT_I8"
		end
		
	Vt_ui1: INTEGER
			-- Unsigned character
		external
			"C [macro <wtypes.h>]"
		alias
			"VT_UI1"
		end
		
	Vt_ui2: INTEGER
			-- 2-bytes unsigned integer
			-- may appear in TYPEDESC only
		external
			"C [macro <wtypes.h>]"
		alias
			"VT_UI2"
		end
		
	Vt_ui4: INTEGER
			-- 4-bytes unsigned integer
			-- may appear in TYPEDESC only
		external
			"C [macro <wtypes.h>]"
		alias
			"VT_UI4"
		end
		
	Vt_ui8: INTEGER
			-- 8-bytes unsigned integer
			-- may appear in TYPEDESC only
		external
			"C [macro <wtypes.h>]"
		alias
			"VT_UI8"
		end
		
	Vt_r4: INTEGER
			-- 4-byte real
		external
			"C [macro <wtypes.h>]"
		alias
			"VT_R4"
		end
		
	Vt_r8: INTEGER
			-- 8-byte real
		external
			"C [macro <wtypes.h>]"
		alias
			"VT_R8"
		end

	Vt_decimal: INTEGER
			-- 16 byte fixed point
		external
			"C [macro <wtypes.h>]"
		alias
			"VT_DECIMAL"
		end
	
	Vt_cy: INTEGER
			-- Currency
		external
			"C [macro <wtypes.h>]"
		alias
			"VT_CY"
		end
		
	Vt_date: INTEGER
			-- Date
		external
			"C [macro <wtypes.h>]"
		alias
			"VT_DATE"
		end
		
	Vt_bstr: INTEGER
			-- Binary string
		external
			"C [macro <wtypes.h>]"
		alias
			"VT_BSTR"
		end
		
	Vt_dispatch: INTEGER
			-- IDispatch*
		external
			"C [macro <wtypes.h>]"
		alias
			"VT_DISPATCH"
		end
		
	Vt_error: INTEGER
			-- SCODE
		external
			"C [macro <wtypes.h>]"
		alias
			"VT_ERROR"
		end
		
	Vt_bool: INTEGER
			-- Boolean: True = -1 False = 0
		external
			"C [macro <wtypes.h>]"
		alias
			"VT_BOOL"
		end
		
	Vt_variant: INTEGER
			-- VARIANT*
		external
			"C [macro <wtypes.h>]"
		alias
			"VT_VARIANT"
		end
		
	Vt_unknown: INTEGER
			-- IUnknown*
		external
			"C [macro <wtypes.h>]"
		alias
			"VT_UNKNOWN"
		end
		
	Vt_reserved: INTEGER
			-- Reserverd for Microsoft use
		external
			"C [macro <wtypes.h>]"
		alias
			"VT_RESERVED"
		end

	Vt_byref: INTEGER
			-- Pointer to data is passed
		external
			"C [macro <wtypes.h>]"
		alias
			"VT_BYREF"
		end
		
	Vt_array: INTEGER
			-- A Safe array of data is passed
		external
			"C [macro <wtypes.h>]"
		alias
			"VT_ARRAY"
		end
		
	Vt_int: INTEGER
			-- integer
			-- may appear in TYPEDESC only
		external
			"C [macro <wtypes.h>]"
		alias
			"VT_INT"
		end
		
	Vt_uint: INTEGER
			-- unsigned integer
			-- may appear in TYPEDESC only
		external
			"C [macro <wtypes.h>]"
		alias
			"VT_UINT"
		end
		
	Vt_void: INTEGER
			-- NULL
			-- may appear in TYPEDESC only
		external
			"C [macro <wtypes.h>]"
		alias
			"VT_VOID"
		end
		
	Vt_hresult: INTEGER
			-- HRESULT
			-- may appear in TYPEDESC only
		external
			"C [macro <wtypes.h>]"
		alias
			"VT_HRESULT"
		end
		
	Vt_ptr: INTEGER
			-- pointer
			-- may appear in TYPEDESC only
		external
			"C [macro <wtypes.h>]"
		alias
			"VT_PTR"
		end
		
	Vt_safearray: INTEGER
			-- Safearray
			-- may appear in TYPEDESC only
		external
			"C [macro <wtypes.h>]"
		alias
			"VT_SAFEARRAY"
		end
		
	Vt_carray: INTEGER
			-- array
			-- may appear in TYPEDESC only
		external
			"C [macro <wtypes.h>]"
		alias
			"VT_CARRAY"
		end
		
	Vt_userdefined: INTEGER
			-- User defined
			-- may appear in TYPEDESC only
		external
			"C [macro <wtypes.h>]"
		alias
			"VT_USERDEFINED"
		end
		
	Vt_lpstr: INTEGER
			-- LPSTR
			-- may appear in TYPEDESC only
		external
			"C [macro <wtypes.h>]"
		alias
			"VT_LPSTR"
		end
		
	Vt_lpwstr: INTEGER
			-- LPWSTR
			-- may appear in TYPEDESC only
		external
			"C [macro <wtypes.h>]"
		alias
			"VT_LPWSTR"
		end

	Vt_record: INTEGER
			-- Record
			-- may appear in TYPEDESC only
		external
			"C [macro <wtypes.h>]"
		alias
			"VT_RECORD"
		end

	Vt_typemask: INTEGER
			-- Typemask.
		external
			"C [macro <wtypes.h>]"
		alias
			"VT_TYPEMASK"
		end

feature -- Status report

	is_character (variable_type: INTEGER): BOOLEAN
			-- Is variable character?
		do
			Result := variable_type = Vt_i1
		end

	has_character (variable_type: INTEGER): BOOLEAN
			-- Is variable character or character array or character pointer?
		do
			Result := (variable_type & Vt_i1) = Vt_i1
		end

	is_integer2 (variable_type: INTEGER): BOOLEAN
			-- Is variable short integer?
		do
			Result := variable_type = Vt_i2
		end

	has_integer2 (variable_type: INTEGER): BOOLEAN
			-- Is variable short integer or short integer array or short integer pointer?
		do
			Result := (variable_type & Vt_i2) = Vt_i2
		end

	is_integer4 (variable_type: INTEGER): BOOLEAN
			-- Is variable long integer?
		do
			Result := variable_type = Vt_i4
		end

	has_integer4 (variable_type: INTEGER): BOOLEAN
			-- Is variable long integer or long integer array or long integer pointer?
		do
			Result := (variable_type & Vt_i4) = Vt_i4
		end

	is_real (variable_type: INTEGER): BOOLEAN
			-- Is variable real?
		do
			Result := variable_type = Vt_r4
		end

	has_real (variable_type: INTEGER): BOOLEAN
			-- Is variable real or real array or real pointer?
		do
			Result := (variable_type & Vt_r4) = Vt_r4
		end

	is_double (variable_type: INTEGER): BOOLEAN
			-- Is variable double?
		do
			Result := variable_type = Vt_r8
		end

	has_double (variable_type: INTEGER): BOOLEAN
			-- Is variable double or double array or double pointer?
		do
			Result := (variable_type & Vt_r8) = Vt_r8
		end

	is_boolean (variable_type: INTEGER): BOOLEAN
			-- Is variable boolean?
		do
			Result := variable_type = Vt_bool
		end

	has_boolean (variable_type: INTEGER): BOOLEAN
			-- Is variable boolean or boolen array or boolean pointer?
		do
			Result := (variable_type & Vt_bool) = Vt_bool
		end

	is_date (variable_type: INTEGER): BOOLEAN
			-- Is variable date?
		do
			Result := variable_type = Vt_date
		end
 
	has_date (variable_type: INTEGER): BOOLEAN
			-- Is variable date or date array or date pointer?
		do
			Result := (variable_type & Vt_date) = Vt_date
		end

	is_error (variable_type: INTEGER): BOOLEAN
			-- Is variable error?
		do
			Result := variable_type = Vt_error
		end

	has_error (variable_type: INTEGER): BOOLEAN
			-- Is variable error or error array or error pointer?
		do
			Result := (variable_type & Vt_error) = Vt_error
		end

	is_variant (variable_type: INTEGER): BOOLEAN
			-- Is variable variant?
		do
			Result := variable_type = Vt_variant
		end

	has_variant (variable_type: INTEGER): BOOLEAN
			-- Is variable variant or variant array or variant pointer?
		do
			Result := (variable_type & Vt_variant) = Vt_variant
		end

	is_currency (variable_type: INTEGER): BOOLEAN
			-- Is variable currency?
		do
			Result := variable_type = Vt_cy
		end

	has_currency (variable_type: INTEGER): BOOLEAN
			-- Is variable currency or currency array or currency pointer?
		do
			Result := (variable_type & Vt_cy) = Vt_cy
		end

	is_bstr (variable_type: INTEGER): BOOLEAN
			-- Is variable BSTR?
		do
			Result := variable_type = Vt_bstr
		end

	has_bstr (variable_type: INTEGER): BOOLEAN
			-- Is variable bstr or bstr array or bstr pointer?
		do
			Result := (variable_type & Vt_bstr) = Vt_bstr
		end

	is_idispatch (variable_type: INTEGER): BOOLEAN
			-- Is IDispatch interface pointer?
		do
			Result := variable_type = Vt_dispatch
		end

	has_idispatch (variable_type: INTEGER): BOOLEAN
			-- Is variable IDispatch interface pointer or IDispatch interface pointer array or IDispatch interface pointer pointer?
		do
			Result := (variable_type & Vt_dispatch) = Vt_dispatch
		end

	is_iunknown (variable_type: INTEGER): BOOLEAN
			-- Is IUnknown interface pointer?
		do
			Result := variable_type = Vt_unknown
		end

	has_iunknown (variable_type: INTEGER): BOOLEAN
			-- Is variable IUnknown interface pointer or IUnknown interface pointer array or IUnknown interface pointer pointer?
		do
			Result := (variable_type & Vt_unknown) = Vt_unknown
		end

	is_decimal (variable_type: INTEGER): BOOLEAN
			-- Is decimal variable?
		do
			Result := variable_type = Vt_decimal
		end

	has_decimal (variable_type: INTEGER): BOOLEAN
			-- Is variable decimal or decimal array or decimal pointer?
		do
			Result := (variable_type & Vt_decimal) = Vt_decimal
		end

	is_unsigned_char (variable_type: INTEGER): BOOLEAN
			-- Is variable unsigned char?
		do
			Result := variable_type = Vt_ui1
		end

	has_unsigned_char (variable_type: INTEGER): BOOLEAN
			-- Is variable unsigned char or unsigned char array or unsigned char pointer?
		do
			Result := (variable_type & Vt_ui1) = Vt_ui1
		end

	is_unsigned_short (variable_type: INTEGER): BOOLEAN
			-- Is Ivariable unsigned short?
		do
			Result := variable_type = Vt_ui2
		end

	has_unsigned_short (variable_type: INTEGER): BOOLEAN
			-- Is variable unsigned short or unsigned short array or unsigned short pointer?
		do
			Result := (variable_type & Vt_ui2) = Vt_ui2
		end

	is_unsigned_long (variable_type: INTEGER): BOOLEAN
			-- Is variable unsigned long?
		do
			Result := variable_type = Vt_ui4
		end

	has_unsigned_long (variable_type: INTEGER): BOOLEAN
			-- Is variable unsigned long or unsigned long array or unsigned long pointer?
		do
			Result := (variable_type & Vt_ui4) = Vt_ui4
		end

	is_long_long (variable_type: INTEGER): BOOLEAN
			-- Is variable long long?
		do
			Result := variable_type = Vt_i8
		end

	has_long_long (variable_type: INTEGER): BOOLEAN
			-- Is variable long long or long long array or long long pointer?
		do
			Result := (variable_type & Vt_i8) = Vt_i8
		end

	is_unsigned_long_long (variable_type: INTEGER): BOOLEAN
			-- Is variable unsigned long long?
		do
			Result := variable_type = Vt_ui8
		end

	has_unsigned_long_long (variable_type: INTEGER): BOOLEAN
			-- Is variable unsigned long long or unsigned long long array or unsigned long long pointer?
		do
			Result := (variable_type & Vt_ui8) = Vt_ui8
		end

	is_int (variable_type: INTEGER): BOOLEAN
			-- Is variable int?
		do
			Result := variable_type = Vt_int
		end

	has_int (variable_type: INTEGER): BOOLEAN
			-- Is variable int or int array or int pointer?
		do
			Result := (variable_type & Vt_int) = Vt_int
		end

	is_unsigned_int (variable_type: INTEGER): BOOLEAN
			-- Is variable unsigned int?
		do
			Result := variable_type = Vt_uint
		end

	has_unsigned_int (variable_type: INTEGER): BOOLEAN
			-- Is variable unsigned int or unsigned int array or unsigned int pointer?
		do
			Result := (variable_type & Vt_uint) = Vt_uint
		end

	is_void (variable_type: INTEGER): BOOLEAN
			-- Is variable void?
		do
			Result := variable_type = Vt_void
		end

	has_void (variable_type: INTEGER): BOOLEAN
			-- Is variable void or void array or void pointer?
		do
			Result := (variable_type & Vt_void) = Vt_void
		end

	is_hresult (variable_type: INTEGER): BOOLEAN
			-- Is variable HRESULT?
		do
			Result := variable_type = Vt_hresult
		end

	has_hresult (variable_type: INTEGER): BOOLEAN
			-- Is variable HRESULT or HRESULT array or HRESULT pointer?
		do
			Result := (variable_type & Vt_hresult) = Vt_hresult
		end

	is_ptr (variable_type: INTEGER): BOOLEAN
			-- Is variable ptr?
		do
			Result := variable_type = Vt_ptr
		end

	has_ptr (variable_type: INTEGER): BOOLEAN
			-- Is variable ptr or ptr array or ptr pointer?
		do
			Result := (variable_type & Vt_ptr) = Vt_ptr
		end

	is_safearray (variable_type: INTEGER): BOOLEAN
			-- Is variable SAFEARRAY?
		do
			Result := variable_type = Vt_safearray
		end

	is_carray (variable_type: INTEGER): BOOLEAN
			-- Is variable C ARRAY?
		do
			Result := variable_type = Vt_carray
		end

	is_user_defined (variable_type: INTEGER): BOOLEAN
			-- Is variable user defined?
		do
			Result := variable_type = Vt_userdefined
		end

	is_lpstr (variable_type: INTEGER): BOOLEAN
			-- Is variable LPSTR?
		do
			Result := variable_type = Vt_lpstr
		end

	is_lpwstr (variable_type: INTEGER): BOOLEAN
			-- Is variable LPWSTR?
		do
			Result := variable_type = Vt_lpwstr
		end

	is_record (variable_type: INTEGER): BOOLEAN
			-- Is variable a Record? (i.e. a C struct)
		do
			Result := variable_type = Vt_record
		end
		
	is_array (variable_type: INTEGER): BOOLEAN
			-- Is variable array?
		do
			Result := binary_and (variable_type, Vt_array) = Vt_array
		end

	is_byref (variable_type: INTEGER): BOOLEAN
			-- Is variable passed by reference?
		do
			Result := binary_and (variable_type, Vt_byref) = Vt_byref
		end

	valid_var_type (a_var_type: INTEGER): BOOLEAN
			-- Is `a_var_type' a valid variant type?
		do
			Result := is_character (a_var_type) or
					is_integer2 (a_var_type) or
					is_integer4 (a_var_type) or
					is_real (a_var_type) or
					is_double (a_var_type) or
					is_boolean (a_var_type) or
					is_date (a_var_type) or
					is_error (a_var_type) or
					is_variant (a_var_type) or
					is_currency (a_var_type) or
					is_bstr (a_var_type) or
					is_idispatch (a_var_type) or
					is_iunknown (a_var_type) or
					is_decimal (a_var_type) or
					is_unsigned_char (a_var_type) or
					is_unsigned_short (a_var_type) or
					is_unsigned_long (a_var_type) or
					is_long_long (a_var_type) or
					is_unsigned_long_long (a_var_type) or
					is_int (a_var_type) or
					is_unsigned_int (a_var_type) or
					is_void (a_var_type) or
					is_hresult (a_var_type) or
					is_ptr (a_var_type) or
					is_safearray (a_var_type) or
					is_carray (a_var_type) or
					is_user_defined (a_var_type) or
					is_lpstr (a_var_type) or
					is_lpwstr (a_var_type) or
					is_record (a_var_type) or
					is_array (a_var_type) or
					is_byref (a_var_type)
		end

	is_basic (a_type: INTEGER): BOOLEAN
			-- Is `a_type' basic type?
		do
			Result := a_type = Vt_i2 or
					a_type = Vt_i4 or
					a_type = Vt_r4 or
					a_type = Vt_r8 or
					a_type = Vt_bool or
					a_type = Vt_i1 or
					a_type = Vt_ui1 or
					a_type = Vt_ui2 or
					a_type = Vt_ui4 or
					a_type = Vt_int or
					a_type = Vt_uint
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class ECOM_VAR_TYPE

