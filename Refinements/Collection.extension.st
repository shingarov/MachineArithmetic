Extension { #name : #Collection }

{ #category : #'*Refinements' }
Collection >> elaborate [
	^self collect: #elaborate
]

{ #category : #'*Refinements' }
Collection >> flatten [
"
instance Flatten [Cstr a] where
	...
instance Flatten [Pred] where
	...
"
	self isEmpty ifTrue: [ ^self species new ].
	^self anyOne class flatten: self
]

{ #category : #'*Refinements' }
Collection >> refineK: ho env: env rft: vtk [
"
This must be refactored if we keep this old way (before the QCluster optimization).
cf. Solution.hs"
	| v t k eqs eqs1 |
	v := vtk first.
	t := vtk second.
	k := vtk third.
	eqs := self instK: ho env: env v: v t: t.
	eqs1 := eqs select: [ :thisEQual | thisEQual okInst: env symbol: v sort: t ].
	^k -> eqs1
]
