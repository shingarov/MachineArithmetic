"
Given a type A, my unique instance is the element of A+𝟙 coming along the injection from 𝟙.
"
Class {
	#name : #UndefinedElement,
	#superclass : #Object,
	#instVars : [
		'type'
	],
	#classInstVars : [
		'Types'
	],
	#category : #Z3
}

{ #category : #'class initialization' }
UndefinedElement class >> initialize [
	Types := Dictionary new
]

{ #category : #'instance creation' }
UndefinedElement class >> of: aType [
	^Types
		at: aType
		ifAbsentPut: [
			self basicNew
				type: aType;
				yourself ]
]

{ #category : #accessing }
UndefinedElement >> type [
	^ type
]

{ #category : #accessing }
UndefinedElement >> type: anObject [
	type := anObject
]
