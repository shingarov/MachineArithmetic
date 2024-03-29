Extension { #name : #EVar }

{ #category : #'*SpriteLang' }
EVar >> checkImm: Γ rtype: t [
"
checkImm :: Env -> SrcImm -> RType -> CG SrcCstr
"
	| s |
	s := self synthImm: Γ.
	^s ≺ t
]

{ #category : #'*SpriteLang' }
EVar >> immExpr [
	"In Sprite, there is a difference between Sprite.EVar and F.EVar,
	 therefore we go through class Expression>>expr: extract the Symbol
	 out of the Sprite.EVar and wrap it in
	   instance Expression Symbol where
	     expr s = eVar s.
	 In Smalltalk we simply identify the two EVars."
	^self
]

{ #category : #'*SpriteLang' }
EVar >> immTy: Γ [
"
immTy :: Env -> SrcImm -> ElabM RType
immTy g (EVar x l)
 | Just t <- getEnv g x = return ({- Misc.traceShow ('immTy: '' ++ show x) -} t)
 | otherwise            = elabErr ('Unbound variable:' <+> F.pprint x) l
"
	^Γ getEnvDamit: sym
]

{ #category : #'*SpriteLang' }
EVar >> rvarArgSymbol [
"
rvarArgSymbol :: String -> F.Expr -> F.Symbol
rvarArgSymbol _ (F.EVar x) = x
"
	^sym
]

{ #category : #'*SpriteLang' }
EVar >> synthImm: Γ [
"
synthImm :: Env -> SrcImm -> CG RType
    
     ---------------- [Syn-Var]
      Γ ⊦ x ==> Γ(x)
"
	| t |
	t := Γ getEnvDamit: sym. 
	^t singleton: sym
]
