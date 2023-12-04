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
constTy _ (PInt  n)     = TBase TInt  (known $ F.exprReft (F.expr n))
constTy _ (PBool True)  = TBase TBool (known $ F.propReft F.PTrue)
constTy _ (PBool False) = TBase TBool (known $ F.propReft F.PFalse)
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
