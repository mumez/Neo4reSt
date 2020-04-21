accessing
settings
	"Answer the value of settings"

	^ settings ifNil: [settings := self createSettings]