note
	description: "[
					Objects controls blending by specifying 
					the blending functions for source and destination bitmaps.
					Wrapper for BLENDFUNCTION struct.
					]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2013-05-20 23:15:17 +0000 (Mon, 20 May 2013) $"
	revision: "$Revision: 92557 $"

class
	WEL_BLEND_FUNCTION

inherit
	WEL_STRUCTURE
		rename
			make as structure_make
		export
			{ANY} is_equal, copy, clone
		end

create
	make

feature {NONE} -- Initlization

	make
			-- Creation method
		do
			structure_make
			set_blend_op (Ac_src_over)
			set_blend_flags (0)
			set_source_constant_alpha (255)
			set_alpha_format (Ac_src_alpha)
		end

	Ac_src_over: INTEGER = 0
			-- AC_SRC_OVER

	Ac_src_alpha: INTEGER = 1
			-- AC_SRC_ALPHA

feature -- Properties

	structure_size: INTEGER
			-- Structure size.
		do
			Result := c_size_of_blend_function
		end

	blend_op: INTEGER
			-- Specifies the source blend operation.
			-- Currently, the only source and destination blend operation that has been defined is AC_SRC_OVER.
		do
			Result := c_blend_op (item)
		end

	set_blend_op (a_blend_op: INTEGER)
			-- Set `blend_op'
		do
			c_set_blend_op (item, a_blend_op)
		end

	blend_flags: INTEGER
			-- Must be zero.
		do
			Result := c_blend_flags (item)
		end

	set_blend_flags (a_flags: INTEGER)
			-- Set `blend_flags'
		do
			c_set_blend_flags (item, a_flags)
		end

	source_constant_alpha: INTEGER
			-- Specifies an alpha transparency value to be used on the entire source bitmap.
			-- The SourceConstantAlpha value is combined with any per-pixel alpha values
			-- in the source bitmap. If you set SourceConstantAlpha to 0, it is assumed that
			-- your image is transparent. Set the SourceConstantAlpha value to 255 (opaque)
			-- when you only want to use per-pixel alpha values.
		do
			Result := c_source_constant_alpha (item)
		end

	set_source_constant_alpha (a_source_constant_alpha: INTEGER)
			-- Set `source_constant_alpha'
		do
			c_set_source_constant_alpha (item, a_source_constant_alpha)
		end

	alpha_format: INTEGER
			-- This member controls the way the source and destination bitmaps are interpreted.
		do
			Result := c_alpha_format (item)
		end

	set_alpha_format (a_alpha_format: INTEGER)
			-- Set `alpha_format'
		do
			c_set_alpha_format (item, a_alpha_format)
		end

feature {NONE} -- Externals

	c_size_of_blend_function: INTEGER
			-- Size of BLENDFUNCTION structure.
		external
			"C [macro <windows.h>]"
		alias
			"sizeof (BLENDFUNCTION)"
		end

	c_set_blend_op (a_p: POINTER; a_blend_op: INTEGER)
			-- Set BlendOp.
		external
			"C [struct <windows.h>] (BLENDFUNCTION, BYTE)"
		alias
			"BlendOp"
		end

	c_blend_op (a_p: POINTER): INTEGER
			-- Get BlendOp.
		external
			"C [struct <windows.h>] (BLENDFUNCTION): EIF_INTEGER"
		alias
			"BlendOp"
		end

	c_set_blend_flags (a_p: POINTER; a_flags: INTEGER)
			-- Set BlendFlags.
		external
			"C [struct <windows.h>] (BLENDFUNCTION, BYTE)"
		alias
			"BlendFlags"
		end

	c_blend_flags (a_p: POINTER): INTEGER
			-- Get BlendFlags.
		external
			"C [struct <windows.h>] (BLENDFUNCTION): EIF_INTEGER"
		alias
			"BlendFlags"
		end

	c_set_source_constant_alpha (a_p: POINTER; a_source_constant_alpha: INTEGER)
			-- Set SourceConstantAlpha.
		external
			"C [struct <windows.h>] (BLENDFUNCTION, BYTE)"
		alias
			"SourceConstantAlpha"
		end

	c_source_constant_alpha (a_p: POINTER): INTEGER
			-- Get SourceConstantAlpha.
		external
			"C [struct <windows.h>] (BLENDFUNCTION): EIF_INTEGER"
		alias
			"SourceConstantAlpha"
		end

	c_set_alpha_format (a_p: POINTER; a_alpha_format: INTEGER)
			-- Set AlphaFormat.
		external
			"C [struct <windows.h>] (BLENDFUNCTION, BYTE)"
		alias
			"AlphaFormat"
		end

	c_alpha_format (a_p: POINTER): INTEGER
			-- Get AlphaFormat.
		external
			"C [struct <windows.h>] (BLENDFUNCTION): EIF_INTEGER"
		alias
			"AlphaFormat"
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

end
