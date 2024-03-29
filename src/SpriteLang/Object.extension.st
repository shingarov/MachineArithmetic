Extension { #name : #Object }

{ #category : #'*SpriteLang' }
Object >> rsubst1: aRVar with: ar [
"
rsubst1 :: (SubsARef a) => RVar -> RARef -> a -> a
"
	| p |
	p := aRVar rvName.
	^self subsAR: p ar: ar
]

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
Object >> subst: x _: y [
"
subst :: (F.Subable a) => a -> F.Symbol -> F.Symbol -> a
"
	^self substImm: x imm: (EVar of: y)
]

{ #category : #'*SpriteLang' }
Object >> subst: oldSymbol with: newSymbol [
"
subst :: (F.Subable a) => a -> F.Symbol -> F.Symbol -> a
subst thing x y = substImm thing x (EVar y ())
"
	oldSymbol = newSymbol ifTrue: [ ^self ].
	^self substImm: oldSymbol imm: (EVar of: newSymbol)
]

{ #category : #'*SpriteLang' }
Object >> substs: xys [
"
substs :: (F.Subable a) => a -> [(F.Symbol, F.Symbol)] -> a
substs thing xys = L.foldl' (\t (x, y) -> subst t x y) thing xys

We asssume the receiver is subable.
"
	^xys inject: self into: [ :t :x_y |
			| x y |
			x := x_y key. y := x_y value.
			t subst: x _: y ]
]
