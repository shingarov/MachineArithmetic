"
I represent a finite, directed graph with integer vertices as an adjacency list.
"
Class {
	#name : #Graph,
	#superclass : #AdjacencyStructure,
	#instVars : [
		'vertexMap',
		'keyVertex'
	],
	#category : #DepthFirstSearch
}

{ #category : #'instance creation' }
Graph class >> fromEdges: collectionOfTriples [
	^self basicNew initializeFrom: collectionOfTriples
]

{ #category : #accessing }
Graph >> edges [
	| es |
	es := OrderedCollection new.
	shape associationsDo: [ :ass |
		| from tos |
		from := ass key.
		tos := ass value.
		tos do: [ :to | es add: from->to ]
	].
	^es
]

{ #category : #accessing }
Graph >> edgesOutOfVertex: v [ 
	^(shape at: v) collect: [ :to | v->to ]
]

{ #category : #accessing }
Graph >> indegreeOf: vertex [ 
	^(self edges select: [ :from_to | from_to value = vertex ]) size
]

{ #category : #accessing }
Graph >> indexFor: key [
	^keyVertex value: key
]

{ #category : #'private - initialization' }
Graph >> initializeFrom: edges [
	| bounds0 sortedEdges keyMap |
	bounds0 := 1 to: edges size.
	sortedEdges := edges sorted: [ :a :b | a second < b second ].
	vertexMap := Dictionary newFromKeys: bounds0 andValues: sortedEdges.
	keyMap := vertexMap collect: [ :node_key_out | node_key_out second ].
	keyVertex := [ :key | keyMap keyAtValue: key ifAbsent: [nil]].
	shape := vertexMap collect: [ :node_key_out | node_key_out third collect: keyVertex thenReject: [ :x | x isNil ] ]
]

{ #category : #accessing }
Graph >> keyAtVertex: v [ 
	^(vertexMap at: v) second
]

{ #category : #accessing }
Graph >> nodeAtVertex: v [ 
	^(vertexMap at: v) first
]

{ #category : #accessing }
Graph >> outdegreeOf: vertex [
	^(shape at: vertex) size
]

{ #category : #'as yet unclassified' }
Graph >> postOrd [
	^self dff postorder: #()
]

{ #category : #transformations }
Graph >> reverse [
	"Reverse all edges in-place."
	| reversedEdges |
	reversedEdges := self edges collect: #reverse.
	self initializeShapeFromAssocs: reversedEdges within: self vertices.
	^self
]

{ #category : #transformations }
Graph >> reversed [
	| copy |
	copy := self copy.
	copy instVarNamed: #shape put: shape copy.
	^copy reverse
]

{ #category : #'as yet unclassified' }
Graph >> transpose [
	| transposedEdges |
	transposedEdges := self edges collect: #reverse.
	^self copy initializeShapeFromAssocs: transposedEdges within: self vertices
]

{ #category : #accessing }
Graph >> vertices [
	^shape keys
]
