Extension { #name : #ECon }

{ #category : #'*Metalanguage' }
ECon >> mifApp: e [ 
	^ΛEApp
		expr: e "halt"
		imm: self
]
