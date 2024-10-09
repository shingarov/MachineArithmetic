Extension { #name : #Z3AST }

{ #category : #'*Refinements' }
Z3AST >> elabApply: _ [ 
	^self
]

{ #category : #'*Refinements' }
Z3AST >> elaborate: aSymEnv [
	"I am already a Z3 AST — can't get more concrete than that."
	^self
]

{ #category : #'*Refinements' }
Z3AST >> evaluateIn: aBindEnv ifUndeclared: vndBlock [
	^self "already compiled"
]

{ #category : #'*Refinements' }
Z3AST >> smt2 [
	^self
]
