Class {
	#name : #ECon,
	#superclass : #SpriteImm,
	#instVars : [
		'prim'
	],
	#category : #SpriteLang
}

{ #category : #accessing }
ECon class >> prim: aPrim [
	^self basicNew prim: aPrim; yourself 
]

{ #category : #visiting }
ECon >> accept: aVisitor [
	^self
]

{ #category : #'reflect - embedding' }
ECon >> embedImm [
	^self
]

{ #category : #'as yet unclassified' }
ECon >> evaluateIn: aBindEnv ifUndeclared: vndBlock [
	^prim evaluateIn: aBindEnv ifUndeclared: vndBlock
]

{ #category : #GT }
ECon >> gtBind [
	^''
]

{ #category : #GT }
ECon >> gtChildren [
	^#()
]

{ #category : #GT }
ECon >> gtExpr [
	^self
]

{ #category : #substitution }
ECon >> immExpr [
	^prim immExprX
]

{ #category : #'as yet unclassified' }
ECon >> immTy: Γ [
"
immTy _ (ECon c l)      = return (constTy l c)
"
	^prim constTy
]

{ #category : #inlining }
ECon >> inlineFunction: f λ: x body: b [ 
	^self
]

{ #category : #accessing }
ECon >> prim [
	^ prim
]

{ #category : #accessing }
ECon >> prim: anObject [
	prim := anObject
]

{ #category : #printing }
ECon >> spriteOn: aStream indent: level [
	"Print receiver on `aStream` as SpriteLang source"
	prim spriteOn: aStream indent: level

]

{ #category : #substitution }
ECon >> subst: θ [
	^self
]

{ #category : #accessing }
ECon >> sym [
	^nil
]

{ #category : #'as yet unclassified' }
ECon >> synthImm: Γ [
	^prim constTy
]

{ #category : #'as yet unclassified' }
ECon >> toFX [
	^self shouldBeImplemented 
]

{ #category : #'α-renaming' }
ECon >> uniq2: α [
	"Nothing to do"
]
