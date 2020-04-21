private
propertySetParametersFrom: dictOrAssocs targetNamed: targetName
	| dict phrase|
	dict := self portableUtil dictionaryFromAssociations: dictOrAssocs.
	phrase := String
		streamContents: [ :str | 
			dict associations
				do: [ :assoc | 
					str
						nextPutAll: targetName , '.' , assoc key;
						nextPutAll: '=';
						nextPutAll: (self asValueParameter: assoc value) asString]
				separatedBy: [ str nextPut: $, ] ].
	^'SET ', phrase