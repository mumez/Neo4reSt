instance creation
default
	default ifNil: [default := self defaultClass new].
	^ default