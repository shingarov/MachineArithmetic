Class {
	#name : #'ΛPrim',
	#superclass : #Object,
	#category : #SpriteLang
}

{ #category : #'as yet unclassified' }
ΛPrim >> constTy [
	self subclassResponsibility
]

{ #category : #printing }
ΛPrim >> printOn: aStream [
	self printStructOn: aStream
]
