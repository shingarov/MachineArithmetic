Extension { #name : #Boolean }

{ #category : #'*PreSmalltalks' }
Boolean class >> and: conjuncts [
	^conjuncts allSatisfy: #yourself
]

{ #category : #'*PreSmalltalks' }
Boolean class >> or: disjuncts [
	^disjuncts anySatisfy: #yourself
]
