Extension { #name : #Object }

{ #category : #'*PreSmalltalks-Substitutions' }
Object >> subSymbol: b [
	self error: 'Cannot substitute symbol ', b printString, ' with expression ', self printString
]

{ #category : #'*PreSmalltalks-Substitutions' }
Object >> subst1: x_e [
	"
	subst1 :: a -> (Symbol, Expr) -> a
	subst1 y (x, e) = subst (Su $ M.fromList [(x,e)]) y
	
	Obviously, this works for any subable a.
	"
	^self subst: (Subst mkSubst: {x_e})
]

{ #category : #'*PreSmalltalks-Substitutions' }
Object >> substImm: fromSymbol imm: toImm [
"
substImm :: (F.Subable a) => a -> F.Symbol -> Imm b -> a
substImm thing x y = F.subst su thing
  where
    su          = F.mkSubst [(x, immExpr y)]
"
	| su |
	su := Subst mkSubst: { fromSymbol -> toImm immExpr }.
	^self subst: su
]
