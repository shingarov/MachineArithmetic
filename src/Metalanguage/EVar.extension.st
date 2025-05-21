Extension { #name : #EVar }

{ #category : #'*Metalanguage' }
EVar >> mifApp: e [ 
	^ΛEApp
		expr: e
		imm: self
]

{ #category : #'*Metalanguage' }
EVar >> toANF [
	^self
]

{ #category : #'*Metalanguage' }
EVar >> toMIF [
	^self
]
