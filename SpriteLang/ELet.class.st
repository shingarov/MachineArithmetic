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
(decl isKindOf: SpriteRDecl) "TODO: properly dispatch"
ifFalse: [
" 
      Γ ⊦ e ==> s        Γ, x:s ⊦ e' <== t'
      ------------------------------------------- [Chk-Let]
          Γ ⊦ let x = e in e' <== t'
"
	| x e   e_   c_s c s Γ1 c1 |
	x := decl bind id. e := decl expr. e_ := expr.
	c_s := e synth: Γ. c := c_s first. s := c_s last.
	Γ1 := Γ extEnv: x rtype: s.
	c1 := e_ check: Γ1 rtype: t_.
	^c & (s cAll: x cstr: c1)
] ifTrue: [
"
   t := fresh(s)    Γ; f:t ⊦ e <== t    Γ; f:t ⊦ e' <== t'
   -------------------------------------------------------[Chk-Rec]
   Γ ⊦ letrec f = (e:s) in e' <== t'
"
	| x eAnn e s e_ t Γ1 c c_ |
	x := decl bind id.
	eAnn := decl expr.
	(eAnn isKindOf: EAnn) ifFalse: [ self error: 'should this be allowed???' ].
	e := eAnn expr. s := eAnn rtype. e_ := expr.
	t := Γ fresh: s.
	Γ1 := Γ extEnv: x rtype: t.
	c  := e  check: Γ1 rtype: t.
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
