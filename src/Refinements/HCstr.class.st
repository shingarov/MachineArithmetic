"
Refinement type checking will produce Floyd-Hoare VC constraints.
These are NNF Horn constraints.
A constraint is either:
  - a quantifier-free predicate, p;
  - a universally-quantified implication, ∀x:b. p ⇒ c;
  - a conjunction of constraints, c1 ∧ c2.

In Haskell (cf. Horn/Types.hs):
data Cstr a
  = Head  !Pred a               -- ^ p
  | CAnd  ![(Cstr a)]           -- ^ c1 ∧ ... ∧ cn
  | All   !Bind  !(Cstr a)      -- ^ ∀x:t. p ⇒ c
  | Any   !Bind  !(Cstr a)      -- ^ ∃x:t. p ∧ c or is it ∃x:t. p ⇒ c?
  deriving (Data, Typeable, Generic, Functor, Eq)

The validity of constraint c is determined by flattening c into

ci ≐ ∀xyz. pi ⇒ qi

which in Z3 is valid iff pi∧¬qi is UNSAT.
"
Class {
	#name : #HCstr,
	#superclass : #HThing,
	#category : #Refinements
}

{ #category : #'instance creation' }
HCstr class >> cTrue [
	^CstrAnd of: #()
]

{ #category : #'as yet unclassified' }
HCstr class >> flatten: cstrs [
"
instance Flatten [Cstr a] where
	...
cf. Transformations.hs
"
	self shouldBeImplemented
]

{ #category : #monoid }
HCstr >> & anotherCstr [ 
	^CstrAnd of: { self . anotherCstr }
]

{ #category : #logic }
HCstr >> addToQuery: aNNFQuery [ 
	aNNFQuery qCstr add: self
]

{ #category : #logic }
HCstr >> boundKVars [
"
boundKvars :: Cstr a -> S.Set F.Symbol
"
	self subclassResponsibility
]

{ #category : #'as yet unclassified' }
HCstr >> demorgan: x t: t kvars: kvars preds: preds bss: bss [
	| suki su cubeSols |
	"first compute the Subst; bss isn't needed for this"
	suki := kvars >>= [ :k_xs |
			| k xs |
			k := k_xs key.
			xs := k_xs value.
			k oneSuka: xs ] .
	su := Subst mkSubst: suki.
	cubeSols := bss collect: [ :ass | ass cubeSol_x: x t: t su: su preds: preds c: self ].
	^CstrAnd of: cubeSols
]

{ #category : #logic }
HCstr >> doElim: bss var: k [
"
doelim :: F.Symbol -> [([Bind], [F.Expr])] -> Cstr a -> Cstr a
cf. Horn/Transformations.hs
"
	self subclassResponsibility
]

{ #category : #'as yet unclassified' }
HCstr >> elim [
	| res |
	res := self boundKVars inject: self into: [ :c :k | c elim1: k ].
	res boundKVars isEmpty ifFalse: [ CyclicConstraint signal ].
	^res
]

{ #category : #'as yet unclassified' }
HCstr >> elim1: κ [
	"ICFP'17 26:20.
	By Theorem 5.9 (Elim-Preserves-Satisfiability), c elim1: κ
	is satisfiable iff c is satisfiable.
	
	Find a `sol1` solution to a kvar κ,
	and then subsitute in the solution for each rhs occurrence of κ.
	cf. Horn/Transformations.hs"
	| scope sol |
	scope := self scope: κ.
	sol := scope sol1: κ.
	^(self doElim: sol var: κ) simplify
]

{ #category : #logic }
HCstr >> flatten [
	"Remove redundant `and`s and empty conjuncts."
	self subclassResponsibility
]

{ #category : #logic }
HCstr >> goScope: k [
	self subclassResponsibility
]

{ #category : #'as yet unclassified' }
HCstr >> goS′: aCollection _: anIBindEnv _: aSortedReft _: aBindEnv [
	"goS' :: KVEnv a -> F.IBindEnv -> F.SortedReft -> F.BindEnv -> H.Cstr a
    -> (F.BindEnv, [Either F.BindId (F.SubC a)])
	cf. various forms of goS' in Horn/Info.hs"
	self subclassResponsibility 
]

{ #category : #GT }
HCstr >> gtInspectorShowIn: composite [
	<gtInspectorPresentationOrder: 51>
	^ composite text
		title: 'Show';
		display: [ self ppString ]
]

{ #category : #GT }
HCstr >> gtInspectorTreeIn: composite [
	<gtInspectorPresentationOrder: 50>
	^ composite fastTree
		title: 'Tree';
		children: #children;
		display: [ Array with: self ]
]

{ #category : #logic }
HCstr >> isNNF [
	"Answer whether the constraint does not contain any existential binders."
	self 
]

{ #category : #printing }
HCstr >> ppOn: aStream indent: n [
	self subclassResponsibility
]

{ #category : #printing }
HCstr >> ppString [
	| s |
	s := WriteStream on: String new.
	self ppOn: s indent: 0.
	^s contents
]

{ #category : #transformations }
HCstr >> pruneTauts [
	^self pruneTautsGo ifNil: [ CstrAnd of: #() ]
]

{ #category : #'α-renaming' }
HCstr >> rename: a to: b [
	self subclassResponsibility
]

{ #category : #transformations }
HCstr >> scope: k [
"
scope :: F.Symbol -> Cstr a -> Cstr a
"
 ^(self goScope: k)
		left: [ :l | ^CstrHead pred: HReft shouldBeImplemented ]
		right: [ :c | ^c ]
]

{ #category : #logic }
HCstr >> simplify [
	"Cleanup Horn constraint.
	We want to simplify the Query a little bit, and make sure it is Horn,
	that is, only a kvar-free (ie concrete) predicate or a single kvar in each head."
	^ self flatten pruneTauts "removeDuplicateBinders" "BOGUS"
]

{ #category : #logic }
HCstr >> sol1: k [
"
sol1 :: F.Symbol -> Cstr a -> [([Bind], [F.Expr])]
"
	self subclassResponsibility
]

{ #category : #'as yet unclassified' }
HCstr >> solve [
	^(HornQuery fromThings: {self}) solve
]

{ #category : #'as yet unclassified' }
HCstr >> solveWithHornVars: ks [ 
	^(HornQuery fromThings: {self}, ks) solve
]

{ #category : #logic }
HCstr >> toHCstr [
	^self
]

{ #category : #logic }
HCstr >> uniq1 [
	"Make sure each binder has a unique name.
	 cf. Horn/Transformations.hs"
	^self uniq1: AlphaRenamer new
]

{ #category : #logic }
HCstr >> uniq1: anAlphaRenamer [ 
	self subclassResponsibility 
]
