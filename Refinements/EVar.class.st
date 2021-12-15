Class {
	#name : #EVar,
	#superclass : #Object,
	#instVars : [
		'varName'
	],
	#category : #Refinements
}

{ #category : #'instance creation' }
EVar class >> of: v [
	^self basicNew
		varName: v;
		yourself
]

{ #category : #comparing }
EVar >> = rhs [
	rhs class == self class ifFalse: [ ^false ].
	^varName = rhs varName
]

{ #category : #comparing }
EVar >> hash [
	^varName hash
]

{ #category : #printing }
EVar >> printOn: aStream [
	aStream nextPut: $«.
	aStream nextPutAll: varName.
	aStream nextPut: $».
]

{ #category : #'as yet unclassified' }
EVar >> readStream [
	^varName readStream
]

{ #category : #'term rewriting' }
EVar >> subst: θ [
	θ list do: [ :ass | varName = ass key ifTrue: [ ^ass value ] ].
	^self
]

{ #category : #accessing }
EVar >> varName [
	^ varName
]

{ #category : #accessing }
EVar >> varName: anObject [
	varName := anObject
]
