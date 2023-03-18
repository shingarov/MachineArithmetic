Extension { #name : #EApp }

{ #category : #'*SpriteLang' }
EApp >> isRVarApp: γ whichCameFrom: unevaluated [
"
isRVarApp :: (F.Symbol -> Bool) -> F.Expr -> Either H.Pred F.Expr

In Smalltalk, we use a different type of the first argument.
"
	| k_args k args_ |	k_args := self splitEApp.  k := k_args key.  args_ := k_args value.
	k := (k isKindOf: EVar) ifTrue: [ k sym ] ifFalse: [ ^Either right: unevaluated ].
	
	^((γ at: k) isKindOf: DummyRVar)
		ifTrue: [ Either left: (RefVarApp "FUCK!!! INVESTIGATE!!!! HVar??????" var: k args: (args_ collect: #rvarArgSymbol)) ]
		ifFalse: [ Either right: unevaluated ]
]
