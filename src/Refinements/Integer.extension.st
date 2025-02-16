Extension { #name : #Integer }

{ #category : #'*Refinements' }
Integer >> checkExpr: γ [
	^self toInt checkExpr: γ
]

{ #category : #'*Refinements' }
Integer >> elab: anElabEnv [
	^self toInt elab: anElabEnv
]

{ #category : #'*Refinements' }
Integer >> elabAs: t inElabEnv: γ [
	^self toInt elabAs: t inElabEnv: γ
]

{ #category : #'*Refinements' }
Integer >> evaluateIn: anEvalEnv ifUndeclared: vndBlock [
	^self toInt
]

{ #category : #'*Refinements' }
Integer >> mkVV [
"
mkVV :: Maybe Integer -> Symbol
"
	^self vv
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
