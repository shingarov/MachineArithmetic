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

{ #category : #'as yet unclassified' }
PBin >> constTy [
"
constTy :: F.SrcSpan -> Prim -> RType
constTy _ (PInt n) = TBase TInt (F.exprReft (F.expr n))
constTy l (PBin o) = binOpTy l o
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
