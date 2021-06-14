Class {
	#name : #CoqValue,
	#superclass : #Object,
	#instVars : [
		'valueElement'
	],
	#category : #'MachineArithmetic-Coq'
}

{ #category : #'as yet unclassified' }
CoqValue class >> fromXml: valueElement [ 
	| val |
	valueElement name localName = 'value' ifFalse: [ self error ].
	val := valueElement attributeAt: 'val' ifAbsent: [ self error ].
	val = 'good' ifTrue: [ ^super new valueElement: valueElement; yourself ].
	val = 'fail' ifTrue: [ ^CoqFail signal: valueElement "(valueElement findXPath: 'richpp/_/pp') contentText" ].
	self error
]

{ #category : #accessing }
CoqValue >> valueElement [
	^ valueElement
]

{ #category : #accessing }
CoqValue >> valueElement: anObject [
	valueElement := anObject
]
