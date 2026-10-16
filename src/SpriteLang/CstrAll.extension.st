Extension { #name : #CstrAll }

{ #category : #'*SpriteLang' }
CstrAll >> simplifyConstraintGo [
"
go (H.All b c) = H.All b <$> go c
"
	| p′ |
	p′ := p simplifyConstraintGo.
	p′ isNil ifTrue: [ ^nil ].
	^CstrAll
		bind: bind
		p: p′
]

{ #category : #'*SpriteLang' }
CstrAll >> strengthenInv: aΓContext [
"
go (H.All b c) = H.All  (strengthenBind g b) (go c)
"
	^CstrAll
		bind: (bind strengthenBind: aΓContext)
		p: (p strengthenInv: aΓContext)
]
