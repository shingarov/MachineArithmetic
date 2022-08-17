Extension { #name : #Z3FuncDecl }

{ #category : #'*Refinements' }
Z3FuncDecl >> addToQuery: q [ 
	q vars add: self

]

{ #category : #'*Refinements' }
Z3FuncDecl >> formalArguments [
	"Cf. HVar>>formalArguments.
	 Someone please do something about the code duplication."
	^self domain toProduct inventFormalArgumentsFor: self name

]
