Class {
	#name : #CstrAny,
	#superclass : #CstrQuantifier,
	#category : #Refinements
}

{ #category : #'as yet unclassified' }
CstrAny >> goS1: kve _: env _: lhs _: be [
	| bSR bId_be1 env1 |
	bSR := HornQuery bindSortedReft_kve: kve bind: bind. "FIXME refactor to HBind>>bindSortedReft:kve"
	bId_be1 := be insertVar: bind x sort: bSR.
	env1 := env insert: bId_be1 key.
	self shouldBeImplemented
]

{ #category : #logic }
CstrAny >> isNNF [ 
	^ false
]

{ #category : #printing }
CstrAny >> mathSymbol [
	^Character value: 16r2203
]
