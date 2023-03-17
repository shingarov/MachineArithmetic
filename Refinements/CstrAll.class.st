Class {
	#name : #CstrAll,
	#superclass : #CstrQuantifier,
	#category : #Refinements
}

{ #category : #logic }
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
"
goS' kve env _   be (H.All b c)  = (be'', subcs)
  where
    (be'', subcs)               = goS' kve env' bSR be' c
    (bId, be')                  = F.insertBindEnv (H.bSym b) bSR be
    bSR                         = bindSortedReft kve b
    env'                        = F.insertsIBindEnv [bId] env
"
	| bSR bId_be1 bId be1 env1 be2_subcs |
	bSR := bind bindSortedReft: kve.
	bId_be1 := be insertVar: bind x sort: bSR.
	bId := bId_be1 key.
	be1 := bId_be1 value.
	env1 := env insert: bId.
	bind p ensureFreeVarsIn: kve areKnownIn: be1. "destructive to be1"
	be2_subcs := p goS1: kve _: env1 _: bSR _: be1.
	^be2_subcs
]

{ #category : #logic }
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

{ #category : #printing }
CstrAll >> mathSymbol [
	^Character value: 16r2200
]

{ #category : #logic }
CstrAll >> pruneTautsGo [
"
go (All b c) = do
  c' <- go c
  pure (All b c')
"
	| c_ |
	c_ := p pruneTautsGo.
	^c_ ifNotNil: [ CstrAll bind: bind p: c_ ]
]

{ #category : #'α-renaming' }
CstrAll >> rename: a to: b [
	^CstrAll
		bind: (HBind x: (bind x = a ifTrue: [b] ifFalse: [bind x]) τ: bind τ p: (bind p rename: a to: b))
		p: (p rename: a to: b)
]

{ #category : #logic }
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
