note
	description:	"SSL context"
	legal:			"See notice at end of class"
	status:			"See notice at end of class"
	date:			"$Date$"
	revision:		"$Revision$"

class
	SSL_SHARED

feature {NONE} -- Initialization

	initialize_ssl
			-- Initialize the SSL Library
		do
			if ssl_initialized.item = False then
				c_ssleay_add_ssl_algorithms
				c_ssl_load_error_strings
				ssl_initialized.set_item (True)
			end
		end

feature {NONE} -- Attributes

	ssl_initialized: BOOLEAN_REF
			-- Have the SSL Library initialization routines been called?
		once ("PROCESS")
			create Result
			Result.set_item (False)
		end

feature {NONE} -- Externals

	c_ssl_load_error_strings
			-- External call to SSL_load_error_strings
		external
			"C use <openssl/ssl.h>"
		alias
			"SSL_load_error_strings"
		end

	c_ssleay_add_ssl_algorithms
			-- External call to SSLeay_add_ssl_algorithms
		external
			"C use <openssl/ssl.h>"
		alias
			"SSLeay_add_ssl_algorithms"
		end

note
	copyright:	"Copyright (C) 2010 by ITPassion Ltd, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source:		"[
					ITPassion Ltd
					5 Anstice Close, Chiswick, Middlesex, W4 2RJ, United Kingdom
					Telephone +44 208 742 3422, Fax +44 208 742 3468
					Website http://www.itpassion.com
					Customer support https://powerdesk.itpassion.com
				]"

end
