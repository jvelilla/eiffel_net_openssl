note
	description:	"SSL context"
	legal:			"See notice at end of class"
	status:			"See notice at end of class"
	date:			"$Date$"
	revision:		"$Revision$"

class
	SSL_CONTEXT

inherit
	SSL_SHARED

create
	make_as_sslv2_client, make_as_sslv3_client, make_as_sslv23_server

feature {NONE} -- Initialization

	make_as_sslv2_client
			-- Make an SSLv2 capable client context
		local
			method_pointer: POINTER
		do
				--| Initialize SSL, as this may be one of the entry points into SSL where it is
				--| useful to initialize the SSL Library
			initialize_ssl

			method_pointer := c_sslv2_client_method
			ctx := c_ssl_ctx_new (method_pointer)
		end

	make_as_sslv3_client
			-- Make an SSLv3 capable client context
		local
			method_pointer: POINTER
		do
				--| Initialize SSL, as this may be one of the entry points into SSL where it is
				--| useful to initialize the SSL Library
			initialize_ssl

			method_pointer := c_sslv3_client_method
			ctx := c_ssl_ctx_new (method_pointer)
		end

	make_as_sslv23_server
			-- Make an SSLv2 and SSLv3 capable server context
		local
			method_pointer: POINTER
		do
				--| Initialize SSL, as this may be one of the entry points into SSL where it is
				--| useful to initialize the SSL Library
			initialize_ssl

			method_pointer := c_sslv23_server_method
			ctx := c_ssl_ctx_new (method_pointer)
		end

feature -- Access

	create_ssl
			-- Create an SSL object from the current context
		do
			create last_ssl.make_from_context (ctx)
		end

	free
			-- Free the underlying SSL Context Structure
		do
			c_ssl_ctx_free (ctx)
		end

	use_certificate_file (a_file_name: FILE_NAME)
			-- Import the PEM certificate in `a_file_name' into this context
		local
			c_string: C_STRING
			err: INTEGER
			l_exception: DEVELOPER_EXCEPTION
		do
			create c_string.make (a_file_name.out)
			err := c_ssl_ctx_use_certificate_file (ctx, c_string.item, 1)
			if err <= 0 then
				create l_exception
				l_exception.set_message ("Cannot load certificate file " + a_file_name.out)
				l_exception.raise
			end
		end

	use_private_key_file (a_file_name: FILE_NAME)
			-- Import the PEM private key in `a_file_name' into this context
		local
			c_string: C_STRING
			err: INTEGER
			l_exception: DEVELOPER_EXCEPTION
		do
			create c_string.make (a_file_name.out)
			err := c_ssl_ctx_use_privatekey_file (ctx, c_string.item, 1)
			if err <= 0 then
				create l_exception
				l_exception.set_message ("Cannot load private key file " + a_file_name.out)
				l_exception.raise
			end
			err := c_ssl_ctx_check_private_key (ctx)
			if err = 0 then
				create l_exception
				l_exception.set_message ("Private key does not match public key in certificate!")
				l_exception.raise
			end
		end

feature -- Status Report

	last_ssl: detachable SSL
			-- The SSL Structure created by `create_ssl'

feature {NONE} -- Implementation

feature {NONE} -- Attributes

	ctx: POINTER
			-- External SSL_CTX structure

feature {NONE} -- Externals

	c_ssl_ctx_check_private_key (a_ctx_ptr: POINTER): INTEGER
			-- Call external SSL_CTX_check_private_key
		external
			"C use <openssl/ssl.h>"
		alias
			"SSL_CTX_check_private_key"
		end

	c_ssl_ctx_free (a_ctx_ptr: POINTER)
			-- External call to SSL_CTX_free
		external
			"C use <openssl/ssl.h>"
		alias
			"SSL_CTX_free"
		end

	c_ssl_ctx_new (method_ptr: POINTER): POINTER
			-- External call to SSL_CTX_new
		external
			"C use <openssl/ssl.h>"
		alias
			"SSL_CTX_new"
		end

	c_ssl_ctx_use_certificate_file (a_ctx_ptr, file: POINTER; type: INTEGER): INTEGER
			-- Call external SSL_CTX_use_certificate_file
		external
			"C use <openssl/ssl.h>"
		alias
			"SSL_CTX_use_certificate_file"
		end

	c_ssl_ctx_use_privatekey_file (a_ctx_ptr, file: POINTER; type: INTEGER): INTEGER
			-- Call external SSL_CTX_use_PrivateKey_file
		external
			"C use <openssl/ssl.h>"
		alias
			"SSL_CTX_use_PrivateKey_file"
		end

	c_sslv2_client_method: POINTER
			-- External call to SSLv2_client_method
		external
			"C use <openssl/ssl.h>"
		alias
			"SSLv2_client_method"
		end

	c_sslv3_client_method: POINTER
			-- External call to SSLv3_client_method
		external
			"C use <openssl/ssl.h>"
		alias
			"SSLv3_client_method"
		end

	c_sslv23_server_method: POINTER
			-- External call to SSLv2_client_method
		external
			"C use <openssl/ssl.h>"
		alias
			"SSLv23_server_method"
		end

note
	copyright:	"Copyright (c) 1984-2013, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source:		"[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
