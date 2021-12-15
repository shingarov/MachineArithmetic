Class {
	#name : #Tree,
	#superclass : #Object,
	#instVars : [
		'root',
		'subforest'
	],
	#category : #DepthFirstSearch
}

{ #category : #'instance creation' }
Tree class >> leaf: r [
	"Construct a tree with a single root and no subforest."
	^self root: r subtrees: #()

]

{ #category : #'instance creation' }
Tree class >> root: r subforest: s [
	"Construct a tree with a root and subforest."
	^self basicNew
		root: r;
		subforest: s;
		yourself
]

{ #category : #'instance creation' }
Tree class >> root: r subtrees: s [
	^self root: r subforest: (Forest of: s)
]

{ #category : #'topological sorting' }
Tree >> postorder: aCollection [
	self shouldBeImplemented 
]

{ #category : #printing }
Tree >> printOn: aStream [
	self root printOn: aStream.
	aStream nextPutAll: ' ('.
	self subtrees printOn: aStream delimiter: ' '.
	aStream nextPutAll: ')'.
	
]

{ #category : #accessing }
Tree >> root [
	^ root
]

{ #category : #accessing }
Tree >> root: anObject [
	root := anObject
]

{ #category : #accessing }
Tree >> subforest [
	^ subforest
]

{ #category : #accessing }
Tree >> subforest: anObject [
	subforest := anObject
]

{ #category : #accessing }
Tree >> subtrees [
	^ subforest trees
]
