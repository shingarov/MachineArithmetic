Extension { #name : #ProtoObject }

{ #category : #'*SpriteLang' }
ProtoObject >> rvarArgSymbol [
"
rvarArgSymbol :: String -> F.Expr -> F.Symbol
...
rvarArgSymbol _ e = error...
"
	^'Unexpected argument in ref-variable' error
]
