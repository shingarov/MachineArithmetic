Class {
	#name : #ECst,
	#superclass : #Expr,
	#instVars : [
		'expr',
		'sort'
	],
	#category : #Refinements
}

{ #category : #'instance creation' }
ECst class >> eAppC: s e1: e1 e2: e2 [
"
eAppC :: Sort -> Expr -> Expr -> Expr
"
	^self expr: (EApp expr: e1 imm: e2) sort: s
]

{ #category : #'instance creation' }
ECst class >> expr: e sort: s [
	^self basicNew
		expr: e;
		sort: s;
		yourself
]

{ #category : #'as yet unclassified' }
ECst >> applyExpr: θ [
"DON'T COMMIT ME YET.
This is only used in our experiments with L6maxint."
	^ECst expr: expr sort: (sort apply: θ)
]

{ #category : #elaboration }
ECst >> elab: anElabEnv [
	| e′_☐ evalEnv computed |
	e′_☐ := expr elab: anElabEnv.
	^{ ECst expr: e′_☐ first sort: sort }
]

{ #category : #uncurrying }
ECst >> elabApplyStep: γ [
	^ECst
		expr: (expr elabApplyStep: γ)
		sort: sort
]

{ #category : #accessing }
ECst >> expr [
	^ expr
]

{ #category : #accessing }
ECst >> expr: anObject [
	expr := anObject
]

{ #category : #'SMT interface' }
ECst >> smt2: γ [ 
	^expr smt2Cast: sort in: γ
]

{ #category : #accessing }
ECst >> sort [
	^ sort
]

{ #category : #accessing }
ECst >> sort: anObject [
	sort := anObject
]

{ #category : #'as yet unclassified' }
ECst >> splitArgsGo: acc [
	| e1 e s |
	(expr isKindOf: EApp) ifFalse: [ ^super splitArgsGo: acc ].
	e1 := expr expr.
	e  := expr imm.
	s  := sort.
	^e1 splitArgsGo: {e->s}, acc
]
