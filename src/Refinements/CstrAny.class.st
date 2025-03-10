Class {
	#name : #CstrAny,
	#superclass : #CstrQuantifier,
	#category : #'Refinements-Horn'
}

{ #category : #logic }
CstrAny >> goScope: k [
	self shouldNotImplement "any should not appear after poke"
]

{ #category : #logic }
CstrAny >> goS′: kve _: env _: lhs _: be [
	| bSR bId_be′ bId be′ env′ be2_subcs be2 subcs |
	bSR := HornQuery bindSortedReft_kve: kve bind: bind.
	bId_be′ := be insertBindEnv: bind x sortedReft: bSR.
	bId := bId_be′ key.
	be′ := bId_be′ value.
	env′ := env insert: bId.
	be2_subcs := p goS′: kve _: env′ _: bSR _: be′.
	be2 := be2_subcs key.
	subcs := be2_subcs value.
	^be2 -> ({ Either left: bId }, subcs)
]

{ #category : #logic }
CstrAny >> isNNF [ 
	^ false
]

{ #category : #printing }
CstrAny >> mathSymbol [
	^Character value: 16r2203
]

{ #category : #logic }
CstrAny >> sol1: _ [
	self shouldNotImplement "ebinds don't work with old elim"
]
