instance creation
json: jsonObject
	| inst |
	inst := self new.
	inst columns: (jsonObject at: 'columns' ifAbsent:[]).
	inst data: (jsonObject at: 'data' ifAbsent:[]).
	inst stats: (jsonObject at: 'stats' ifAbsent:[]).
	^inst