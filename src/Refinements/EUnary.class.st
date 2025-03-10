"
Peculiar to Smalltalk.
I generalize LF's ENeg.
"
Class {
	#name : #EUnary,
	#superclass : #Expr,
	#instVars : [
		'uop',
		'arg'
	],
	#category : #'Refinements-Core'
}

{ #category : #'instance creation' }
EUnary class >> uop: aSelector arg: anExpr [
	^self basicNew
		uop: aSelector;
		arg: anExpr;
		yourself
]

{ #category : #visiting }
EUnary >> accept: aVisitor [
	^EUnary
		uop: uop
		arg: (arg accept: aVisitor)
]

{ #category : #accessing }
EUnary >> arg [
	^ arg
]

{ #category : #accessing }
EUnary >> arg: anObject [
	arg := anObject
]

{ #category : #'sort-checking' }
EUnary >> checkExpr: f [
"
checkExpr f (ENeg e)        = checkNeg f e
"
	^f checkUop: uop arg: arg
]

{ #category : #'sort-checking' }
EUnary >> checkUopTy_in: anEnv t: aSort [
	^aSort
]

{ #category : #elaboration }
EUnary >> elab: f [
	| e′_s′ e′ s′ s |
	e′_s′ := arg  elab: f.  e′ := e′_s′ first. s′ := e′_s′ second.
	s := self checkUopTy_in: f env t: s′.
	^{
		self class
			uop: uop
			arg:  (ECst e: e′ sort: s′).
		s
	}
]

{ #category : #elaboration }
EUnary >> elabApplyStep: γ [ 
	^EUnary
		uop: uop
		arg:  (arg elabApply: γ)
]

{ #category : #'SMT interface' }
EUnary >> smt2: γ [
	^(arg smt2: γ) perform: uop
]

{ #category : #accessing }
EUnary >> uop [
	^ uop
]

{ #category : #accessing }
EUnary >> uop: anObject [
	uop := anObject
]
