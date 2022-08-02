Extension { #name : #LabeledGraph }

{ #category : #'*Refinements' }
LabeledGraph >> boundElims: isK ds: ds [ 
	^ds "BOGUS"
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
"
	^self boundElims: kF ds: (self sccElims: cutF)
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
