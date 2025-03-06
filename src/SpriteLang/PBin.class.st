Class {
	#name : #PBin,
	#superclass : #'ΛPrim',
	#instVars : [
		'primOp'
	],
	#category : #SpriteLang
}

{ #category : #'instance creation' }
PBin class >> primOp: primOp [
	^self basicNew primOp: primOp; yourself 
]

{ #category : #'primitive types' }
PBin >> constTy [
"
constTy l (PBin  o)     = binOpTy l o
"
	^primOp binOpTy
]

{ #category : #accessing }
PBin >> primOp [
	^ primOp
]

{ #category : #accessing }
PBin >> primOp: anObject [
	primOp := anObject
]
