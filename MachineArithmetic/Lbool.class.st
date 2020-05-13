Class {
	#name : #Lbool,
	#superclass : #Object,
	#category : #'MachineArithmetic-Core'
}

{ #category : #'as yet unclassified' }
Lbool class >> FALSE [
	^ -1
]

{ #category : #'as yet unclassified' }
Lbool class >> TRUE [
	^ 1
]

{ #category : #'as yet unclassified' }
Lbool class >> UNDEF [
	^ 0
]

{ #category : #'as yet unclassified' }
Lbool class >> decode: anEnumCode [
	anEnumCode = self TRUE  ifTrue: [ ^true  ].
	anEnumCode = self FALSE ifTrue: [ ^false ].
	anEnumCode = self UNDEF ifTrue: [ ^nil ].
	self error: 'unknown enum'
]
