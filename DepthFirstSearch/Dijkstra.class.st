"
This is Dijkstra's algorithm for computing distances and shortest paths in a graph from a fixed starting node (source). If the graph is edge-labeled, the labels are used as weights.

Pre-Input: a graph G = (V, E), and a node (source);
Input: a target node;
Output: the shortest distance from the source node to the target node, or a shortest path.

The initial precomputation takes time O(|V|^2). Afterwards, it's possible to compute disntances in time O(log |V|) and shortest paths of length k in O(k log |V|). The O(log |V|) comes from the dictionary lookup operation, a lookup in a hash table.
"
Class {
	#name : #Dijkstra,
	#superclass : #Object,
	#instVars : [
		'graph',
		'source',
		'predecessor',
		'distance'
	],
	#category : #DepthFirstSearch
}

{ #category : #'instance creation' }
Dijkstra class >> graph: aGraph source: aNode [
	^ self basicNew graph: aGraph source: aNode
]

{ #category : #accessing }
Dijkstra >> distanceTo: anObject [
	^ distance at: anObject
]

{ #category : #accessing }
Dijkstra >> eccentricity [
	"Answer the eccentricity of the source vertex.
	The eccentricity of a vertex is the length of the longest minimal path from that vertex to some vertex in the graph. You can think of the eccentricity of a vertex as the longest distance in the graph from there to somewhere."

	^ distance max
]

{ #category : #initialization }
Dijkstra >> graph: aGraph source: aNode [
	graph := aGraph.
	source := aNode.
	self run
]

{ #category : #private }
Dijkstra >> run [
	| queue u estimate |
	predecessor := Dictionary new.
	distance := Dictionary new.
	graph vertices do: [:each |
		distance at: each put: Float infinity.
		predecessor at: each put: nil].
	distance at: source put: 0.
	queue := Heap sortBlock: [:a :b| (distance at: a) <= (distance at: b)].
	queue addAll: graph vertices.
	[queue isEmpty]
		whileFalse:
			[u := queue removeFirst.
			graph childrenOf: u do: [ :each |
				estimate := (distance at: u) + 1 "(weight ifNil: [1])".
				(distance at: each) > estimate
					ifTrue: [distance at: each put: estimate. queue reSort.
					predecessor at: each put: u]]]
]

{ #category : #accessing }
Dijkstra >> shortestPathTo: v [
	| answer node predecessorNode |
	v = source ifTrue: [^ #()].
	answer := OrderedCollection new.
	node := v.
	[answer add: node.
	predecessorNode := predecessor at: node.
	predecessorNode = source]
		whileFalse: [node := predecessorNode].
	^ answer reversed
]
