Extension { #name : #CstrAnd }

{ #category : #'*SpriteLang' }
CstrAnd >> strengthenInv: aΓContext [
"
go (H.CAnd cs) = H.CAnd (go <$> cs)
"
	^CstrAnd of: (conjuncts collect: (□ strengthenInv: aΓContext))
]
