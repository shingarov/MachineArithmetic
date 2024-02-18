Class {
	#name : #Val,
	#superclass : #SpriteAnn,
	#category : #SpriteLang
}

{ #category : #'α-renaming' }
Val >> rename: a to: b [
	| symbol′ rtype′ metric′ |
	symbol′ := symbol=a ifTrue: [b] ifFalse: [symbol].
	rtype′ := rtype rename: a to: b.
	metric isNil ifFalse: [ self shouldBeImplemented  ].
	^self class
		symbol: symbol′ rtype: rtype′ metric: metric
]
