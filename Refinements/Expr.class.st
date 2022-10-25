Class {
	#name : #Expr,
	#superclass : #Object,
	#category : #Refinements
}

{ #category : #'as yet unclassified' }
Expr >> elab: anElabEnv [
"
elab :: ElabEnv -> Expr -> CheckM (Expr, Sort)
"
	self subclassResponsibility
]

{ #category : #'as yet unclassified' }
Expr >> elabExpr: aSymEnv [ 
	^self elabExprE: aSymEnv
]

{ #category : #'as yet unclassified' }
Expr >> elabExprE: aSymEnv [
	| sEnv f |
	sEnv := aSymEnv sort.
	f := [ :s | sEnv lookupSEnvWithDistance: s ].
	^[(self elab: (ElabEnv symEnv: aSymEnv env: f) ) first] runWithIncrementingIntegers
]
