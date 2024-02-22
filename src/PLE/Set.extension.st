Extension { #name : #Set }

{ #category : #'*PLE' }
Set >> equalitiesPred [
"
equalitiesPred :: S.HashSet (Expr, Expr) -> [Expr]
cf. PLE.hs
"
	^PAnd of: ((self asArray selectAssociations: [ :e₁ :e₂ | e₁~=e₂ ])
		collectAssociations: [ :e₁ :e₂ | PAtomEq x: e₁ y:e₂  ])
]
