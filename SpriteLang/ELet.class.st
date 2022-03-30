Class {
	#name : #ELet,
	#superclass : #'ΛExpression',
	#instVars : [
		'decl',
		'expr'
	],
	#category : #SpriteLang
}

{ #category : #'instance creation' }
ELet class >> decl: d expr: e [
	^self basicNew decl: d; expr: e; yourself
]

{ #category : #verification }
ELet >> check: Γ rtype: t_ [
" 
      Γ ⊦ e1 ==> t1        Γ, x:t1 ⊦ e2 <== t2
      ------------------------------------------- [Chk-Let]
          Γ ⊦ let x = e1 in e2 <== t2
"
(decl isKindOf: SpriteRDecl) "TODO: properly dispatch"
ifFalse: [
	| bx x e   e1   c_s c s Γ1 c1 |
	bx := decl bind.
	x := bx id.
	e := decl expr.
	e1 := expr.
	c_s := e synth: Γ. c := c_s first. s := c_s last.
	Γ1 := Γ extEnv: bx rtype: s.
	c1 := e1 check: Γ1 rtype: t_.
	^c & (s cAll: x cstr: c1)
] ifTrue: [
	| bx x e s e_ Γ1 c c_ |
	bx := decl bind.
	x := bx id.
	(decl expr isKindOf: EAnn) ifFalse: [ self error: 'should this be allowed???' ].
	e := decl expr expr. s := decl expr rtype.
	e_ := expr.
	Γ1 := Γ extEnv: bx rtype: s.
	c  := e  check: Γ1 rtype: s.
	c_ := e_ check: Γ1 rtype: t_.
	^c & c_
]
]

{ #category : #accessing }
ELet >> decl [
	^ decl
]

{ #category : #accessing }
ELet >> decl: anObject [
	decl := anObject
]

{ #category : #accessing }
ELet >> expr [
	^ expr
]

{ #category : #accessing }
ELet >> expr: anObject [
	expr := anObject
]
