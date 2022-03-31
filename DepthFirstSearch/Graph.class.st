"
I represent a finite, directed graph with integer vertices as an adjacency list.
Because the keys belong to a totally-ordered set, we think of the vertices as
the members of Interval from: 1 to: |V|, which we call Bounds; the map between
Bounds and {V} is a bijection.

Some day we will unify this codebase, Luciano's Domains, and MalGraphAlgorithms
into a common foundation for Smalltalk-25.
"
Class {
	#name : #Graph,
	#superclass : #AdjacencyStructure,
	#instVars : [
		'keys',
		'key2vertex'
	],
	#category : #DepthFirstSearch
}

{ #category : #'instance creation' }
Graph class >> fromDictionary: d [
	| assocs |
	assocs := d associations.
	^self fromPairs: (assocs collect: [ :ass | Array with: ass key with: ass value  ])
]

{ #category : #'instance creation' }
Graph class >> fromEdges: collectionOfAssocs [
	self shouldNotImplement
]

{ #category : #'instance creation' }
Graph class >> fromPairs: collectionOfPairs [
	"Create a Graph from a collection of triples (Arrays of size 3) characterizing each vertex.
	 Each vertex is uniquely identified by a key, and to each vertex corresponds a set called
	 an 'adjacency list' of keys.
	 Keys must respond to #<= forming a total aka linear order.
	 Each pair then, is the array { key . [adjacentKeys] }.
	"
	^Graph basicNew initializeFrom: collectionOfPairs
]

{ #category : #'instance creation' }
Graph class >> fromTriples: collectionOfTriples [
	"Create a Graph from a collection of triples (Arrays of size 3) characterizing each vertex.
	 Each vertex is uniquely identified by a key, and to each vertex corresponds a set called
	 an 'adjacency list' of keys.
	 Keys must respond to #<= forming a total aka linear order.
	 In a LabeledGraph, each vertex is also labeled by something called 'node'.
	 Each triple then, is the array { key. [adjacentKeys]. node. }.
	"
	^LabeledGraph basicNew initializeFrom: collectionOfTriples
]

{ #category : #accessing }
Graph >> edges [
	| es |
	es := OrderedCollection new.
	1 to: self numVertices do: [ :from |
		(shape at: from) do: [ :to | es add: from->to ]
	].
	^es
]

{ #category : #accessing }
Graph >> edgesOutOfVertex: v [ 
	^(shape at: v) collect: [ :to | v->to ]
]

{ #category : #testing }
Graph >> hasSimpleKeys [
	^keys = (1 to: self numVertices)
]

{ #category : #accessing }
Graph >> includesKey: k [
	^self keys includes: k
]

{ #category : #accessing }
Graph >> indegreeOf: vertex [ 
	^(self edges select: [ :from_to | from_to value = vertex ]) size
]

{ #category : #'private - initialization' }
Graph >> initializeFrom: triples [
	| bounds sortedTriples |
	bounds := 1 to: triples size.
	sortedTriples := triples sorted: [ :a :b | a first <= b first ]. "sort by key"
	keys := sortedTriples collect: #first.
	key2vertex := Dictionary newFromKeys: keys andValues: bounds.
	shape := (sortedTriples collect: #second) collect: [ :neighbours |
		neighbours collect: [ :key | key2vertex at: key ] ].
]

{ #category : #accessing }
Graph >> keyAtVertex: v [ 
	^keys at: v
]

{ #category : #accessing }
Graph >> keys [
	"There is a subtle but crucial difference between the ivar keys, and the method #keys.
	 The ivar keys is the internal representation which maps the vertices to keys.
	 The method #keys returns a collection of keys."
	^keys
]

{ #category : #accessing }
Graph >> nodeEdges [
	^self edges collect: [ :e | (self nodeAtVertex: e key) -> (self nodeAtVertex: e value) ]
]

{ #category : #accessing }
Graph >> outdegreeOf: vertex [
	^(shape at: vertex) size
]

{ #category : #transformations }
Graph >> reverse [
	"Reverse all edges in-place."
	| reversedEdges |
	reversedEdges := self edges collect: #reverse.
	self initializeShapeFromAssocs: reversedEdges nVertices: shape size.
	^self
]

{ #category : #transformations }
Graph >> reversed [
	| copy |
	copy := self copy.
	copy instVarNamed: #shape put: shape copy.
	^copy reverse
]

{ #category : #DFS }
Graph >> sccKeys [
	^self scc collect: [ :v | keys at: v ]
]

{ #category : #transformations }
Graph >> topologicalSortKeys [
	^self topologicalSort collect: [ :v | keys at: v ] 
]

{ #category : #accessing }
Graph >> vertexAtKey: k [
	^key2vertex at: k
]
