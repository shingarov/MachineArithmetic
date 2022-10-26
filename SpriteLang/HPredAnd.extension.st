Extension { #name : #HPredAnd }

{ #category : #'*SpriteLang' }
HPredAnd >> cHead [
	| nonTrivialConjuncts |
	nonTrivialConjuncts := conjuncts reject: #isTauto.
	nonTrivialConjuncts isEmpty ifTrue: [ ^HCstr cTrue ].
	nonTrivialConjuncts size = 1 ifTrue: [ ^CstrHead pred: nonTrivialConjuncts anyOne ].
	^HCstr mkHead: (HPredAnd of: nonTrivialConjuncts)  "qs  -> mkHead l (H.PAnd qs)"
]

{ #category : #'*SpriteLang' }
HPredAnd >> smash [
"
smash (H.PAnd ps) = concatMap smash ps
"
	^conjuncts collectAndCat: #smash
]
