Class {
	#name : #HThing,
	#superclass : #Object,
	#category : #Refinements
}

{ #category : #syntax }
HThing class >> parser [
	^super parser parens
]
