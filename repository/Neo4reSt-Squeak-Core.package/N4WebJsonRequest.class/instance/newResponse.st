initialize
newResponse
	"Create a new response entitiy.
	Subclasses can override this method to provide a different response class"

	^(N4WebJsonResponse new)
		request: self;
		yourself