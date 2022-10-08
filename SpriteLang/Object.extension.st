Extension { #name : #Object }

{ #category : #'*SpriteLang' }
Object >> subsTyM [
	^ElabState current subsTyM: self
	
]

{ #category : #'*SpriteLang' }
Object >> subst: oldSymbol with: newSymbol [
"
subst :: (F.Subable a) => a -> F.Symbol -> F.Symbol -> a
subst thing x y = substImm thing x (EVar y ())
"
	oldSymbol = newSymbol ifTrue: [ ^self ].
	^self substImm: oldSymbol imm: (FxEVar of: newSymbol)
]
