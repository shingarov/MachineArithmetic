Class {
	#name : #CstrAll,
	#superclass : #CstrQuantifier,
	#category : #Refinements
}

{ #category : #'as yet unclassified' }
CstrAll >> doElim: bss var: k [
	"bss is a Hyp, that tells us the solution to a Var, that is, a collection of cubes that we'll want to disjunct"
	| x t pp c found |
	x := bind x. t := bind τ. pp := bind p.
	c := p.
	found := pp findKVarInGuard: k.
	found
		left: [ :kvars_preds | ^(c doElim: bss var: k) demorgan: x t: t kvars: kvars_preds key preds: kvars_preds value bss: bss ]
		right: [ :_p | ^CstrAll bind: bind p: (c doElim: bss var: k) ]
]

{ #category : #logic }
CstrAll >> goS1: kve _: env _: __ _: be [
	| bSR bId_be1 bId be1 env1 |
	bSR := HornQuery bindSortedReft_kve: kve bind: bind.
	bId_be1 := be insertVar: bind x sort: bSR.
	bId := bId_be1 key.
	be1 := bId_be1 value.
	env1 := env insert: bId.
	^self p goS1: kve _: env1 _: bSR _: be1
]

{ #category : #'as yet unclassified' }
CstrAll >> goScope: k [
	| pred c1 |
	c1 := p.
	pred := bind p.
	^(pred pKVars includes: k)
		ifTrue: [ Either right: self ]
		ifFalse: [ c1 goScope: k ]
]

{ #category : #logic }
CstrAll >> isNNF [ 
	^ self p isNNF
]

{ #category : #'as yet unclassified' }
CstrAll >> isTauto [
	^p isTauto
]

{ #category : #printing }
CstrAll >> mathSymbol [
	^Character value: 16r2200
]

{ #category : #'as yet unclassified' }
CstrAll >> rename: a to: b renamer: α [
	^CstrAll
		bind: (HBind x: (bind x = a ifTrue: [b] ifFalse: [bind x]) τ: bind τ p: (bind p rename: a to: b renamer: α))
		p: (p rename: a to: b renamer: α)
]

{ #category : #'as yet unclassified' }
CstrAll >> sol1: k [
	| b c coll |
	b := bind.
	c := p.
	coll := c sol1: k.
	^coll collect: [ :elem |
			| bs eqs |
			bs := elem key.
			eqs := elem value.
			{b.}, bs -> eqs ]
]
