Class {
	#name : #TarjanSearch,
	#superclass : #Object,
	#instVars : [
		'shape',
		'i',
		'number',
		'lowlink',
		'stack',
		'sccs',
		'treeArcs'
	],
	#category : #DepthFirstSearch
}

{ #category : #'instance creation' }
TarjanSearch class >> of: shape [
	^self basicNew 
		shape: shape;
		initialize
]

{ #category : #private }
TarjanSearch >> initialize [ 
	i := 0.
	number:= Dictionary new.
	lowlink := Dictionary new.
	stack := OrderedCollection new.
	sccs := Set new.
	treeArcs := OrderedCollection  new. "should be Set!"
	^self
]

{ #category : #private }
TarjanSearch >> push: v [
	stack addLast: v
]

{ #category : #private }
TarjanSearch >> shape: anObject [
	shape := anObject
]

{ #category : #API }
TarjanSearch >> strongConnect [
	| w |
	[ "find a not-yet-numbered vertex w"
		w := (Interval from: 1 to: shape size)
			detect: [ :aVertex | (number keys includes: aVertex) not ]
			ifNone: [ ^Forest of: sccs ].
		true
	] whileTrue: [ self strongConnect: w ]
]

{ #category : #API }
TarjanSearch >> strongConnect: v [
	i := i + 1.
	number at: v put: i.
	lowlink at: v put: i.
	self push: v.
	(shape at: v) do: [ :w |
		number at: w
			ifPresent: [ "v->w is a frond or cross-link"
				(stack includes: w) ifTrue: [ lowlink at: v put: ((lowlink at: v) min: (number at: w)) ]]
			ifAbsent: [ "w is not yet numbered: v->w is a tree arc"
				treeArcs add: v->w. "not explicitly described in Tarjan"
				self strongConnect: w.
				lowlink at: v put: ((lowlink at: v) min: (lowlink at: w)) ]
	].
	(lowlink at: v) = (number at: v) ifTrue: [ "v is the root of a component"
		"start new strongly connected component"
		| newSCC myTreeArcs |
		newSCC := OrderedCollection new.
		[stack isEmpty not and: [(number at: stack last) >= (number at: v)]] whileTrue: [ newSCC add: stack removeLast ].
		myTreeArcs := treeArcs select: [ :arc | (newSCC includes: arc key) and: [ newSCC includes: arc value ] ].
		"go back to original numbering"
		"newSCC := newSCC collect: [ :n | number  ]"
		sccs add: ((AdjacencyStructure fromEdges: myTreeArcs nVertices: newSCC max) asTreeGrowingFrom: v) ]

]
