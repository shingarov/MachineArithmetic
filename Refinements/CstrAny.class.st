Class {
	#name : #CstrAny,
	#superclass : #CstrQuantifier,
	#category : #Refinements
}

{ #category : #logic }
CstrAny >> goS1: kve _: env _: lhs _: be [
	| bSR bId_be1 bId be1 env1 be2_subcs be2 subcs |
	bSR := HornQuery bindSortedReft_kve: kve bind: bind.
	bId_be1 := be insertVar: bind x sort: bSR.
	bId := bId_be1 key.
	be1 := bId_be1 value.
	env1 := env insert: bId.
	be2_subcs := p goS1: kve _: env1 _: bSR _: be1.
	be2 := be2_subcs key.
	subcs := be2_subcs value.
	^be2 -> ({ Either left: bId }, subcs)
]

{ #category : #logic }
CstrAny >> goScope: k [
	self shouldNotImplement "any should not appear after poke"
]

{ #category : #logic }
CstrAny >> isNNF [ 
	^ false
]

{ #category : #printing }
CstrAny >> mathSymbol [
	^Character value: 16r2203
]
