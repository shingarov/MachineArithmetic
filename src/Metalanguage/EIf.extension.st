Extension { #name : #EIf }

{ #category : #'*Metalanguage' }
EIf >> toANF [
	^EIf
		cond: cond toANF
		trueE: trueE toANF
		falseE: falseE toANF
]

{ #category : #'*Metalanguage' }
EIf >> toMIF [
	^EIf
		cond: cond toMIF
		trueE: trueE toMIF
		falseE: falseE toMIF
]
