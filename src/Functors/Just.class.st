Class {
	#name : #Just,
	#superclass : #Maybe,
	#instVars : [
		'content'
	],
	#category : #Functors
}

{ #category : #'instance creation' }
Just class >> with: anObject [
	^self basicNew
		content: anObject;
		yourself
]

{ #category : #comparing }
Just >> = rhs [
	rhs class = Just ifFalse: [ ^false ].
	^content = rhs content
]

{ #category : #'Functor API' }
Just >> collect: aBlock [
	^Just with: (aBlock value: content)
]

{ #category : #private }
Just >> content [
	^ content
]

{ #category : #private }
Just >> content: anObject [
	content := anObject
]

{ #category : #comparing }
Just >> hash [
	^content hash
]
