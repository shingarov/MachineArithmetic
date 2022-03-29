Class {
	#name : #SCCTest,
	#superclass : #TestCase,
	#category : #'DepthFirstSearch-Tests'
}

{ #category : #'mock objects' }
SCCTest >> aGraph [
	<gtExample>
	^Graph fromTriples: (OrderedCollection
		with: { 0.  #(1).   'a'. }
		with: { 1.  #(2 3). 'b'. }
		with: { 2.  #(1).   'c'. }
		with: { 3.  #(3).   'd'. }
	)
]

{ #category : #tests }
SCCTest >> testStronglyConnComp [
	| SCCs cyclics acyclics |
	SCCs := self aGraph stronglyConnComp.
	self assert: SCCs size equals: 3.
	cyclics  := SCCs select: [ :anSCC | anSCC isKindOf: CyclicSCC ].
	acyclics := SCCs select: [ :anSCC | anSCC isKindOf: AcyclicSCC ].
	self assert: acyclics size equals: 1.
	self assert: cyclics size  equals: 2.
	

]

{ #category : #tests }
SCCTest >> testStronglyConnCompR [
	| SCCs acyclics acyclic cyclics d bc |
	SCCs := self aGraph stronglyConnCompR.
	self assert: SCCs size equals: 3.
	cyclics  := SCCs select: [ :anSCC | anSCC isKindOf: CyclicSCC ].
	acyclics := SCCs select: [ :anSCC | anSCC isKindOf: AcyclicSCC ].
	self assert: acyclics size equals: 1.
	acyclic := acyclics first.
	self assert: acyclic v equals: { 0 . #(1) . 'a' }.
	self assert: cyclics  size equals: 2.
	d  := cyclics detect: [ :cyc | cyc vs size = 1 ].
	self assert: d vs first  equals: { 3 . #(3) . 'd' }.
	bc := cyclics detect: [ :cyc | cyc vs size = 2 ].
	self assert: (bc vs detect: [ :triple | triple first = 1 ]) third equals: 'b'.
	self assert: (bc vs detect: [ :triple | triple first = 2 ]) third equals: 'c'.
]
