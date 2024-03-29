Extension { #name : #Integer }

{ #category : #'*Refinements' }
Integer >> elab: anElabEnv [
	^self toInt elab: anElabEnv
]

{ #category : #'*Refinements' }
Integer >> evaluateIn: anEvalEnv ifUndeclared: vndBlock [
	^self toInt
]

{ #category : #'*Refinements' }
Integer >> smt2: _ [
	^self toInt
]

{ #category : #'*Refinements' }
Integer >> toFVar [
	^FVar new: self
]

{ #category : #'*Refinements' }
Integer >> vv [ 
"Cf. Types/Names.hs
42 vv >>> 'VVºº42'
"
	^String vvName intSymbol: self
]
