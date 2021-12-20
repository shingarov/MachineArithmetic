"
I encode the shape of a finite, directed graph with integer vertices as an adjacency structure,
associating each vertex of the graph with its adjacency list.
"
Class {
	#name : #AdjacencyStructure,
	#superclass : #Object,
	#instVars : [
		'shape'
	],
	#category : #DepthFirstSearch
}

{ #category : #'instance creation' }
AdjacencyStructure class >> fromEdges: collectionOfAssocs [
	| vertices |
	vertices := Set new.
	collectionOfAssocs do: [ :anEdge |
		vertices add: anEdge key.
		vertices add: anEdge value ].
	^self fromEdges: collectionOfAssocs within: vertices
]

{ #category : #'instance creation' }
AdjacencyStructure class >> fromEdges: collectionOfAssocs within: vertices [
	^self basicNew initializeShapeFromAssocs: collectionOfAssocs within: vertices
]

{ #category : #'as yet unclassified' }
AdjacencyStructure >> asTreeGrowingFrom: root [ 
	^Tree root: root 
		subtrees: ((shape at: root) collect: [ :child | self asTreeGrowingFrom: child ])
]

{ #category : #DFS }
AdjacencyStructure >> components [
	"Answer the Forest representing the connected components of a graph.
	 Two vertices are connected if there is a path between them, traversing edges in either direction."
	self shouldBeImplemented
]

{ #category : #DFS }
AdjacencyStructure >> dff [
	"Answer a spanning forest of the graph,
	 obtained from a depth-first search of the graph starting from each vertex in an unspecified order."
	^self dfs: self vertices

]

{ #category : #DFS }
AdjacencyStructure >> dfs: vertices [
	"Answer a spanning forest of the part of the graph reachable from the listed
	 vertices, obtained from a depth-first search of the graph starting at
	 each of the listed vertices in order."
	^self dfs: vertices alreadyVisited: Set new
]

{ #category : #DFS }
AdjacencyStructure >> dfs: vertices alreadyVisited: vis [
	"Answer a spanning forest of the part of the graph reachable from the listed
	 vertices, obtained from a depth-first search of the graph starting at
	 each of the listed vertices in order."
	^Forest of: (vertices collect: [ :vertex | self generate: vertex alreadyVisited: vis ])

]

{ #category : #DFS }
AdjacencyStructure >> generate: vertex [
	| children |
	children := (shape at: vertex) collect: [ :v | self generate: v ] .
	self shouldBeImplemented


]

{ #category : #DFS }
AdjacencyStructure >> generate: vertex alreadyVisited: vis [
	| children |
	(vis includes: vertex) ifTrue: [ ^nil ].
	vis add: vertex.
	children := (shape at: vertex) collect: [ :v | self generate: v alreadyVisited: vis ] thenReject: #isNil.
	^Tree root: vertex subtrees: children
]

{ #category : #'private - initialization' }
AdjacencyStructure >> initializeShapeFromAssocs: edges within: anInterval [
	shape := Dictionary new.
	anInterval do: [ :vertex | shape at: vertex put: Set new ].
	edges do: [ :from_to | (shape at: from_to key) add: from_to value ]
]

{ #category : #DFS }
AdjacencyStructure >> scc [
	"Answer the Forest representing the receiver's strongly connected components, topologically sorted."
	^self dfs: self transpose postOrd reverse


]

{ #category : #'as yet unclassified' }
AdjacencyStructure >> strongConnect [
	^(TarjanSearch of: shape) strongConnect
]

{ #category : #DFS }
AdjacencyStructure >> strongConnect: v [
	^(TarjanSearch of: shape) strongConnect: v
]

{ #category : #DFS }
AdjacencyStructure >> topSort [
	"Sore the receiver topologically.
	 Answer the sequence of vertices.
	 The order is partially specified by the condition that
	 a vertex i precedes j whenever j is reachable from i but not vice versa."
	^self postOrd reversed
]
