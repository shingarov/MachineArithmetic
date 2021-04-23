Class {
	#name : #Z3ASTKind,
	#superclass : #SharedPool,
	#classVars : [
		'APP_AST',
		'FUNC_DECL_AST',
		'NUMERAL_AST',
		'QUANTIFIER_AST',
		'SORT_AST',
		'UNKNOWN_AST',
		'VAR_AST'
	],
	#category : #'MachineArithmetic-Core'
}

{ #category : #utilities }
Z3ASTKind class >> astClassForAst: ast [
	| astKind |

	astKind := ast getKindCode.

	astKind = APP_AST ifTrue: [ ^ Z3AppAST ].
	astKind = FUNC_DECL_AST ifTrue: [ ^ Z3FuncDeclAST ].
	astKind = NUMERAL_AST ifTrue: [ ^ Z3NumeralAST ].
	astKind = QUANTIFIER_AST ifTrue: [ ^ Z3QuantifierAST ].
	astKind = SORT_AST ifTrue: [ ^ ASTKindSORT ].
	astKind = UNKNOWN_AST ifTrue: [ ^ Z3UnknownAST ].
	astKind = VAR_AST ifTrue: [ ^ Z3VarAST ].

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
