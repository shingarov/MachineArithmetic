Extension { #name : #Collection }

{ #category : #'*Refinements' }
Collection >> instK: ho env: env v: v t: t [
"
instK :: Bool
      -> F.SEnv F.Sort
      -> F.Symbol
      -> F.Sort
      -> [F.Qualifier]
      -> Sol.QBind"
	"cf. Solver/Solution.hs"
	| eQuals |
	eQuals := self asArray collectAndCat: [ :q | q instKQ: ho env: env v: v t: t ].
	^QBind fromEQuals: eQuals "BOGUS: add unique"
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
