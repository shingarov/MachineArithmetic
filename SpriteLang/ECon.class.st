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
