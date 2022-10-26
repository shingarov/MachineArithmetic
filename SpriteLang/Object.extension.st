Extension { #name : #Object }

{ #category : #'*SpriteLang' }
Object >> subsTy1: a x: x [
"
Type Substitutions
------------------
class SubsTy a where
  subsTy  :: TvSub -> a -> a
  subsTy1 :: TVar -> RType -> a  -> a
  subsTy1      a       t      x  =  subsTy (singTvSub a t) x
"
	^x subsTy: (self singTvSub: a)
]

{ #category : #'*SpriteLang' }
Object >> subsTyM [
	^self subsTy: ElabState current eSub
	
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
