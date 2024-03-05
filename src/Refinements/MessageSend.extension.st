Extension { #name : #MessageSend }

{ #category : #'*Refinements' }
MessageSend >> accept: aVisitor [
	^self class
		receiver: (receiver accept: aVisitor)
		selector: selector
		arguments: (arguments collect: [ :eachArg | eachArg accept: aVisitor ])
]

{ #category : #'*Refinements' }
MessageSend >> elab: anElabEnv [
	| computed |
	computed := (receiver elab: anElabEnv) first
		perform: self selector
		withArguments: (arguments collect: [ :eachArg | (eachArg elab: anElabEnv) first ]).
	^{ computed . computed sort }
]

{ #category : #'*Refinements' }
MessageSend >> elabApply: γ [
	^MessageSend
		receiver: (self receiver elabApply: γ)
		selector: self selector
		arguments: (self arguments collect: [ :eachArg | eachArg elabApply: γ ])
]

{ #category : #'*Refinements' }
MessageSend >> elabApplyStep: γ [
	^MessageSend
		receiver: (self receiver elabApply: γ)
		selector: self selector
		arguments: (self arguments collect: [ :eachArg | eachArg elabApplyStep: γ ] )
]

{ #category : #'*Refinements' }
MessageSend >> evaluateIn: anEvalEnv [ 
	^(self receiver evaluateIn: anEvalEnv)
		perform: self selector
		withArguments: (arguments collect: [ :a | a evaluateIn: anEvalEnv ])
]
