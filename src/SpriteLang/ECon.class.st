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

{ #category : #'as yet unclassified' }
ECon >> evaluateIn: aBindEnv [
	^prim evaluateIn: aBindEnv 
]

{ #category : #GT }
ECon >> gtChildren [
	^{ prim }
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

{ #category : #accessing }
ECon >> prim [
	^ prim
]

{ #category : #accessing }
ECon >> prim: anObject [
	prim := anObject
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
