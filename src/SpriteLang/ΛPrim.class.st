Class {
	#name : #'ΛPrim',
	#superclass : #Object,
	#category : #SpriteLang
}

{ #category : #'as yet unclassified' }
ΛPrim >> constTy [
	self subclassResponsibility
]

{ #category : #testing }
ΛPrim >> isConstantNamed: s [
	"I can't be anything but a literal."
	^false
]

{ #category : #printing }
ΛPrim >> printOn: aStream [
	self printStructOn: aStream
]
