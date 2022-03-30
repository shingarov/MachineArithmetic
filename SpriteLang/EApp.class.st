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

{ #category : #accessing }
EApp >> expr [
	^ expr
]

{ #category : #accessing }
EApp >> expr: anObject [
	expr := anObject
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
