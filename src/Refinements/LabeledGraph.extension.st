Extension { #name : #LabeledGraph }

{ #category : #'*Refinements' }
LabeledGraph >> boundElims: isK es: es ds: ds [
	"Extend the input `Elims` by adding kuts that ensure
	 that the *maximum distance* between an eliminated KVar
	 and a cut KVar is *upper bounded* by a given threshold.

boundElims :: (Cutable a) => Config -> (a -> Bool) -> [(a, a, [a])] -> Elims a -> Elims a
boundElims cfg isK es ds = maybe ds (bElims isK es ds) (elimBound cfg)

bgs:
	elimBound is an Int configuration parameter (maximum length of KVar chain to eliminate).
	If it is set, call bElims.
	If it is not set, answer the default ds.
	"

	^ds "we don't implement boundElims yet."
]

{ #category : #'*Refinements' }
LabeledGraph >> elimK: kV [
	| cs cis kis es1 |
	cs := self immediateSuccessorsOf: kV.
	cis := self immediatePredecessorsOf: kV.
	kis := cis collectAndCat: [ :x | self immediatePredecessorsOf: x ].
	es1 := (kis reject: #isCstr) ⊗ (cs select: #isCstr).
	^(self addLinks: es1) delNodes: (cis add: kV; yourself)
]

{ #category : #'*Refinements' }
LabeledGraph >> gElims: kF cutF: cutF [
"
gElims :: (Cutable a) => Config -> (a -> Bool) -> Cutter a -> [(a, a, [a])] -> Elims a
gElims cfg kF cutF g = boundElims cfg kF g $ sccElims cutF g
"
	^self boundElims: kF es: self ds: (self sccElims: cutF)
]

{ #category : #'*Refinements' }
LabeledGraph >> sccElims: f [
	"Return an Elims that renders the dependency graph acyclic
	 by picking _at least one_ kvar from each non-trivial SCC in the graph.
	
	sccElims :: (Cutable a) => Cutter a -> [(a, a, [a])] -> Elims a
	"
	| xs |
	xs := self stronglyConnCompR.
	xs isEmpty ifTrue: [ ^Elims new ].
	^(xs collect: [ :x | x sccDep: f ]) fold: [ :a :b | a, b ]
]
