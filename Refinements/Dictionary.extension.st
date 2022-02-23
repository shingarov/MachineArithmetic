Extension { #name : #Dictionary }

{ #category : #'*Refinements' }
Dictionary >> rankF: outR _: inR [
	^[ :i | Rank
			scc: (outR at: i)
			icc: (inR  at: i)
			tag: (self at: i) tag ]
]
