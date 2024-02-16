Extension { #name : #Boolean }

{ #category : #'*Refinements' }
Boolean >> accept: aVisitor [
	^self
]

{ #category : #'*Refinements' }
Boolean >> elab: anElabEnv [
	^self toBool elab: anElabEnv
]
