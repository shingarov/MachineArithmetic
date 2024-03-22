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

{ #category : #selfification }
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

{ #category : #printing }
PBin >> spriteOn: stream indent: level [
	primOp spriteOn: stream indent: level
]
