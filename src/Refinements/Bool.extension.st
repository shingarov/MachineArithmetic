Extension { #name : #Bool }

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
