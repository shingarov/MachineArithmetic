Class {
	#name : #EApp,
	#superclass : #'ΛExpression',
	#instVars : [
		'expr',
		'imm'
	],
	#category : #SpriteLang
}

{ #category : #'as yet unclassified' }
EApp class >> expr: e imm: i [ 
	^ self basicNew 
		expr: e;
		imm: i;
		yourself
]

{ #category : #'as yet unclassified' }
EApp class >> mkEApp: f args: imms [ 
	^imms inject: f into: [ :fSoFar :thisArg | self expr: fSoFar imm: thisArg ]
]

{ #category : #'as yet unclassified' }
EApp >> elab: anElabEnv [
	| elabResults f x |
	(Context readState: #SymEnv) == anElabEnv senv ifFalse: [ self error "Investigate; this shouldn't happen." ].
	(expr isKindOf: EApp) ifTrue: [self shouldBeImplemented "EAPP-EAPP" ].
	
	elabResults := anElabEnv elabEApp: expr _: imm.
	f := elabResults second z3sort.
	x := elabResults fourth z3sort.
	
	anElabEnv senv sort note: imm  elaboratedTo: x.
	anElabEnv senv sort note: expr elaboratedTo: f.
	
	^{f.x}
]

{ #category : #polymorphism }
EApp >> elabS: Γ [
	| e__te e_ te |
	e__te := expr elabS: Γ.
	e_ := e__te first.  te := e__te last.
	(te isKindOf: TFun) ifFalse: [ self error: 'Application of non-function' ] ifTrue: [
		| s t yt t_ |
		s := te s.  t := te t.
		yt := imm immTy: Γ.
		s unify: yt.
		t_ := t subsTyM.
		^{ EApp expr: e_ imm: imm . t_ }
	]
]

{ #category : #accessing }
EApp >> expr [
	^ expr
]

{ #category : #accessing }
EApp >> expr: anObject [
	expr := anObject
]

{ #category : #'as yet unclassified' }
EApp >> goSubsTyExpr: su [ 
	^EApp expr: (expr goSubsTyExpr: su) imm: imm
]

{ #category : #accessing }
EApp >> imm [
	^ imm
]

{ #category : #accessing }
EApp >> imm: anObject [
	imm := anObject
]

{ #category : #'as yet unclassified' }
EApp >> synth: Γ [
"
     Γ ⊦ e ==> x:s -> t
     Γ ⊦ y <== s
     ----------------------- [Syn-App]
     Γ ⊦ e y ==> t[x := y]
"
	| e y ce_te ce te x s t cy |
	e := expr. y := imm.
	ce_te := e synth: Γ. ce := ce_te first. te := ce_te last.
	(te isKindOf: TFun) ifFalse: [ self error: 'Application of non-function' ].
	x := te x. s := te s. t := te t.
	cy := y checkImm: Γ rtype: s.
	^{ ce & cy . t substImm: x imm: y }
]
