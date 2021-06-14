Class {
	#name : #OptionElement,
	#superclass : #Object,
	#category : #'MachineArithmetic-Coq'
}

{ #category : #'instance creation' }
OptionElement class >> of: anElement [
	| option val  |
	option := anElement findXPath: '/option'.
	val := option attributeAt: 'val' ifAbsent: [self error].
	val = 'none' ifTrue: [ ^nil ].
	val = 'some' ifFalse: [ self error ].
	^option
]
