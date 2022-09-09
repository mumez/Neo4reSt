deprecated-indexes
addRelationshipIndex: indexName on: relationshipUri key: key value: value
	|json jsonString |
	json := self newRelationshipIndexJson: relationshipUri key: key value: value.
	jsonString := self portableUtil jsonStringFrom: json.
	^ self portableUtil httpJsonPost: (self indexUri / 'relationship' // indexName) content: jsonString