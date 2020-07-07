accessing
settings
	^ settings ifNil: [settings := N4Settings default]