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

{ #category : #DFS }
AdjacencyStructure >> scc [
	"Answer the Forest representing the receiver's strongly connected components, topologically sorted."
	^self dfs: self transpose postOrd reverse


]

{ #category : #DFS }
AdjacencyStructure >> strongConnect: v [
	^(TarjanSearch of: shape) strongConnect: v
]

{ #category : #DFS }
AdjacencyStructure >> strongConnect: v number: number lowlink: lowlink i: i0 stack: s [
	| i |
	i := i0 + 1. self halt.
	number at: v put: i.
	lowlink at: v put: i.
	s addLast: v.
	
	(shape at: v) do: [ :w |
		number at: w
			ifPresent: [ "v->w is a frond or cross-link"
				(s includes: w) ifTrue: [ lowlink at: v put: ((lowlink at: v) min: (number at: w)) ]]
			ifAbsent: [ "w is not yet numbered: v->w is a tree arc"
				self strongConnect: w number: number lowlink: lowlink i: i stack: s.
				lowlink at: v put: ((lowlink at: v) min: (lowlink at: w)) ]
	].
self halt.
	(lowlink at: v) = (number at: v) ifTrue: [ "v is the root of a component"
		"start new strongly connected component"
		| newSCC |
		newSCC := OrderedCollection new.
		[(number at: s last) >= (number at: v)] whileTrue: [ newSCC add: s removeLast ]].

]

{ #category : #DFS }
AdjacencyStructure >> topSort [
	"Sore the receiver topologically.
	 Answer the sequence of vertices.
	 The order is partially specified by the condition that
	 a vertex i precedes j whenever j is reachable from i but not vice versa."
	^self postOrd reversed
]
