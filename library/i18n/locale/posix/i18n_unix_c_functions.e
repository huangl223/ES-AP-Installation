note
	description: "External C functions used by the POSIX implementation of I18N_HOST_LOCALE"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2019-08-05 07:13:01 +0000 (Mon, 05 Aug 2019) $"
	revision: "$Revision: 103392 $"

class
	I18N_UNIX_C_FUNCTIONS

feature {I18N_LOCALE} -- Initialization

	unix_set_locale (a_locale: READABLE_STRING_GENERAL)
			-- set the locale to the locale
			-- represented by the string pointed by `a_pointer'
			-- to get default locale, give pointer to ""
		require
			a_locale_not_void: a_locale /= Void
		local
			l_str: C_STRING
			l_ptr, l_null: POINTER
		do
			create l_str.make (a_locale)
			l_ptr := c_setlocale (c_lc_all, l_str.item)
			if l_ptr /= l_null then
				create l_str.make_shared_from_pointer (l_ptr)
				unix_locale_name_cell.put (l_str.string)
			else
				unix_locale_name_cell.put ("POSIX")
			end
		end

feature -- nl_langinfo

	unix_get_locale_info_managed (a_int: INTEGER): MANAGED_POINTER
			-- Managed pointer to locale into.
			-- `unix_get_locale_info' actually allocates a new pointer and it
			-- is the responsability of the caller to free it and thus
			-- `own_from_pointer' as it will take ownership of the free.
		do
			create Result.own_from_pointer (unix_get_locale_info (a_int), 0)
		end

	unix_get_locale_info (a_int: INTEGER): POINTER
			--
		external
			"C inline use <eif_langinfo.h>, <iconv.h>"
		alias
			"[
				char *dname;
				wchar_t *out = NULL;
				size_t insize, outsize = 0;

				dname = nl_langinfo($a_int);
				insize = strlen(dname) + 1;
				
				{
					iconv_t cd;
					size_t nconv, avail, alloc;
					char *res, *tres, *wrptr, *inptr;
					char **l_inptr = &inptr;

					alloc = avail = insize + insize/4;
					if (!(res = malloc(alloc))) {
					  perror("malloc");
					  return NULL;
					}

					wrptr = res;   /* duplicate pointers because they */
					inptr = dname; /* get modified by iconv */
					
					/*get charset used by current locale */
					#if EIF_OS == EIF_OS_OPENBSD
						char *charset = locale_charset ();
					#else
						char *charset = nl_langinfo (CODESET);
					#endif
					
					cd = iconv_open ("UTF-8", charset);
					if (cd == (iconv_t)(-1)) {
							perror("iconv_open");
							free(res);
							return NULL;
					}

					do {
							nconv = iconv (cd, l_inptr, &insize, &wrptr, &avail); /*convertions */
							if (nconv == (size_t)(-1)) {
									if (errno == E2BIG) { /* need more room for result */
											tres = realloc(res, alloc += 20);
											avail += 20;
											if (!tres) {
													perror("realloc");
													break;
											}
											wrptr = tres + (wrptr - res);
											res = tres;
									}
									else /* something wrong with input */
											break;
							}
					} while (insize);

					if (iconv_close(cd))
							perror("iconv_close");
				   
					out = (wchar_t*) res;
					outsize = wrptr - res; /* should be == to (alloc - avail + 1) */
					/* TODO: should possibly null-terminate the result */
				}
				return out;
			]"
		end

feature -- Available locales

	unix_is_available (a_locale: READABLE_STRING_GENERAL): BOOLEAN
			-- see: `is_available'
		require
			a_locale_not_void: a_locale /= Void
			a_locale_is_ascii: a_locale.is_valid_as_string_8
		local
			l_str: C_STRING
			l_null: POINTER
		do
				-- Check if locale is present
			create l_str.make (a_locale)
			Result := c_setlocale (c_lc_all, l_str.item) /= l_null
				-- Restore previous locale
			unix_set_locale (unix_locale_name)
		end

feature {NONE} -- Implementation: C externals

	c_current_codeset: POINTER
			-- Current codeset name.
		external
			"C inline use <eif_langinfo.h>"
		alias
			"[
				#if EIF_OS == EIF_OS_OPENBSD
					return locale_charset ();
				#else
					return nl_langinfo (CODESET);
				#endif
			]"
		end

	unix_locale_name: STRING
			-- see: `locale_name'
		do
			Result := unix_locale_name_cell.item
		ensure
			locale_name_buffer_not_void: Result /= Void
		end

	unix_locale_name_cell: CELL [STRING]
		once
			create Result.put ("POSIX")
		ensure
			locale_name_cell_not_void: Result /= Void
			content_not_void: Result.item /= Void
		end

	c_setlocale (a_cat: INTEGER; a_locale: POINTER): POINTER
		external
			"C inline use <locale.h>"
		alias
			"return setlocale((int) $a_cat, (const char *) $a_locale);"
		end

	c_lc_all: INTEGER
			--
		external
			"C inline use <locale.h>"
		alias
			"return LC_ALL;"
		end

note
	library:   "Internationalization library"
	copyright: "Copyright (c) 1984-2019, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end
