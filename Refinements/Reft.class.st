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

{ #category : #'instance creation' }
Reft class >> alwaysFalse [
	^self expr: (HPredAnd of: #()) not
]

{ #category : #'instance creation' }
Reft class >> alwaysTrue [
	^self expr: HPredAnd new
]

{ #category : #naming }
Reft class >> anonymousVarName [
	^VariableAlphabet freshVariableName
]

{ #category : #naming }
Reft class >> dummySymbol [
	^'VV'
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

{ #category : #semigroup }
Reft >> , anotherReft [
	"cf. meetReft"
	symbol = anotherReft symbol ifTrue: [ ^Reft symbol: symbol expr: expr, anotherReft expr ].
	symbol = Reft dummySymbol ifTrue: [ ^Reft symbol: anotherReft symbol expr: anotherReft expr & (expr subst1: symbol->(FxEVar of: anotherReft symbol)) ].
	^Reft symbol: symbol expr: expr & (anotherReft expr subst1: anotherReft symbol->(FxEVar of: symbol))
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

{ #category : #'as yet unclassified' }
Reft >> isConc [
	^expr isConc
]

{ #category : #logic }
Reft >> isTauto [
	self shouldBeImplemented
]

{ #category : #printing }
Reft >> printBracketedOn: aStream [
	aStream
			nextPutAll: '[';
			nextPutAll: (self symbol isNil ifTrue: ['_'] ifFalse: [symbol]);
			nextPutAll: '|'.
	expr printOn: aStream.
	aStream nextPutAll: ']'.
]

{ #category : #printing }
Reft >> printOn: aStream [
	aStream nextPutAll: 'Reft'.
	self printBracketedOn: aStream
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
	newExpr := self expr subst1: symbol -> (FxEVar of: newSymbol).
	^Reft symbol: newSymbol expr: newExpr
]

{ #category : #accessing }
Reft >> symbol [
	^ symbol
]

{ #category : #accessing }
Reft >> symbol: anObject [
	symbol := anObject
]
