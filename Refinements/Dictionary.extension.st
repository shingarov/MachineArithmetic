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
Dictionary >> lookupSEnvWithDistance: key [
	^Found x: (self at: key ifAbsent: [ ^Alts shouldBeImplemented  ])

]

{ #category : #'*Refinements' }
Dictionary >> rankF: outR _: inR [
	^[ :i | Rank
			scc: (outR at: i)
			icc: (inR  at: i)
			tag: (self at: i) tag ]
]
