Extension { #name : #Subst }

{ #category : #'*MachineArithmetic' }
Subst >> applyTo: aZ3AST [ 
	self isEmpty ifTrue: [^aZ3AST].
	^aZ3AST inEnvironment: self
]
