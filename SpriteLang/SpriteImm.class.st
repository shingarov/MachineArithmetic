Class {
	#name : #SpriteImm,
	#superclass : #Object,
	#category : #SpriteLang
}

{ #category : #'as yet unclassified' }
SpriteImm >> checkImm: Γ rtype: t [
	| s |
	s := self synthImm: Γ.
	^s ≺ t
]

{ #category : #substitution }
SpriteImm >> immExpr [
"
immExpr :: Imm b -> F.Expr
"
	self subclassResponsibility
]

{ #category : #printing }
SpriteImm >> printOn: aStream [
	self printStructOn: aStream
]

{ #category : #'as yet unclassified' }
SpriteImm >> synthImm: aCollection [ 
	self subclassResponsibility 
]

{ #category : #'as yet unclassified' }
SpriteImm >> toFX [
	self subclassResponsibility 
]
