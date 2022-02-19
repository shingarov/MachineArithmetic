Class {
	#name : #AdjacencyTest,
	#superclass : #TestCase,
	#category : #'DepthFirstSearch-Tests'
}

{ #category : #tests }
AdjacencyTest >> testRobustTopSort0123 [
	"Cf. example in https://www.logarithmic.net/pfh/blog/01208083168"
	<gtExample>
	| g sccs |
	g := AdjacencyStructure fromEdges: { 
		1->2.
		2->3.
		3->2.
		3->4.
		4->4.
	}.
	sccs := g scc trees.
	self assert: sccs size equals: 3.
	self assert: sccs first allNodes asBag equals: #(1) asBag.
	self assert: sccs second allNodes asBag equals: #(2 3) asBag.
	self assert: sccs third allNodes asBag equals: #(4) asBag.

]

{ #category : #tests }
AdjacencyTest >> testTopSort1 [
	| g |
	g := AdjacencyStructure
		fromEdges: { 
			1->2.
			2->3.
		}.
	self assert: g topologicalSort equals: #(1 2 3) asOrderedCollection
]

{ #category : #tests }
AdjacencyTest >> testTopSort2 [
	| g ts |
	g := AdjacencyStructure
		fromEdges: {
			1->2.
			1->3.
		}
		nVertices: 3.
	ts := g topologicalSort.
	self assert: ts size equals: 3.
	self assert: ts first equals: 1.
	self assert: ts allButFirst asBag equals: #(2 3) asBag.
]
