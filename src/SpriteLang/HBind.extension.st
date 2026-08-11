Extension { #name : #HBind }

{ #category : #'*SpriteLang' }
HBind >> strengthenBind: aΓContext [
"
strengthenBind :: Env -> H.Bind a -> H.Bind a
"
	| p′ |
	p′ := aΓContext getInv: x ofSort: τ.
	p′ isNil ifTrue: [ ^self ].  "Nothing -> b"
	^HBind
		x: x τ: τ p: p, p′
]
