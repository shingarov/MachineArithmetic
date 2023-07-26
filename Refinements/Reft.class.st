"
Parsed refinement of @Symbol@ as @Expr@
e.g. in '{v: _ | e }' v is the @Symbol@ and e the @Expr@.

Caveat programmator: this is the Reft in Types.Refinements,
not the one in Horn.Types.

ghci> :i R.Reft
type R.Reft :: *
newtype R.Reft = Reft (F.Symbol, R.Expr)
  	-- Defined in ‘Language.Fixpoint.Types.Refinements’
instance Eq R.Reft
  -- Defined in ‘Language.Fixpoint.Types.Refinements’
instance Monoid R.Reft
  -- Defined in ‘Language.Fixpoint.Types.Substitutions’
instance Semigroup R.Reft
  -- Defined in ‘Language.Fixpoint.Types.Substitutions’
instance Show R.Reft
  -- Defined in ‘Language.Fixpoint.Types.Substitutions’
instance F.Fixpoint R.Reft
  -- Defined in ‘Language.Fixpoint.Types.Substitutions’
instance HasGradual R.Reft
  -- Defined in ‘Language.Fixpoint.Types.Refinements’
instance PPrint R.Reft
  -- Defined in ‘Language.Fixpoint.Types.Substitutions’
instance Subable R.Reft
  -- Defined in ‘Language.Fixpoint.Types.Substitutions’
instance Expression R.Reft
  -- Defined in ‘Language.Fixpoint.Types.Refinements’
instance Reftable R.Reft
  -- Defined in ‘Language.Fixpoint.Types.Substitutions’
"
Class {
	#name : #Reft,
	#superclass : #Object,
	#instVars : [
		'symbol',
		'expr'
	],
	#category : #Refinements
}

{ #category : #naming }
Reft class >> anonymousVarName [
	^VariableAlphabet freshVariableName
]

{ #category : #'instance creation' }
Reft class >> expr: e [ 
	^self
		symbol: self anonymousVarName
		expr: e
]

{ #category : #'instance creation' }
Reft class >> new [
"
instance Monoid Reft where
  mempty  = trueReft
"
	^self trueReft
]

{ #category : #'instance creation' }
Reft class >> symbol: s expr: p [
	^self basicNew 
		symbol: s;
		expr: p;
		yourself
]

{ #category : #constants }
Reft class >> trueReft [
	^Reft
		"symbol: String vv_"  "TODO: Investigate why L4Neg>>foldn00 fails if we don't get a fresh symbol"
		expr: Expr PTrue
]

{ #category : #Semigroup }
Reft >> , rhs [
	^self meetReft: rhs
]

{ #category : #visiting }
Reft >> accept: aVisitor [ 
	^self copy
		expr: (expr accept: aVisitor);
		yourself
]

{ #category : #compilation }
Reft >> evaluateIn: anEvalEnv [ 
	^Reft
		symbol: symbol
		expr: (expr evaluateIn: anEvalEnv)
]

{ #category : #accessing }
Reft >> expr [
	^ expr
]

{ #category : #accessing }
Reft >> expr: anObject [
	expr := anObject
]

{ #category : #logic }
Reft >> isTauto [
	self shouldBeImplemented
]

{ #category : #functoriality }
Reft >> mapPredReft: f [
"
mapPredReft :: (Expr -> Expr) -> Reft -> Reft
mapPredReft f (Reft (v, p)) = Reft (v, f p)
cf. Refinements.hs
"
	^Reft symbol: symbol expr: expr∘f
]

{ #category : #Semigroup }
Reft >> meetReft: rhs [
"
meetReft :: Reft -> Reft -> Reft
"
	symbol = rhs symbol ifTrue: [ ^Reft symbol: symbol expr: expr, rhs expr ].
	symbol = String dummySymbol ifTrue: [ ^Reft
		symbol: rhs symbol
		expr: rhs expr & (expr subst1: symbol->(EVar of: rhs symbol)) ].
	^Reft symbol: symbol expr: expr & (rhs expr subst1: rhs symbol->(EVar of: symbol))
]

{ #category : #logic }
Reft >> pkvarConjuncts [
	"Peculiar to Smalltalk"
	| v ra ks ps ras1 |
	v := symbol.
	^expr refaConjuncts select: [ :p | p isKVar ] thenCollect:  [ :ra1 | Reft symbol: v expr: ra1 ]
]

{ #category : #logic }
Reft >> reftConjuncts [
"
reftConjuncts :: Reft -> [Reft]
cf. Types/Refinements.hs
"
	| v ra ks ps ras1 |
	v := symbol.
	ra := expr.
	ks := ra refaConjuncts select: [ :p | p isKVar "or: [ p isGradual ] BOGUS" ].
	ps := ra refaConjuncts reject: [ :p | p isKVar "or: [ p isGradual ] BOGUS" ].
	ras1 := ps isEmpty 
		ifTrue: [ ks ]
		ifFalse: [ {Bool and: ps}, ks ].
	^ras1 collect: [ :ra1 | Reft symbol: v expr: ra1 ]
]

{ #category : #logic }
Reft >> shiftR: i [ 
	^self shiftVV: (symbol intSymbol: i)
]

{ #category : #logic }
Reft >> shiftVV: newSymbol [
"
shiftVV :: Reft -> Symbol -> Reft
Cf. Constraints.hs
"
	| newExpr |
	symbol = newSymbol ifTrue: [ ^self ].
	newExpr := self expr subst1: symbol -> (EVar of: newSymbol).
	^Reft symbol: newSymbol expr: newExpr
]

{ #category : #'SMT interface' }
Reft >> smt2: γ [
	^Reft
		symbol: symbol
		expr: (expr smt2: γ)
]

{ #category : #'F.Subable' }
Reft >> subst: θ [
	^Reft
		symbol: symbol
		expr: (expr subst: θ exceptAll: {symbol})
]

{ #category : #accessing }
Reft >> symbol [
	^ symbol
]

{ #category : #accessing }
Reft >> symbol: anObject [
	symbol := anObject
]
