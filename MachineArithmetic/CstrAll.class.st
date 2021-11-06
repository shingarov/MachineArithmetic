Class {
	#name : #CstrAll,
	#superclass : #CstrQuantifier,
	#category : #'MachineArithmetic-Refinement'
}

{ #category : #'as yet unclassified' }
CstrAll >> doElim: bss var: k [
	"bss is a Hyp, that tells us the solution to a Var, that is, a collection of cubes that we'll want to disjunct"
	| x t pp c found |
	x := bind x. t := bind τ. pp := bind p.
	c := p.
	found := pp findKVarInGuard: k.
	found
		left: [ :zzz | ^self shouldBeImplemented ]
		right: [ :_p | ^CstrAll bind: bind p: (c doElim: bss var: k) ]
]

{ #category : #logic }
CstrAll >> goS1: kve _: env _: __ _: be [
	| bSR be1_bId env1 |
	bSR := HornQuery bindSortedReft_kve: kve bind: self bind.
	be1_bId := be insertVar: bind x sort: bSR.
	env1 := env insert: be1_bId value.
	^self p goS1: kve _: env1 _: bSR _: be1_bId key
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

{ #category : #printing }
CstrAll >> mathSymbol [
	^Character value: 16r2200
]
