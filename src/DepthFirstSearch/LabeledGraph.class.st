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
LabeledGraph class >> fromEdges: es [
	| dict |
	dict := (es collect: #key) asSet collect: [ :from | from -> Set new ].
	dict := Dictionary newFromAssociations: dict asArray.
	es do: [ :edge | (dict at: edge key) add: edge value ].
	^self fromNodeDictionary: dict
]

{ #category : #'as yet unclassified' }
LabeledGraph class >> fromNodeDictionary: d [ 
	| nodes triples |
	nodes := d keys asArray.
	triples := nodes collectWithIndex: [ :key :j | { j . (d at: key) collect: [ :node | nodes indexOf: node ] . key } ].
	^LabeledGraph fromTriples: triples
]

{ #category : #mutating }
LabeledGraph >> addLink: xy [
	"Non-destructively add the edge x->y, adding missing nodes if needed.
	 Here x and y are node objects.
	 We are assuming the receiver is simple-keyed; raise error otherwise."
	| x y newGraph sx sy |
	(xy isKindOf: Association) "TODO: go over and punish clients who give us {x.y}"
		ifTrue: [x := xy key. y := xy value]
		ifFalse: [x := xy first. y := xy last].
	newGraph := self addNode: x ifPresent: [self copy].
	newGraph := newGraph addNode: y ifPresent: [newGraph copy].
	sx := newGraph vertexForNode: x.
	sy := newGraph vertexForNode: y.	
	newGraph destructivelyLink: sx to: sy.
	^newGraph
]

{ #category : #mutating }
LabeledGraph >> addLinks: edges [
	| g |
	g := self.
	edges do: [ :eachEdge |
		g := g addLink: eachEdge ].
	^g
]

{ #category : #mutating }
LabeledGraph >> addNode: n [
	^self addNode: n ifPresent: [ self error ]
]

{ #category : #mutating }
LabeledGraph >> addNode: n ifPresent: errorBlock [
	^self copy addNodeDestructively: n ifPresent: errorBlock
]

{ #category : #'private - initialization' }
LabeledGraph >> addNodeDestructively: n ifPresent: errorBlock [
	self hasSimpleKeys ifFalse: [ self error ].
	(self includesNode: n) ifTrue: [ ^errorBlock value ].
	shape := shape, {Set new}.
	keys := keys, {self numVertices}.
	key2vertex at: self numVertices put: self numVertices.
	nodes := nodes, {n}.
	^self
]

{ #category : #DFS }
LabeledGraph >> dec: aTree vs: vs [ 
	| v ts |
	v := aTree root.
	ts := aTree subtrees.
	^(ts asOrderedCollection inject: vs into: [ :soFar :thisSubtree | self dec: thisSubtree vs: soFar ]), { self tripleAtVertex: v }
]

{ #category : #mutating }
LabeledGraph >> delNode: n [ 
	^LabeledGraph fromEdges: (self nodeEdges reject: [ :e | e key = n or: [ e value = n ] ])
]

{ #category : #mutating }
LabeledGraph >> delNodes: cVertexes [ 
	^cVertexes inject: self into: [ :graphSoFar :thisNode | graphSoFar delNode: thisNode ]
]

{ #category : #DFS }
LabeledGraph >> flatSccNodes [
	| forest |
	forest := self sccNodes.
	^forest trees collect: [ :eachTree | eachTree allNodes ]
]

{ #category : #accessing }
LabeledGraph >> immediatePredecessorsOf: aNode [ 
	^(self edges
		select: [ :e | (self nodeAtVertex: e value) = aNode ]
		thenCollect: [ :e | self nodeAtVertex: e key ]) asSet
]

{ #category : #accessing }
LabeledGraph >> immediateSuccessorsOf: aNode [
	^(shape at: (self vertexForNode: aNode)) collect: [ :v | self nodeAtVertex: v ]
]

{ #category : #accessing }
LabeledGraph >> includesNode: n [
	^self nodes includes: n
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
LabeledGraph >> nodeRanks [
	"Answer the pair { map . sccs },
	 where sccs is the topologically-sorted sequence of my SCCs (each SCC here is the set of vertices belonging to it),
	 and map is the dictionary from each of my nodes to the index of its SCC in the aforementioned sequence."
	| scc map |
	scc := self flatScc.
	map := Dictionary new.
	scc doWithIndex: [ :eachSCC :j | eachSCC do: [ :v | map at: (nodes at: v) put: j ] ].
	^{ map . scc }
]

{ #category : #accessing }
LabeledGraph >> nodes [
	"There is a subtle but crucial difference between the ivar nodes, and the method #nodes.
	 The ivar nodes is the internal representation which maps the vertices to node objects.
	 The method #nodes returns a collection of node objects."
	^nodes
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
LabeledGraph >> stronglyConnComp [
	^self stronglyConnCompR collect: #get_node
]

{ #category : #DFS }
LabeledGraph >> stronglyConnCompR [
	| forest |
	forest := self scc. "expressed in vertices"
	^forest trees collect: [ :aNode |
			aNode subtrees isEmpty
				ifTrue: [
					| v |
					v := aNode root.
					(self mentionsItself: v)
						ifTrue: [ CyclicSCC of: { self tripleAtVertex: v } ]
						ifFalse: [ AcyclicSCC of: (self tripleAtVertex: v) ]
				] ifFalse: [
				 CyclicSCC of: (self dec: aNode vs: #() )
			 ]]
]

{ #category : #DFS }
LabeledGraph >> topologicalSortNodes [
	^self topologicalSort collect: [ :v | nodes at: v ] 
]

{ #category : #accessing }
LabeledGraph >> tripleAtVertex: v [ 
	^{
	self keyAtVertex: v.
	(shape at: v) collect: [ :neighbor | self keyAtVertex: neighbor ].
	self nodeAtVertex: v
	}
]

{ #category : #accessing }
LabeledGraph >> vertexForNode: n [ 
	^nodes indexOf: n
]
