"
I am a Graph in which vertices are labeled with something called ""Node"".
"
Class {
	#name : #LabeledGraph,
	#superclass : #Graph,
	#instVars : [
		'nodes'
	],
	#category : #DepthFirstSearch
}

{ #category : #'as yet unclassified' }
LabeledGraph class >> fromNodeDictionary: d [ 
	| nodes triples |
	nodes := d keys asArray.
	triples := nodes collectWithIndex: [ :key :j | { j . (d at: key) collect: [ :node | nodes indexOf: node ] . key } ].
	^LabeledGraph fromTriples: triples
]

{ #category : #'private - initialization' }
LabeledGraph >> initializeFrom: triples [
	| bounds sortedTriples |
	bounds := 1 to: triples size.
	sortedTriples := triples sorted: [ :a :b | a first <= b first ]. "sort by key"
	keys := sortedTriples collect: #first.
	key2vertex := Dictionary newFromKeys: keys andValues: bounds.
	shape := (sortedTriples collect: #second) collect: [ :neighbours |
		neighbours collect: [ :key | key2vertex at: key ifAbsent: nil ] thenReject: #isNil ].
	nodes := sortedTriples collect: #third.
]

{ #category : #accessing }
LabeledGraph >> keyForNode: n [
	^keys at: (self vertexForNode: n)
]

{ #category : #accessing }
LabeledGraph >> nodeAtVertex: v [ 
	^nodes at: v
]

{ #category : #DFS }
LabeledGraph >> sccNodes [
	^self scc collect: [ :v | nodes at: v ]
]

{ #category : #Dijkstra }
LabeledGraph >> shortestPathFromNode: n1 to: n2 [
	| p |
	p := self shortestPathFrom: (self vertexForNode: n1) to: (self vertexForNode: n2).
	^p collect: [ :j | self nodeAtVertex: j ]
]

{ #category : #DFS }
LabeledGraph >> topologicalSortNodes [
	^self topologicalSort collect: [ :v | nodes at: v ] 
]

{ #category : #accessing }
LabeledGraph >> vertexForNode: n [ 
	^nodes indexOf: n
]
