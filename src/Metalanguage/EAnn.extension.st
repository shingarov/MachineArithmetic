Extension { #name : #EAnn }

{ #category : #'*Metalanguage' }
EAnn >> macroExpandEVar: f to: aΛExpr [
	^EAnn
		expr: (expr macroExpandEVar: f to: aΛExpr)
		ann: ann "BOGUS, would be much better to allow inlining in refinements"
]

{ #category : #'*Metalanguage' }
EAnn >> toANF [
	^EAnn
		expr: expr toANF
		ann: ann
]

{ #category : #'*Metalanguage' }
EAnn >> toMIF [
	^EAnn
		expr: expr toMIF
		ann: ann
]
