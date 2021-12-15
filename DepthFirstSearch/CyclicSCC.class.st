"
A maximal set of mutually reachable vertices.
"
Class {
	#name : #CyclicSCC,
	#superclass : #SCC,
	#instVars : [
		'vs'
	],
	#category : #DepthFirstSearch
}

{ #category : #'instance creation' }
CyclicSCC class >> of: vs [
	^self basicNew
		vs: vs;
		yourself
]

{ #category : #comparing }
CyclicSCC >> = another [
	self class == another class ifFalse: [ ^false ].
	^vs = another vs
]

{ #category : #enumerating }
CyclicSCC >> collect: aBlock [
	^self class of: (vs collect: aBlock)
]

{ #category : #enumerating }
CyclicSCC >> do: aBlock [
	^vs do: aBlock
]

{ #category : #comparing }
CyclicSCC >> hash [
	^vs hash
]

{ #category : #accessing }
CyclicSCC >> vs [
	^ vs
]

{ #category : #accessing }
CyclicSCC >> vs: anObject [
	vs := anObject
]
