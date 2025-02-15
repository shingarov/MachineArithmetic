Extension { #name : #Bool }

{ #category : #'*Refinements' }
Bool class >> conj: ps [
"
-- | 'conj' is a fast version of 'pAnd' needed for the ebind tests
conj :: [Pred] -> Pred
conj []  = PFalse
conj [p] = p
conj ps  = PAnd ps
  
-- | [NOTE: pAnd-SLOW] 'pAnd' and 'pOr' are super slow as they go inside the predicates;
--   so they SHOULD NOT be used inside the solver loop. Instead, use 'conj' which ensures
--   some basic things but is faster.
"
	"BOGUS: horrible pösmös of Z3 bools and Expr predicates."
	ps isEmpty ifTrue: [ ^Bool false ].
	ps size = 1 ifTrue: [ ^ps anyOne ].
	^Bool and: ps
]

{ #category : #'*Refinements' }
Bool >> conjuncts [
	^{self}
]

{ #category : #'*Refinements' }
Bool >> isConc [
	^true
]

{ #category : #'*Refinements' }
Bool >> isKVar [
	^false
]

{ #category : #'*Refinements' }
Bool >> isSingletonExpr: v in: env [
	^self singletonExpr: v
]

{ #category : #'*Refinements' }
Bool >> isTautoPred [
	^self simplify = Bool true
	
]

{ #category : #'*Refinements' }
Bool >> predKs [
	^#()
]

{ #category : #'*Refinements' }
Bool >> refaConjuncts [
	^{self}
]

{ #category : #'*Refinements' }
Bool >> toHCstr [
	"Convert the receiver to a fully-resolved (from Smalltalk compilation perspective) Horn Constraint."
	^(ResolvedPredicate z3bool: self) cHead
]

{ #category : #'*Refinements' }
Bool class >> tyCon [
	^FTyconBool new
]
