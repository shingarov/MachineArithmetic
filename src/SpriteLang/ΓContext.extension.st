Extension { #name : #'ΓContext' }

{ #category : #'*SpriteLang' }
ΓContext >> getInv: x ofSort: t [
"
getInv :: Env -> F.Symbol -> F.Sort -> Maybe H.Pred
          self   x           t
Cf. Constraints.hs
"
	| ftc tc |
	ftc := t unFApp first.
	(ftc isKindOf: FTC) ifFalse: [ ^nil ].
	tc := ftc typeConstructor.
	^(eInv lookupSEnv: tc symbol)
		ifNotNil: [ :known |
			| v p |
			(known isKindOf: KnownReft) ifFalse: [ ^nil ].
			v := known symbol. p := known expr.
			p subst: v _: x.
		] ifNil: [ nil ]
]
