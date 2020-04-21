actions-http
httpSetAuthenticationInfo
	| se |
	(se := self settings) useAuthentication ifFalse: [^self].
	self httpClient username: se username password: se password