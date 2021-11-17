Class {
	#name : #UnsortedQuantifier,
	#superclass : #Object,
	#instVars : [
		'var'
	],
	#category : #'MachineArithmetic-Refinement'
}

{ #category : #'instance creation' }
UnsortedQuantifier class >> doesNotUnderstand: aMessage [
	aMessage selector isUnary ifFalse: [ ^super doesNotUnderstand: aMessage ].
	^self basicNew var: aMessage selector; yourself
]

{ #category : #accessing }
UnsortedQuantifier >> var [
	^ var
]

{ #category : #accessing }
UnsortedQuantifier >> var: anObject [
	var := anObject
]
