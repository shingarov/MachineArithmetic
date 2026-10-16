Extension { #name : #CstrAnd }

{ #category : #'*SpriteLang' }
CstrAnd >> simplifyConstraintGo [
	| simplifiedConjuncts |
	simplifiedConjuncts := conjuncts collectMaybe: #simplifyConstraintGo.
	simplifiedConjuncts isEmpty  ifTrue: [ ^nil ].                        "[]  -> Nothing"
	simplifiedConjuncts size = 1 ifTrue: [ ^simplifiedConjuncts anyOne ]. "[c] -> Just c"
	^(CstrAnd of: simplifiedConjuncts)                                    "cs' -> Just (H.CAnd cs')"
]

{ #category : #'*SpriteLang' }
CstrAnd >> strengthenInv: aΓContext [
"
go (H.CAnd cs) = H.CAnd (go <$> cs)
"
	^CstrAnd of: (conjuncts collect: (□ strengthenInv: aΓContext))
]
