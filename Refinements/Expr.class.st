Class {
	#name : #Expr,
	#superclass : #Object,
	#category : #Refinements
}

{ #category : #elaboration }
Expr >> elab: anElabEnv [
"
elab :: ElabEnv -> Expr -> CheckM (Expr, Sort)
"
	self subclassResponsibility
]

{ #category : #elaboration }
Expr >> elabExpr: aSymEnv [
"
elabExpr :: Located String -> SymEnv -> Expr -> Expr
" 
	^self elabExprE: aSymEnv
]

{ #category : #elaboration }
Expr >> elabExprE: aSymEnv [
	| sEnv f |
	sEnv := aSymEnv sort.
	f := [ :s | sEnv lookupSEnvWithDistance: s ].
	^[(self elab: (ElabEnv symEnv: aSymEnv env: f) ) first] runWithIncrementingIntegers
]

{ #category : #'as yet unclassified' }
Expr >> elaborate [
	| aSymEnv |
	aSymEnv := Context readState: #SymEnv.

	^self elabExpr: aSymEnv.
	"elabApply, then elabNumeric"
	"self shouldBeImplemented."
]

{ #category : #'F.Subable' }
Expr >> syms [
	self shouldBeImplemented
]
