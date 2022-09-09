actions-indexers
removeNodeIndexes: indexName on: nodeId key: key value: value
	^ self rawClient removeNodeIndexes: indexName on: nodeId key: key value: value