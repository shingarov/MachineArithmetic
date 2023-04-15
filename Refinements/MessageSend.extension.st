Extension { #name : #MessageSend }

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
		receiver: (self receiver elabApplyStep: γ)
		selector: self selector
		arguments: (self arguments collect: [ :eachArg | eachArg elabApplyStep: γ ] )
]
