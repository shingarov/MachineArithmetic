Extension { #name : #MessageSend }

{ #category : #'*Refinements' }
MessageSend >> elab: anElabEnv [
	| computed |
	computed := (receiver elab: anElabEnv) first
		perform: self selector
		withArguments: (arguments collect: [ :eachArg | (eachArg elab: anElabEnv) first ]).
	^{ computed . computed sort }
]
