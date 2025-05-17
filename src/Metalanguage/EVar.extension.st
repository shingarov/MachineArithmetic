Extension { #name : #EVar }

{ #category : #'*Metalanguage' }
EVar >> mifApp: e [ 
	^ΛEApp
		expr: e "halt"
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
