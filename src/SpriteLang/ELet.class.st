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
ELet >> check: Γ rtype: t′ [
	^decl check: Γ rtype: t′ e′: expr
]

{ #category : #accessing }
ELet >> decl [
	^ decl
]

{ #category : #accessing }
ELet >> decl: anObject [
	decl := anObject
]

{ #category : #polymorphism }
ELet >> elabC: Γ rtype: t2 [
(decl isKindOf: SpriteRDecl) "TODO: proper dispatch"
ifTrue: [
	| x e1 s1 e2 Γ′ as___t1 as t1 e1′ e2′ |
	x := decl bind id.
	e1 := decl expr expr.
	s1 := decl expr ann rtype.
	e2 := expr.
	Γ′ := Γ extEnv: x rtype: s1.
	as___t1 := s1 bkAlls. as := as___t1 first.  t1 := as___t1 last.
	e1′ := e1 elabC: (Γ′ extEnvTVs: as) rtype: t1.
	e2′ := e2 elabC: Γ′ rtype: t2.
	^ELet
		decl: (SpriteRDecl
				bind: (SpriteBind identifier: x)
				expr: (EAnn expr: (e1′ mkTLam: as) ann: decl expr ann))
		expr: e2′
] ifFalse: [ "non-recursive Let"
	| x e1 e2 e1′ s e1__s e2′ |
	x := decl bind id.
	e1 := decl expr.
	e2 := expr.
	e1__s := e1 elabS: Γ.
	e1′ := e1__s first.  s := e1__s last.
	e2′ := e2 elabC: (Γ extEnv: x rtype: s) rtype: t2.
	^ELet decl: (SpriteDecl bind: (SpriteBind identifier: x) expr: e1′) expr: e2′
]
]

{ #category : #'reflect - embedding' }
ELet >> embed [
	^expr embed subst1: decl embedD
]

{ #category : #accessing }
ELet >> expr [
	^ expr
]

{ #category : #accessing }
ELet >> expr: anObject [
	self assert: self ~~ anObject.
	expr := anObject
]

{ #category : #'as yet unclassified' }
ELet >> goSubsTyExpr: su [
	| d_ |
	d_ := decl subsTy: su.
	^ELet decl: d_ expr: (expr goSubsTyExpr: su)
]

{ #category : #GT }
ELet >> gtBind [
	^decl bind id
]

{ #category : #GT }
ELet >> gtChildren [
	^{ decl }
]

{ #category : #GT }
ELet >> gtExpr [
	^decl gtExpr
]

{ #category : #'as yet unclassified' }
ELet >> inlineNonRecursiveReflects [
	^decl inlineInto: expr	

]

{ #category : #testing }
ELet >> isLet [
	^true
]

{ #category : #printing }
ELet >> spriteOn: aStream indent: level [	
	decl spriteOn: aStream indent: level.
	aStream nextPut: $;.
	aStream cr.
	aStream next: level * 4 put: Character space.
	expr spriteOn: aStream indent: level.
]

{ #category : #'α-renaming' }
ELet >> uniq2: α [
	| id id′ α′ bind′ decl′ expr′ |

	id := decl bind id.
	id′:= α makeUnique: id.
	α′ := α extMap: id to: id′.
	
	bind′ := SpriteBind id: id′.
	
	decl expr isEAnn ifTrue:[
		"This is an annotated ELet, for example:
		
			⟦val x: int[v| v === (x + x)]⟧
			let x = x + x;
		
		In this case we *HAVE TO* rename x in both, decl's bind and val's bind
		but *NOT* in decl's expression and val's rtype! Hence the code below:
		"
		decl′ := decl class
		           bind: bind′
		           expr: (decl expr uniq2: α symbol: id′)."<-- CERTAINLY NOT α′!!!"		
	] ifFalse:[
		"This is an unannotated ELet, for example."
		
		decl′ := decl class
		           bind: bind′
		           expr: (decl expr uniq2: α)."<-- CERTAINLY NOT α′!!!"		
	].
	
	expr′ := expr uniq2: α′.

	^self class decl: decl′ expr: expr′

]
