Extension { #name : #Number }

{ #category : #'*PreSmalltalks' }
Number >> mod: aNumber [
	"Boute's Euclidean modulo (always nonnegative)"
	| r |
	r := self \\ aNumber.
	^r >= 0
		ifTrue: [ r ]
		ifFalse: [ r + aNumber abs ]
]
