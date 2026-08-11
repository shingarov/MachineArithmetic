Extension { #name : #CstrAll }

{ #category : #'*SpriteLang' }
CstrAll >> strengthenInv: aΓContext [
"
go (H.All b c) = H.All  (strengthenBind g b) (go c)
"
	^CstrAll
		bind: (bind strengthenBind: aΓContext)
		p: (p strengthenInv: aΓContext)
]
