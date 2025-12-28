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

{ #category : #polymorphism }
SpriteDecl >> elabELet: e₂ rtype: t₂ in: Γ [
	"non-recursive let x:s = e₁ in e₂:
	elabC Γ (ELet (Decl (Bind x l) e₁ l₁) e₂ l₂) t₂ = do
	  (e₁', s) <- elabS Γ e₁
	  e₂'      <- elabC (extEnv Γ x s) e₂ t₂
	  return    $ ELet (Decl (Bind x l) e₁' l₁) e₂' l₂
	"
	| x e₁ e₁′ s e₁′_s e₂′ |self halt.
	x := bind id. e₁ := expr.
	e₁′_s := e₁ elabS: Γ.
	e₁′ := e₁′_s first.  s := e₁′_s last.
	e₂′ := e₂ elabC: (Γ extEnv: x rtype: s) rtype: t₂.
	^ELet
		decl: (SpriteDecl bind: (SpriteBind identifier: x) expr: e₁′)
		expr: e₂′
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

{ #category : #testing }
SpriteDecl >> isRecursive [
	^false
]

{ #category : #printing }
SpriteDecl >> printOn: aStream [
	self printStructOn: aStream
]

{ #category : #printing }
SpriteDecl >> spriteOn: aStream indent: level [
	| body |

	(expr isKindOf: EAnn) ifTrue:[
		aStream cr;cr.
		expr ann spriteOn: aStream indent: level.
		aStream cr.

		body := expr expr.
	] ifFalse:[
		body := expr.
	].

	aStream nextPutAll:'let '.
	self isRecursive ifTrue:[	aStream nextPutAll:'rec ' ].
	aStream nextPutAll:bind id.
	aStream nextPutAll:' = '.
	body isLet ifTrue:[
		aStream nextPut: ${; cr.
		aStream next: level + 1 * 4 put: Character space.
		body spriteOn: aStream indent: level + 1.
		aStream cr.
		aStream next: level * 4 put: Character space.
		aStream nextPut: $}.
	] ifFalse:[
		body spriteOn: aStream indent: level.
	].

]

{ #category : #'as yet unclassified' }
SpriteDecl >> subsTy: su [ 
	^self class bind: bind expr: (expr subsTy: su)
]
