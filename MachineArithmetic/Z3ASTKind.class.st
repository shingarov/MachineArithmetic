Class {
	#name : #Z3ASTKind,
	#superclass : #SharedPool,
	#classVars : [
		'NUMERAL_AST',
		'APP_AST',
		'VAR_AST',
		'QUANTIFIER_AST',
		'SORT_AST',
		'FUNC_DECL_AST',
		'UNKNOWN_AST'
	],
	#category : #'MachineArithmetic-Core'
}

{ #category : #utilities }
Z3ASTKind class >> astClassForAst: ast [
	| astKind |

	astKind := ast getKindCode.

	astKind = APP_AST ifTrue: [ ^ ASTKindAPP ].
	astKind = FUNC_DECL_AST ifTrue: [ ^ ASTKindFUNCDECL ].
	astKind = NUMERAL_AST ifTrue: [ ^ ASTKindNUMERAL ].
	astKind = QUANTIFIER_AST ifTrue: [ ^ ASTKindQUANTIFIER ].
	astKind = SORT_AST ifTrue: [ ^ ASTKindSORT ].
	astKind = UNKNOWN_AST ifTrue: [ ^ ASTKindUNKNOWN ].
	astKind = VAR_AST ifTrue: [ ^ ASTKindVAR ].

	self error: '(Yet) unssuported AST kind'

]

{ #category : #initialization }
Z3ASTKind class >> initialize [
	"See z3_api.h [1]

	 [1]: https://github.com/Z3Prover/z3/blob/a52b485d9c27c4c7cd26f47fdf878b264900a0a6/src/api/z3_api.h#L179-L188
	"   
	NUMERAL_AST := 0.
	APP_AST := 1.
	VAR_AST := 2.
	QUANTIFIER_AST := 3.
	SORT_AST := 4.
	FUNC_DECL_AST := 5.
	UNKNOWN_AST := 1000.

]
