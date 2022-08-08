Extension { #name : #Bool }

{ #category : #'*Refinements' }
Bool >> isKVar [
	^false
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
