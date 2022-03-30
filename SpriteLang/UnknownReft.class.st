Class {
	#name : #UnknownReft,
	#superclass : #'ΛReft',
	#category : #SpriteLang
}

{ #category : #semigroup }
UnknownReft >> , anotherReft [
	^anotherReft
]

{ #category : #'as yet unclassified' }
UnknownReft >> freshR: Γ base: b [
	^Γ freshK: b
]

{ #category : #testing }
UnknownReft >> isKnown [
	^false
]

{ #category : #printing }
UnknownReft >> printOn: aStream [
	aStream nextPut: Character starOperator
]
