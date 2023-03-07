"
A Horn predicate that appears as LHS (body) or RHS (head) of constraints.

This can either be
- a refinement from a decidable logic: r; or
- a refinement variable application: kappa(arg1,...); or
- a conjunction of sub-predicates.
"
Class {
	#name : #HPred,
	#superclass : #Expr,
	#category : #Refinements
}

{ #category : #'as yet unclassified' }
HPred >> & anotherPred [ 
	^HPredAnd of: { self . anotherPred }
]

{ #category : #'as yet unclassified' }
HPred >> , anotherPred [
"
instance Semigroup Pred where
  p1 <> p2 = PAnd [p1, p2]
"
	^HPredAnd of: { self . anotherPred }
]

{ #category : #comparing }
HPred >> = another [
	self subclassResponsibility
]

{ #category : #visiting }
HPred >> accept: aVisitor [
	self subclassResponsibility
]

{ #category : #'as yet unclassified' }
HPred >> cHead [
	^CstrHead pred: self "TODO: investigate moving to Sprite"
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
HPred >> conjuncts [
	^{self}
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

{ #category : #logic }
HPred >> findKVarInGuard: k [ 
	^Either right: self
]

{ #category : #logic }
HPred >> flatConstraint [
	^self
]

{ #category : #Transformations }
HPred >> flatten [
	^self
]

{ #category : #'as yet unclassified' }
HPred >> hasKVars [
	self shouldBeImplemented.
]

{ #category : #comparing }
HPred >> hash [
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
HPred >> isTautoPred [
	"BOGUS"
	^false
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

{ #category : #logic }
HPred >> pKVars [
	^ Set new
]

{ #category : #logic }
HPred >> predExpr: kvEnv [ 
	^self 
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

{ #category : #'F.Subable' }
HPred >> substPred: aCollection [ 
	self shouldBeImplemented.
]

{ #category : #logic }
HPred >> toHCstr [
	^self cHead
]

{ #category : #'well-formedness' }
HPred >> wfIn: gamma [ 
self shouldBeImplemented
]
