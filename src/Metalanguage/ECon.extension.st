Extension { #name : #ECon }

{ #category : #'*Metalanguage' }
ECon >> mifApp: e [ 
	^ΛEApp
		expr: e
		imm: self
]

{ #category : #'*Metalanguage' }
ECon >> mifIfThen: trueE else: falseE [
	^EIf
		cond: self
		trueE: trueE
		falseE: falseE
]
