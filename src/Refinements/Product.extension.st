Extension { #name : #Product }

{ #category : #'*Refinements' }
Product >> inventFormalArgumentsFor: functor [ 
	^self asArray collectWithIndex: [ :argSort :j | ('nnf_argºº', functor intSymbol: j-1) -> argSort ]
]
