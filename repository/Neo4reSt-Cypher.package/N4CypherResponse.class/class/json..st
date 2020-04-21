instance creation
json: jsonObject
	| inst |
	inst := self new.
	inst commit: (jsonObject at: 'commit' ifAbsent:[]).
	inst results: ((jsonObject at: 'results' ifAbsent:[#()]) collect: [:each | N4CypherResult json: each]).
	inst transaction: (jsonObject at: 'transaction' ifAbsent:[]).
	inst errors: (jsonObject at: 'errors' ifAbsent:[]).
	^inst