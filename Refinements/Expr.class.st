Class {
	#name : #Expr,
	#superclass : #Object,
	#category : #Refinements
}

{ #category : #'as yet unclassified' }
Expr class >> splitEApp: e [
	| go |	
	go := [ :acc :thisTime |
		(thisTime isKindOf: FxEApp)
			ifTrue: [ go value: ({thisTime imm}, acc) value: thisTime expr ]
			ifFalse: [ thisTime->acc ] ].
	^go value: #() value: e

]

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
"
elabExprE :: Located String -> SymEnv -> Expr -> Either Error Expr
"
	| localSymEnv f |
	localSymEnv := aSymEnv "copy".
	f := [ :s | localSymEnv sort lookupSEnvWithDistance: s ].

		"aSymEnv copies add: localSymEnv."
		^(self elab: (ElabEnv symEnv: localSymEnv env: f) ) first

]

{ #category : #'as yet unclassified' }
Expr >> elaborate: γ [
"
instance Elaborate Expr where
  elaborate msg env = elabNumeric . elabApply env . elabExpr msg env
"
	^self elabExpr: γ.
	"TODO: elabApply, then elabNumeric"
]

{ #category : #'F.Subable' }
Expr >> syms [
	self shouldBeImplemented
]
