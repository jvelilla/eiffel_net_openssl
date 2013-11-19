note
	description: "Summary description for {SSL_PROTOCOL_SOCKET}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SSL_PROTOCOL_SOCKET

feature -- Access

	tls_protocol: STRING
		-- TLS protocol, it could be Tlsv1.1 or Tlsv1.2, etc,
		-- by default the protocol it's Tlsv1.2

feature -- Change Element

	set_tls_protocol (a_protocol: READABLE_STRING_8)
		do
			tls_protocol := a_protocol
		ensure
			tls_protocol_set:  tls_protocol = a_protocol
		end
note
	copyright: "Copyright (c) 1984-2013, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
