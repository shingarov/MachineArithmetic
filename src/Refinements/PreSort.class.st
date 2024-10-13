"
I am the superclass of all brain-damaged Sorts which are not Z3Sorts.

Cf. Sorts.hs:
--------------------------------------------------------------------------------
-- | Sorts ---------------------------------------------------------------------
--------------------------------------------------------------------------------
data Sort = FInt
          | FReal
          | FNum                 -- ^ numeric kind for Num tyvars
          | FFrac                -- ^ numeric kind for Fractional tyvars
          | FObj  !Symbol        -- ^ uninterpreted type
          | FVar  !Int           -- ^ fixpoint type variable
          | FFunc !Sort !Sort    -- ^ function
          | FAbs  !Int !Sort     -- ^ type-abstraction
          | FTC   !FTycon
          | FApp  !Sort !Sort    -- ^ constructed type
            deriving (Eq, Ord, Show, Data, Typeable, Generic)
"
Class {
	#name : #PreSort,
	#superclass : #Object,
	#category : #Refinements
}

{ #category : #hotel }
PreSort class >> guestInRoom: j [
	"If room j in the Sort Hotel is occupied, answer the guest.
	 If there is no room j (aka it's empty), answer nil."
	^self hotel at: j ifAbsent: [ nil ]
]

{ #category : #hotel }
PreSort class >> hotel [
	^Context readState: #hotel
]

{ #category : #comparing }
PreSort >> = rhs [
	self subclassResponsibility 
]

{ #category : #'sort algebra' }
PreSort >> @ j [ 
	^FAbs int: j sort: self
]

{ #category : #visiting }
PreSort >> accept: aVisitor [ 
	^self
]

{ #category : #yondea }
PreSort >> apply: θ [ 
	^self
]

{ #category : #'sort algebra' }
PreSort >> checkFunSort [
	"cf. SortCheck.hs"
	self error: 'NonFunction'
]

{ #category : #'sort algebra' }
PreSort >> containsFVar [
	^self subclassResponsibility
]

{ #category : #'as yet unclassified' }
PreSort >> fApp: argSorts [
	"Same as in Z3Sort."
	^argSorts inject: self into: [ :x :y | FApp s: x t: y ]
]

{ #category : #'as yet unclassified' }
PreSort >> functionSort [
"
functionSort :: Sort -> Maybe ([Int], [Sort], Sort)
"
	| is_ss_r |
	is_ss_r := self goFunctionSort: #() _: #().
	(is_ss_r first isEmpty and: [ is_ss_r second isEmpty ]) ifTrue: [ ^nil ].
	^is_ss_r
]

{ #category : #'as yet unclassified' }
PreSort >> goFunctionSort: vs _: ss [
"
go vs ss t             = (reverse vs, reverse ss, t)
"
	^{ vs reversed . ss reversed . self }
]

{ #category : #'as yet unclassified' }
PreSort >> goMapSort: stepBlock [
	^self
]

{ #category : #hotel }
PreSort >> guest [
	^self
]

{ #category : #comparing }
PreSort >> hash [
	self subclassResponsibility
]

{ #category : #'as yet unclassified' }
PreSort >> instantiate [
"
instantiate :: Sort -> CheckM Sort
Cf. SortCheck.hs
"
	^self
]

{ #category : #'sort algebra' }
PreSort >> isMono [
"
In LH this goes through the much-more-general foldSort.
"
	^self containsFVar not
]

{ #category : #'as yet unclassified' }
PreSort >> mapSort: f [
"
mapSort :: (Sort -> Sort) -> Sort -> Sort
cf. Visitor.hs
"
	^self stepMapSort: f
]

{ #category : #'sort algebra' }
PreSort >> mkConst: name [
	"This is needed because the receiver may have already
	 distilled down to a Z3 sort; then we need a Z3 const,
	 not an EVar."
	^EVar of: name
]

{ #category : #'as yet unclassified' }
PreSort >> mkZ3const: sym [ 
	^self z3sort mkConst: sym
]

{ #category : #substitution }
PreSort >> sortSubst: θ [
"
------------------------------------------------------------------------
sortSubst                 :: SortSubst -> Sort -> Sort
------------------------------------------------------------------------
sortSubst θ t@(FObj x)    = fromMaybe t (M.lookup x θ)
sortSubst θ (FFunc t1 t2) = FFunc (sortSubst θ t1) (sortSubst θ t2)
sortSubst θ (FApp t1 t2)  = FApp  (sortSubst θ t1) (sortSubst θ t2)
sortSubst θ (FAbs i t)    = FAbs i (sortSubst θ t)
sortSubst _  t            = t
"
	self subclassResponsibility 
]

{ #category : #'as yet unclassified' }
PreSort >> stepMapSort: f [
"cf. Visitor.hs"
	^(f value: self) goMapSort: [ :x | x stepMapSort: f ]
]

{ #category : #substitution }
PreSort >> subst: j _: tj [
"
subst :: Int -> Sort -> Sort -> Sort
"
	self subclassResponsibility
]

{ #category : #'sort algebra' }
PreSort >> trueSortedReft [
	"Same as Z3Sort."
	^SortedReft 
		sort: self
		reft: (Reft expr: (DecidableRefinement always))
]

{ #category : #'sort algebra' }
PreSort >> unFApp [
"
unFApp :: Sort -> ListNE Sort
"
	^self unFAppGo: #()
]

{ #category : #'sort algebra' }
PreSort >> unFAppGo: acc [
"
unFApp = go []
  where
    go acc (FApp t1 t2) = go (t2 : acc) t1
    go acc t            = t : acc  ← we are here
Cf. Sorts.hs
"
	^{self}, acc
]

{ #category : #'as yet unclassified' }
PreSort >> uncurriedZ3sig [
	^#() -> self z3sort
]

{ #category : #'sort algebra' }
PreSort >> unify: t2 env: f fast: isFast [
"
Fast Unification; `unifyFast True` is just equality.
FIXME: code duplication with Z3Sort.
"
	isFast ifFalse: [ ^Z3Sort unify: f maybeExpr: nil sort: self sort: t2 ].
	^self = t2 guest
		ifTrue: [TVSubst new]
		ifFalse: [nil]
]

{ #category : #'sort algebra' }
PreSort >> unifyVar: f maybeExpr: e tvSubst: θ int: i [
	"TODO: duplication with Z3Sort"
	(θ lookupVar: i)
		ifNil: [ ^θ updateVar: i _: self ]
		ifNotNil: [ :t_ | ^self shouldBeImplemented  ]
]

{ #category : #accessing }
PreSort >> value: arg [
	self subclassResponsibility
]

{ #category : #hotel }
PreSort >> z3sort [
	"This is essentially smt2Sort from Serialize.hs,
	 but somewhat different from how this works in LH.

	 SMT-LIB v2.6 (https://smt-lib.org/papers/smt-lib-reference-v2.6-r2017-07-18.pdf)
	 adds algebraic datatypes.  Section 4.2.3 says:
	 (declare-datatypes ((δ₁ k₁) … (δₙ kₙ)) (d₁ … dₙ)) with n>0 introduces
	 n algebraic datatypes δ₁,…,δₙ with respective arities k₁,…,kₙ and
	 declarations d₁,…,dₙ.
	 Let δ=δᵢ, k=kᵢ and d=dᵢ for i∈{1,…,n}.
	 If k>0 then d is an expression of the form (par (u₁ … uₖ) l) where u₁,…,uₖ
	 are sort parameters.
	
	 This means that SMTLIB's <declare-datatypes> is polymorphic;
	 see basic_cmds.cpp in Z3:
	   <declare-datatypes> ::= (<symbol>*) (<datatype-declaration>+)
	   <datatype-declaration> ::= (<symbol> <constructor-decl>+)
	   <constructor-decl> ::= (<symbol> <accessor-decl>*)
	   <accessor-decl> ::= (<symbol> <sort>)
	 It is then instantiate_datatype() in pdecl.cpp who instantiates
	 monomorphic datatypes such as (List int).

	 In Smalltalk we use the Z3DatatypeSort C API where fields are
	 monomorphic; so we don't have the distinction between 'declaring sorts'
	 (i.e. 'declare-datatypes ((List 1))…) and 'using instantiated sorts
	 when declaring variables' (i.e. 'declare-fun a () (List int)')
	 switched by the 'poly' parameter to sortSmtSort (cf. Theories.hs).
	 In other words, because the Z3 C API doesn't have 'macros', we are
	 forced to do instantiate_datatype()'s work in Smalltalk."

	^self subclassResponsibility
]
