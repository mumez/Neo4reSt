private-dumping
dumpProperty: propValue named: propName to: aNode
	[ aNode at: propName put: propValue ] on: Error do: [:ex |
		[ aNode at: propName put: propValue toStomp "last resort - write as StOMP bytes"	] on: MessageNotUnderstood do: [:e |
			self error: 'This demo requires StOMP'
		]
	]