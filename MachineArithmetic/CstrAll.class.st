Class {
	#name : #CstrAll,
	#superclass : #CstrQuantifier,
	#category : #'MachineArithmetic-Refinement'
}

{ #category : #logic }
CstrAll >> goS1: kve _: env _: __ _: be [
	| bSR be1_bId env1 |
	bSR := HornQuery bindSortedReft_kve: kve bind: self bind.
	be1_bId := be insertVar: bind x sort: bSR.
	env1 := env insert: be1_bId value.
	^self p goS1: kve _: env1 _: bSR _: be1_bId key
]

{ #category : #logic }
CstrAll >> isNNF [ 
	^ self p isNNF
]

{ #category : #accessing }
CstrAll >> tagName [
	^ 'forall'
]
