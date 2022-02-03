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

{ #category : #'as yet unclassified' }
AdjacencyStructure >> childrenOf: aVertex do: aBlock [
	(shape at: aVertex) do: aBlock
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
	^Forest of: ((vertices collect: [ :vertex | self generate: vertex alreadyVisited: vis ]) reject: #isNil)

]

{ #category : #Dijkstra }
AdjacencyStructure >> distanceFrom: source to: target [
	^ (Dijkstra graph: self source: source) distanceTo: target
]

{ #category : #Dijkstra }
AdjacencyStructure >> eccentricityOf: anObject [
	^ (Dijkstra graph: self source: anObject) eccentricity
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
	"First identify strongly connected components,
	 then perform a topological sort on these components.
	 Answer the Forest representing the receiver's strongly connected components, topologically sorted."
	| sccs node_component scc_graph sortedSCCs |
	sccs := self strongConnect.
	
	node_component := Dictionary new. "map each node to the SCC it belongs to"
	sccs trees collect: [ :eachSCC | eachSCC allNodes do: [ :eachNode | node_component at: eachNode put: eachSCC ] ].
	
	scc_graph := Dictionary newFromAssociations: (sccs trees asArray collect: [ :eachSCC | eachSCC -> Set new ]).
	shape keys do: [ :eachNode |
		| thisSCC |
		thisSCC := node_component at: eachNode.
		(shape at: eachNode) do: [ :successor |
			| successorSCC |
			successorSCC := node_component at: successor.
			successorSCC = thisSCC ifFalse: [ (scc_graph at: thisSCC) add: successorSCC ]]].
	sortedSCCs := (Graph fromDictionary: scc_graph) topologicalSort.
	^Forest of: sortedSCCs
]

{ #category : #Dijkstra }
AdjacencyStructure >> shortestPathFrom: source to: target [
	^ (Dijkstra graph: self source: source) shortestPathTo: target
]

{ #category : #'as yet unclassified' }
AdjacencyStructure >> strongConnect [
	^(TarjanSearch of: shape) strongConnect
]

{ #category : #DFS }
AdjacencyStructure >> strongConnect: v [
	^(TarjanSearch of: shape) strongConnect: v
]

{ #category : #'as yet unclassified' }
AdjacencyStructure >> topologicalSort [
	"Sort the receiver topologically.
	 Answer the sequence of vertices.
	 The order is partially specified by the condition that
	 a vertex i precedes j whenever j is reachable from i but not vice versa."
	| count ready result |
	count := Dictionary newFromAssociations: (shape keys collect: [ :aNode | aNode -> 0 ]).
	shape associations do: [ :node_successors |
		| successors |
		successors := node_successors value.
		successors do: [ :eachSuccessor | count at: eachSuccessor put: (count at: eachSuccessor)+1 ] ].
	ready := shape keys select: [ :node | (count at: node) = 0 ].
	ready := ready asOrderedCollection.
	result := OrderedCollection new.
	[ready isEmpty] whileFalse: [ 
		| node |
		node := ready removeLast.
		result addLast: node.
		(shape at: node) do: [ :eachSuccessor |
			count at: eachSuccessor put: (count at: eachSuccessor)-1.
			(count at: eachSuccessor) = 0 ifTrue: [ ready addLast: eachSuccessor ]]].
	^result
]

{ #category : #accessing }
AdjacencyStructure >> vertices [
	^shape keys
]
