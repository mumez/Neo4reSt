accessing
labels: labels
	^ self httpClient setLabels: labels nodeAt: self id asString