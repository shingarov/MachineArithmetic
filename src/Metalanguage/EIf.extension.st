Extension { #name : #EIf }

{ #category : #'*Metalanguage' }
EIf >> macroExpandEVar: f to: aΛExpr [
	^EIf
		cond: cond "this can only be an EVar, and at least for now we aren't considering reflecting on value-Bools"
		trueE: (trueE macroExpandEVar: f to: aΛExpr)
		falseE: (falseE macroExpandEVar: f to: aΛExpr)
]

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
