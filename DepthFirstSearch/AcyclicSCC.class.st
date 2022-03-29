"
A single vertex that is not in any cycle.
"
Class {
	#name : #AcyclicSCC,
	#superclass : #SCC,
	#instVars : [
		'v'
	],
	#category : #DepthFirstSearch
}

{ #category : #'instance creation' }
AcyclicSCC class >> of: v [
	^self basicNew
		v: v;
		yourself
]

{ #category : #comparing }
AcyclicSCC >> = another [
	self class == another class ifFalse: [ ^false ].
	^v = another v
]

{ #category : #enumerating }
AcyclicSCC >> collect: aBlock [
	^self class of: (aBlock value: v)
]

{ #category : #enumerating }
AcyclicSCC >> do: aBlock [
	^self class of: (aBlock value: v)
]

{ #category : #'as yet unclassified' }
AcyclicSCC >> get_node [
	^AcyclicSCC of: v third
]

{ #category : #comparing }
AcyclicSCC >> hash [
	^v hash
]

{ #category : #accessing }
AcyclicSCC >> v [
	^ v
]

{ #category : #accessing }
AcyclicSCC >> v: anObject [
	v := anObject
]
