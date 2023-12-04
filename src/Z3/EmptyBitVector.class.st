"
I am the special BitVector of length zero.
This is not representable in Z3, but sometimes comes handy.
I am NOT a wrapper around a Z3 pointer.
"
Class {
	#name : #EmptyBitVector,
	#superclass : #Object,
	#classVars : [
		'Instance'
	],
	#category : #'Z3-Core'
}

{ #category : #accessing }
EmptyBitVector class >> instance [
	Instance isNil ifTrue: [ Instance := super basicNew ].
	^Instance
]

{ #category : #accessing }
EmptyBitVector class >> new [
	self error
]

{ #category : #copying }
EmptyBitVector >> , y [
	^y
]

{ #category : #copying }
EmptyBitVector >> isBitVector [ 
	^true
]

{ #category : #copying }
EmptyBitVector >> length [ 
	^0
]

{ #category : #printing }
EmptyBitVector >> printOn: aStream [
	aStream nextPutAll: '<BV0 _>'
]

{ #category : #copying }
EmptyBitVector >> value [ 
	self error
]
