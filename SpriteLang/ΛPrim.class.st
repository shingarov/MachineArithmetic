Class {
	#name : #'ΛPrim',
	#superclass : #Object,
	#category : #SpriteLang
}

{ #category : #'as yet unclassified' }
ΛPrim >> constTy [
"
constTy :: F.SrcSpan -> Prim -> RType
constTy _ (PInt n) = TBase TInt (F.exprReft (F.expr n))
constTy l (PBin o) = binOpTy l o
"
	self subclassResponsibility 
]

{ #category : #printing }
ΛPrim >> printOn: aStream [
	self printStructOn: aStream
]
