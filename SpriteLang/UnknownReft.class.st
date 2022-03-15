Class {
	#name : #UnknownReft,
	#superclass : #'ΛReft',
	#category : #SpriteLang
}

{ #category : #semigroup }
UnknownReft >> , anotherReft [
	^anotherReft
]

{ #category : #testing }
UnknownReft >> isKnown [
	^false
]

{ #category : #printing }
UnknownReft >> printOn: aStream [
	aStream nextPut: Character starOperator
]
