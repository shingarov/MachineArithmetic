Class {
	#name : #'ΛEApp',
	#superclass : #'ΛExpression',
	#instVars : [
		'expr',
		'imm'
	],
	#category : #SpriteLang
}

{ #category : #'as yet unclassified' }
ΛEApp class >> expr: e imm: i [ 
	^ self basicNew 
		expr: e;
		imm: i;
		yourself
]

{ #category : #'as yet unclassified' }
ΛEApp class >> mkEApp: f args: imms [
"
This is the Sprite mkEApp, not F.mkEApp.
mkEApp :: SrcExpr -> [SrcImm] -> SrcExpr
cf. Parser.hs
"
	^imms inject: f into: [ :e :y | self expr: e imm: y ]
]

{ #category : #polymorphism }
ΛEApp >> elabS: Γ [
	| e__te e_ te |
	e__te := expr elabS: Γ.
	e_ := e__te first.  te := e__te last.
	(te isKindOf: TFun) ifFalse: [ self error: 'Application of non-function' ] ifTrue: [
		| s t yt t_ |
		s := te s.  t := te t.
		yt := imm immTy: Γ.
		s unify: yt.
		t_ := t subsTyM.
		^{ ΛEApp expr: e_ imm: imm . t_ }
	]
]

{ #category : #accessing }
ΛEApp >> expr [
	^ expr
]

{ #category : #accessing }
ΛEApp >> expr: anObject [
	expr := anObject
]

{ #category : #'as yet unclassified' }
ΛEApp >> goSubsTyExpr: su [ 
	^ΛEApp expr: (expr goSubsTyExpr: su) imm: imm
]

{ #category : #GT }
ΛEApp >> gtChildren [
	^{ expr . imm }
]

{ #category : #accessing }
ΛEApp >> imm [
	^ imm
]

{ #category : #accessing }
ΛEApp >> imm: anObject [
	imm := anObject
]

{ #category : #'as yet unclassified' }
ΛEApp >> synth: Γ [
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
