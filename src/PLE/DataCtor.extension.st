Extension { #name : #DataCtor }

{ #category : #'*PLE' }
DataCtor >> goReWriteDDecl [
"
go (DCtor f xs) = zipWith (\r i -> SMeasure r f' ys (EVar (ys!!i)) ) rs [0..]
Cf. Solver/PLE.hs
"
	| f′ rs ys |
	f′ := dcName.
	rs := dcFields collect: #dfName.
	ys := dcFields with0basedIndexCollect: [ :_ :i | 'darg' intSymbol: i ].
	^rs with0basedIndexCollect: [ :r :i | Rewrite SMeasure: r dc: f′ args: ys body: (EVar of: (ys at: i+1)) ]
]
