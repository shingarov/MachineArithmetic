Extension { #name : #Dictionary }

{ #category : #'*Refinements' }
Dictionary class >> fromListSEnv: aCollection [
"cf. Environments.hs
fromListSEnv            ::  [(Symbol, a)] -> SEnv a
fromListSEnv            = SE . M.fromList
"
	^self newFromAssociations: aCollection asArray
]

{ #category : #'*Refinements' }
Dictionary >> matchTyss: tyss xs: xs qp_qps: qp_qps [
	"match :: So.Env -> [(F.Sort, [F.Symbol])] -> [F.Symbol] -> [F.QualParam] -> [[F.Symbol]]"
	| qp qps |
	qp_qps isEmpty ifTrue: [ ^{xs} ].
	qp := qp_qps first. qps := qp_qps allButFirst.
	^((qp candidates: self tyss: tyss) collectTriples: [ :su :qsu :x |
		self matchTyss: tyss xs: {x},xs qp_qps: (qps collect: [ :eachQP | eachQP apply: su qpSubst: qsu ]) ]) concat
]

{ #category : #'*Refinements' }
Dictionary >> rankF: outR _: inR [
	^[ :i | Rank
			scc: (outR at: i)
			icc: (inR  at: i)
			tag: (self at: i) tag ]
]
