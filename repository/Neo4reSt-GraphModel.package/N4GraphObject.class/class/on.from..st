instance creation
on: rawGraphObject from: database
	^self new
		rawGraphObject: rawGraphObject;
		initWithDb: database;
		yourself