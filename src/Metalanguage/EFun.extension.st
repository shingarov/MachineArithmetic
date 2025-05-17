Extension { #name : #EFun }

{ #category : #'*Metalanguage' }
EFun >> toANF [
	^EFun
		bind: bind
		expr: expr toANF
]

{ #category : #'*Metalanguage' }
EFun >> toMIF [
	^EFun
		bind: bind
		expr: expr toMIF
]
