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

{ #category : #accessing }
SpriteDecl >> expr [
	^ expr
]

{ #category : #accessing }
SpriteDecl >> expr: anObject [
	expr := anObject
]

{ #category : #GT }
SpriteDecl >> gtChildren [ 
	^{expr}
]

{ #category : #printing }
SpriteDecl >> printOn: aStream [
	self printStructOn: aStream
]

{ #category : #'as yet unclassified' }
SpriteDecl >> subsTy: su [ 
	^self class bind: bind expr: (expr subsTy: su)
]
