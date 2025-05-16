Extension { #name : #EImm }

{ #category : #'*Metalanguage' }
EImm >> macroExpandEVar: x to: aΛExpr [
	^EImm imm: (imm macroExpandEVar: x to: aΛExpr)
]

{ #category : #'*Metalanguage' }
EImm >> toANF [
	^self
]

{ #category : #'*Metalanguage' }
EImm >> toMIF [
	^self
]
