actions-http-helper
httpSetAuthenticationInfoTo: anHtpClient
	| se |
	(se := self settings) useAuthentication ifFalse: [^self].
	anHtpClient username: se username password: se password