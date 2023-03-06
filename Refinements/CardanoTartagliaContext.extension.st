Extension { #name : #CardanoTartagliaContext }

{ #category : #'*Refinements' }
CardanoTartagliaContext class >> ofSortedVariables: aDictionary [
	| ctx |
	ctx := self basicNew.
	aDictionary keysAndValuesDo: [ :var :sort |
		ctx tempNamed: var put: (sort mkConst: var) ].
	^ctx
]
