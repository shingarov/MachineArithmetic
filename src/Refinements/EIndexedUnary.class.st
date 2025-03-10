Class {
	#name : #EIndexedUnary,
	#superclass : #EUnary,
	#instVars : [
		'index'
	],
	#category : #'Refinements-Core'
}

{ #category : #'instance creation' }
EIndexedUnary class >> uop: aSelector arg: anExpr [
	^self shouldNotImplement
]

{ #category : #'instance creation' }
EIndexedUnary class >> uop: aSelector arg: anExpr index: j [
	^self basicNew
		uop: aSelector;
		arg: anExpr;
		index: j;
		yourself
]

{ #category : #visiting }
EIndexedUnary >> accept: aVisitor [
	^EIndexedUnary
		uop: uop
		arg: (arg accept: aVisitor)
		index: index
]

{ #category : #elaboration }
EIndexedUnary >> elab: f [
	| e′_s′ e′ s′ s |
	e′_s′ := arg  elab: f.  e′ := e′_s′ first. s′ := e′_s′ second.
	s := self checkUopTy_in: f env t: s′.
	^{
		EIndexedUnary
			uop: uop
			arg:  (ECst e: e′ sort: s′)
			index: index.
		s
	}
]

{ #category : #elaboration }
EIndexedUnary >> elabApplyStep: γ [ 
	^EIndexedUnary
		uop: uop
		arg:  (arg elabApply: γ)
		index: index
]

{ #category : #accessing }
EIndexedUnary >> index [
	^ index
]

{ #category : #accessing }
EIndexedUnary >> index: anObject [
	index := anObject
]

{ #category : #'SMT interface' }
EIndexedUnary >> smt2: γ [
	^(arg smt2: γ) perform: uop with: index
]
