Class {
	#name : #SpriteHornTest,
	#superclass : #TestCaseWithZ3Context,
	#category : #'SpriteLang-Tests-Horn'
}

{ #category : #tests }
SpriteHornTest >> verify: txt [
	| q |
	q := NNFParser parse: txt.
	self deny: q isPetitFailure.
	^q solve
]
