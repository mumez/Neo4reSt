examples
example1
	"N4ObjectDumper example1"
	| snapshot workingCopy |
	workingCopy := MCWorkingCopy allManagers detect: [:each | each package name = 'Neo4reSt'].
	snapshot := workingCopy package snapshot.
	N4ObjectDumper dump: snapshot.