Class {
	#name : #TypeLevelConstraint,
	#superclass : #Object,
	#instVars : [
		'block',
		'outputRType'
	],
	#category : #SpriteLang
}

{ #category : #'instance creation' }
TypeLevelConstraint class >> block: b outputRType: ot [
	^self basicNew
		block:b;
		outputRType:ot;
		yourself
]

{ #category : #'bv size resolution' }
TypeLevelConstraint >> addTo: aBvLengthInference [
	aBvLengthInference addConstraint: (block value: outputRType)
]

{ #category : #accessing }
TypeLevelConstraint >> block [
	^ block
]

{ #category : #accessing }
TypeLevelConstraint >> block: anObject [
	block := anObject
]

{ #category : #accessing }
TypeLevelConstraint >> outputRType [
	^ outputRType
]

{ #category : #accessing }
TypeLevelConstraint >> outputRType: anObject [
	outputRType := anObject
]

{ #category : #SubsTy }
TypeLevelConstraint >> subsTy: θ [
	^self copy
		outputRType: (outputRType subsTy: θ);
		yourself
]
