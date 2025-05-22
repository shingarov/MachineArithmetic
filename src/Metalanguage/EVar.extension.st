Extension { #name : #EVar }

{ #category : #'*Metalanguage' }
EVar >> mifApp: e [ 
	^ΛEApp
		expr: e
		imm: self
]

{ #category : #'*Metalanguage' }
EVar >> mifCase: alts [
	^ ECase x: sym alts: alts
]

{ #category : #'*Metalanguage' }
EVar >> mifIfThen: trueE else: falseE [
	^EIf
		cond: self
		trueE: trueE
		falseE: falseE
]

{ #category : #'*Metalanguage' }
EVar >> toANF [
	^self
]

{ #category : #'*Metalanguage' }
EVar >> toMIF [
	^self
]
