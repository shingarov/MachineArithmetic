"
A Horn predicate that appears as LHS (body) or RHS (head) of constraints.

This can either be
- a refinement from a decidable logic: r; or
- a refinement variable application: κ(y₁,...); or
- a conjunction of sub-predicates.

data Pred
  = Reft  !F.Expr                               -- ^ r 
  | Var   !F.Symbol ![F.Symbol]                 -- ^ $k(y₁,...yₙ) 
  | PAnd  ![Pred]                               -- ^ p₁ ∧ ... ∧ pₙ 
  deriving (Data, Typeable, Generic, Eq)

Caveat programmator: this is H.Pred from Horn/Types.hs,
NOT X.Pred from Types/Refinements.hs which is simply a type alias for Expr.
"
Class {
	#name : #HPred,
	#superclass : #Object,
	#category : #Refinements
}

{ #category : #'as yet unclassified' }
HPred >> & anotherPred [ 
	^HPredAnd of: { self . anotherPred }
]

{ #category : #Semigroup }
HPred >> , p2 [
"
instance Semigroup Pred where
  p1 <> p2 = PAnd [p1, p2]
"
	^HPredAnd of: { self . p2 }
]

{ #category : #comparing }
HPred >> = rhs [
"
deriving Eq
"
	self subclassResponsibility
]

{ #category : #visiting }
HPred >> accept: aVisitor [
	self subclassResponsibility
]

{ #category : #transformations }
HPred >> cHead [
	^CstrHead pred: self
]

{ #category : #'as yet unclassified' }
HPred >> check: γ [
	^self checkExpr: γ
]

{ #category : #'as yet unclassified' }
HPred >> checkExpr: γ [ 
	(self evaluateIn: (EvalEnv ofSorts: γ)) sort shouldBeImplemented 
]

{ #category : #GT }
HPred >> children [
	^#()
]

{ #category : #'as yet unclassified' }
HPred >> elab: anElabEnv [
	| evalEnv computed |
	evalEnv := EvalEnv ofSorts: anElabEnv senv sort.
	computed := self evaluateIn: evalEnv.
	^{ computed . computed sort }
]

{ #category : #'as yet unclassified' }
HPred >> ensureFreeVarsIn: kvEnv areKnownIn: be [
	"NOP"
]

{ #category : #'term rewriting' }
HPred >> evaluateIn: aBindEnv [ 
	self subclassResponsibility
]

{ #category : #transformations }
HPred >> findKVarInGuard: k [
"
findKVarInGuard :: F.Symbol -> Pred -> Either ([(F.Symbol, [F.Symbol])], [Pred]) Pred
Cf. Transformations.hs.
If k is in the guard, return a Left list of that k and the remaining preds in the guard.
If k is not in the guard, return a Right of the pred.
"
	^Either right: self
]

{ #category : #transformations }
HPred >> flatten [
	^self
]

{ #category : #'as yet unclassified' }
HPred >> hasKVars [
	self shouldBeImplemented.
]

{ #category : #comparing }
HPred >> hash [
"
deriving Eq
"
	self subclassResponsibility
]

{ #category : #'as yet unclassified' }
HPred >> isConc [
	"note: this should be combined with PKVar>>isConc"
	^self kvarsExpr isEmpty
]

{ #category : #'as yet unclassified' }
HPred >> isSingletonExpr: v [




	self shouldBeImplemented.
]

{ #category : #'as yet unclassified' }
HPred >> isSingletonExpr: v in: env [
"isSingletonExpr :: Symbol -> Expr -> Maybe Expr.
The selector is misleading, but let's keep it for now for consistency with LF.
NB: the returned expression isn't necessary an EVar, it can be any Z3 AST.
"
	| ast |
	ast := self evaluateIn: env.
	^ast singletonExpr: v
]

{ #category : #'as yet unclassified' }
HPred >> kvarsExpr [
	"BOGUS.  For now let's assume only literally RefVarApps have kappas."
	^#()
]

{ #category : #'as yet unclassified' }
HPred >> not [
	^HPredNot of: self
]

{ #category : #transformations }
HPred >> pKVars [
"
pKVars :: Pred -> S.Set F.Symbol
"
	^Set new
]

{ #category : #transformations }
HPred >> pruneTautsGoP [
	self subclassResponsibility
]

{ #category : #'as yet unclassified' }
HPred >> rename: a to: b [
	^DelayedSubst from: a toVar: b in: self
]

{ #category : #'F.Subable' }
HPred >> subst1: x_e [
	| x e |
	x := x_e key.  e := x_e value.
	^DelayedSubst from: x toExpr: e in: self
]

{ #category : #'F.Subable' }
HPred >> subst: aDictionary [
	^self subclassResponsibility 
]

{ #category : #transformations }
HPred >> substPred: su [
"
substPred :: M.HashMap F.Symbol F.Symbol -> Pred -> Pred
"
	self subclassResponsibility
]

{ #category : #logic }
HPred >> toHCstr [
	^self cHead
]

{ #category : #'well-formedness' }
HPred >> wfIn: gamma [ 
self shouldBeImplemented
]
