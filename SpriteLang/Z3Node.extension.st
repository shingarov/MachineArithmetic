Extension { #name : #Z3Node }

{ #category : #'*SpriteLang' }
Z3Node >> isRVarApp: anEvalEnv whichCameFrom: unevaluated [
	self simplify isSymbolic ifTrue: [ self shouldBeInvestigated "I *think* this can never happen." ].
	^Either right: unevaluated "it can never come from an RVar"
]
