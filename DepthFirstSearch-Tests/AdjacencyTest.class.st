Class {
	#name : #AdjacencyTest,
	#superclass : #TestCase,
	#category : #'DepthFirstSearch-Tests'
}

{ #category : #'mock objects' }
AdjacencyTest >> ex0123 [
	"Cf. buildG example in https://hackage.haskell.org/package/containers-0.6.5.1/docs/Data-Graph.html"
	<gtExample>
	^AdjacencyStructure fromEdges: { 
		0->1.
		1->2.
		2->0.
		3->1.
	}
]

{ #category : #'mock objects' }
AdjacencyTest >> exPy0123 [
	"Cf. example in https://www.logarithmic.net/pfh/blog/01208083168"
	<gtExample>
	^AdjacencyStructure fromEdges: { 
		0->1.
		1->2.
		2->1.
		2->3.
		3->3.
	}
]

{ #category : #tests }
AdjacencyTest >> testRobustTopSort0123 [

	| sccs |
	sccs := self exPy0123 scc.
	self assert: sccs trees size equals: 3.
	self assert: sccs trees first allNodes asBag equals: #(0) asBag.
	self assert: sccs trees second allNodes asBag equals: #(1 2) asBag.
	self assert: sccs trees third allNodes asBag equals: #(3) asBag.

]

{ #category : #tests }
AdjacencyTest >> testTopSort1 [
	| g |
	g := AdjacencyStructure fromEdges: { 
		0->1.
		1->2.
	}  within: #(0 1 2) asSet.
	self assert: g topologicalSort equals: #(0 1 2) asOrderedCollection
]

{ #category : #tests }
AdjacencyTest >> testTopSort2 [
	| g ts |
	g := AdjacencyStructure fromEdges: { 
		0->1.
		0->2.
	}  within: #(0 1 2) asSet.
	ts := g topologicalSort.
	self assert: ts size equals: 3.
	self assert: ts first equals: 0.
	self assert: ts allButFirst asBag equals: #(1 2) asBag.
]
