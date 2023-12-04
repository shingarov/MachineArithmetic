Class {
	#name : #DijkstraTest,
	#superclass : #TestCase,
	#category : #'DepthFirstSearch-Tests'
}

{ #category : #'mock objects' }
DijkstraTest >> square [
	<gtExample>
	^AdjacencyStructure fromEdges: { 
		1->2.
		2->3.
		3->4.
		4->1.
	}
]

{ #category : #tests }
DijkstraTest >> test2 [
	| g p |
	g := AdjacencyStructure fromEdges: { 
		1->2.
		2->3.
		3->4.
		4->5.
	}.
	p := g shortestPathFrom: 1 to: 5.
	self assert: p asArray equals: #(2 3 4 5)
]

{ #category : #tests }
DijkstraTest >> test3 [
	| g p |
	g := AdjacencyStructure fromEdges: { 
		1->2.
		1->3.
		2->4.
	}.
	p := g shortestPathFrom: 1 to: 4.
	self assert: p asArray equals: #(2 4)
]

{ #category : #tests }
DijkstraTest >> testSquare2to3 [
	| sq p |
	sq := self square.
	p := sq shortestPathFrom: 2 to: 3.
	self assert: p asArray equals: #(3)
]

{ #category : #tests }
DijkstraTest >> testSquare2to4 [
	| sq p |
	sq := self square.
	p := sq shortestPathFrom: 2 to: 4.
	self assert: p asArray equals: #(3 4)
]
