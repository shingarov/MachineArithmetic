Class {
	#name : #SpriteDecl,
	#superclass : #Object,
	#instVars : [
		'bind',
		'expr'
	],
	#category : #SpriteLang
}

{ #category : #'instance creation' }
SpriteDecl class >> bind: b expr: e [
	^self basicNew 
		bind: b;
		expr: e;
		yourself
]

{ #category : #'instance creation' }
SpriteDecl class >> mkDecl: decl ann: ann [
"TODO: factor to instance side"
	ann isNil ifTrue: [ ^decl ].
	ann symbol = decl bind id ifFalse: [ self error: 'bad annotation' ].
	^decl class bind: decl bind expr: (EAnn expr: decl expr ann: ann genSig)
]

{ #category : #accessing }
SpriteDecl >> bind [
	^ bind
]

{ #category : #accessing }
SpriteDecl >> bind: anObject [
	bind := anObject
]

{ #category : #verification }
SpriteDecl >> check: Γ rtype: t′ e′: e′ [
" 
      Γ ⊦ e ==> s        Γ, x:s ⊦ e' <== t'
      ------------------------------------------- [Chk-Let]
          Γ ⊦ let x = e in e' <== t'
"
	| x e c_s c s Γ′ c′ |
	x := bind id. e := expr.
	c_s := e synth: Γ. c := c_s first. s := c_s last.
	Γ′ := Γ extEnv: x rtype: s.
	c′ := e′ check: Γ′ rtype: t′.
	^c & (s cAll: x cstr: c′)
]

{ #category : #'reflect - embedding' }
SpriteDecl >> embedD [
"
goD (Let b e1 _)    = (bindId b, go e1)
"
	^bind id -> expr embed
]

{ #category : #accessing }
SpriteDecl >> expr [
	^ expr
]

{ #category : #accessing }
SpriteDecl >> expr: anObject [
	expr := anObject
]

{ #category : #GT }
SpriteDecl >> gtBind [
	^''
]

{ #category : #GT }
SpriteDecl >> gtChildren [ 
	(expr isKindOf: EAnn) ifTrue:[ ^ { expr ann . expr expr } ].
	(expr isKindOf: EFun) ifTrue:[ ^ { expr expr } ].

	^{expr}
]

{ #category : #GT }
SpriteDecl >> gtExpr [
	^expr
]

{ #category : #testing }
SpriteDecl >> isLet [
	^false
]

{ #category : #printing }
SpriteDecl >> printOn: aStream [
	self printStructOn: aStream
]

{ #category : #'as yet unclassified' }
SpriteDecl >> subsTy: su [ 
	^self class bind: bind expr: (expr subsTy: su)
]
