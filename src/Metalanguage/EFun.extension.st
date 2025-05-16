Extension { #name : #EFun }

{ #category : #'*Metalanguage' }
EFun >> macroExpandEVar: f to: aΛExpr [
	f = bind id ifTrue: [ self error: 'α-collision!!!' ].
	^EFun
		bind: bind
		expr: (expr macroExpandEVar: f to: aΛExpr)
]

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
