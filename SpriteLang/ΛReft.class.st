Class {
	#name : #'ΛReft',
	#superclass : #Object,
	#category : #SpriteLang
}

{ #category : #'instance creation' }
ΛReft class >> new [
	^KnownReft new
]

{ #category : #semigroup }
ΛReft >> , anotherReft [
	self subclassResponsibility
]

{ #category : #'as yet unclassified' }
ΛReft >> freshR: Γ base: b [
	self subclassResponsibility
]

{ #category : #testing }
ΛReft >> isKnown [
	self subclassResponsibility 
]
