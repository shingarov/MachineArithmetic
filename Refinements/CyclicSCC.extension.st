Extension { #name : #CyclicSCC }

{ #category : #'*Refinements' }
CyclicSCC class >> addCut: f vs: vs [
	| v vs1 sccs |
	vs isNil ifTrue: [ ^#() ].
	v := vs key.
	vs1 := vs value.
	sccs := (LabeledGraph fromTriples: vs1) stronglyConnCompR.
	^({v dCut}, (sccs collect: [ :scc | scc sccDep: f ])) fold: [ :a :b | a, b ] 
]

{ #category : #'*Refinements' }
CyclicSCC class >> cycleDep: f vs: vs [
	vs isEmpty ifTrue: [ ^#() ].
	^self addCut: f vs: (f value: vs)
]

{ #category : #'*Refinements' }
CyclicSCC >> sccDep: f [ 
	^self class cycleDep: f vs: vs
]
