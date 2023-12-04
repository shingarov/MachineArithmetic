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
Dictionary >> instSymbolGo: i_qp′s tyss: tyss [
	| i qp is |
	i := i_qp′s first first. qp := i_qp′s first last. is := i_qp′s allButFirst.
is isEmpty ifFalse: [ self shouldBeImplemented "TODO" ].
	^(self at: i ifAbsent: [#()]) asArray collect: [ :y |
			"TODO: (qp matchSym: y) maybeToList collectAndCat: [ :qsu |
					self shouldBeImplemented  ]"
		{ y } ]
]

{ #category : #'*Refinements' }
Dictionary >> rankF: outR _: inR [
	^[ :i | Rank
			scc: (outR at: i)
			icc: (inR  at: i)
			tag: (self at: i) tag ]
]
