Extension { #name : #FormalSendResult }

{ #category : #'*SpriteLang' }
FormalSendResult >> isRVarApp: anEvalEnv whichCameFrom: unevaluated [
	^(message selector beginsWith: #value)
		ifTrue: [ (message sendTo: receiver) isRVarApp: anEvalEnv whichCameFrom: unevaluated ]
		ifFalse: [ super isRVarApp: anEvalEnv whichCameFrom: unevaluated ]

]
