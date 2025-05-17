Extension { #name : #EAnn }

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
