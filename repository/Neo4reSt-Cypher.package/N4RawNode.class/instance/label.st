accessing
label
	^ (self labels ifEmpty: [#(nil)]) at: 1.
	