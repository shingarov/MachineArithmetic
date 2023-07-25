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

{ #category : #'instance creation' }
HPred class >> new [
"
instance Monoid Pred where
  mempty = Reft mempty
"
	^HReft expr: Expr new
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

{ #category : #transformations }
HPred >> cHead [
	^CstrHead pred: self
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

{ #category : #comparing }
HPred >> hash [
"
deriving Eq
"
	self subclassResponsibility
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

{ #category : #'F.Subable' }
HPred >> subst1: su [
	self subclassResponsibility
]

{ #category : #'F.Subable' }
HPred >> subst: su [
	self subclassResponsibility
]

{ #category : #transformations }
HPred >> substPred: su [
"
substPred :: M.HashMap F.Symbol F.Symbol -> Pred -> Pred
"
	self subclassResponsibility
]

{ #category : #'F.Subable' }
HPred >> substa: f [
	self subclassResponsibility
]

{ #category : #'F.Subable' }
HPred >> substf: f [
	self subclassResponsibility
]

{ #category : #'F.Subable' }
HPred >> syms [
	self subclassResponsibility
]
