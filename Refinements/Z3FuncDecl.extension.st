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

{ #category : #'*Refinements' }
Z3FuncDecl >> mkConst: aString [
	"TODO: Investigate the relationship between Z3FuncDecl and sorts:
	 there seems to be some kind of confusion between a homset and its member.
	
	The whole existence of this method is probably bogus, as FuncDecl is not a sort."
	^self withName: aString
]
