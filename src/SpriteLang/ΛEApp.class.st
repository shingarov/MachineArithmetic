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

{ #category : #reflect }
ΛEApp >> bkApp: vArgs [ 
	^expr bkApp: {imm},vArgs
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

{ #category : #'reflect - embedding' }
ΛEApp >> embed [
"
embedApp :: SrcExpr -> F.Expr
"
	| f___args f args args′ |
	f___args := self bkApp. f := f___args key key. args := f___args value.
	args′ := args collect: #embedImm.
	(((f isKindOf: EImm) and: [ f imm isKindOf: ECon ]) and: [ f imm prim isKindOf: PBin ]) ifTrue: [
		^f imm prim primOp embedPrim: args′
	].

	((f isKindOf: EImm) and: [ f imm isKindOf: EVar ]) ifFalse: [ self shouldBeImplemented "Can this even ever happen??" ].

	"F.eApps   (embed f) args'"
	^EApp
		mkEApp: f imm sym
		args: args′
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

{ #category : #inlining }
ΛEApp >> isApplicationOf: fname [
	"Find out if the receiver is an app of function named fname.
	In the Lisp tradition of 'generalized booleans', answer the
	arity of the function if yes, or nil if no.
	"
	
	"(ΛEApp f x) can only have one of two forms.  Either f is an EImm:" 
	(expr isKindOf: EImm) ifTrue: [ ^expr imm = (EVar of: fname) ifTrue: [1] ifFalse: [nil] ].
	
	"or I am curried (ΛEApp on ΛEApp)"
	(expr isKindOf: ΛEApp) ifTrue: [ ^(expr isApplicationOf: fname) ifNil: [nil] ifNotNil: [ :ar | ar+1 ] ].
	
	"no other possibilities"
	self error
]

{ #category : #inlining }
ΛEApp >> macroExpandEVar: f to: aΛExpr [
	| arityOrFalse appThisTime args argNames argValues body |
	arityOrFalse := self isApplicationOf: f.
	arityOrFalse isNil ifTrue: [
		"Not me.  Pass along..."
		^ΛEApp
			expr: (expr macroExpandEVar: f to: aΛExpr)
			imm: (imm macroExpandEVar: f to: aΛExpr)
	].

	appThisTime := self.
	args := OrderedCollection new.
	body := aΛExpr.
	arityOrFalse timesRepeat: [ 
		args add: body bind id -> appThisTime imm.
		body := body expr.
		appThisTime := appThisTime expr.
	].
	argNames := args collect: #key.
	argValues := (args collect: #value) reversed.
	^(argNames zip: argValues) inject: body into: [ :accum :thisArg | accum macroExpandEVar: thisArg key to: thisArg value ]
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
