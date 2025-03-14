Class {
	#name : #'ΛPrimOp',
	#superclass : #Object,
	#category : #SpriteLang
}

{ #category : #syntax }
ΛPrimOp class >> parser [
	^self subclassResponsibility
]

{ #category : #selfification }
ΛPrimOp class >> rTypeSrc [
	self subclassResponsibility 
]

{ #category : #selfifization }
ΛPrimOp >> binOpTy [
	^self rType
]

{ #category : #syntax }
ΛPrimOp >> bopL: lhs R: rhs [
	^ΛEApp
			mkEApp: (EImm
				imm: (ECon
					prim: (PBin
						primOp: self)))
			args: { lhs . rhs }
]

{ #category : #'reflect - embedding' }
ΛPrimOp >> embedPrim: args [
"
embedPrim :: PrimOp -> [F.Expr] -> F.Expr
Cf. L₈ Reflect.hs
"
	^self subclassResponsibility
]

{ #category : #printing }
ΛPrimOp >> printOn: aStream [
	self printStructOn: aStream
]

{ #category : #selfification }
ΛPrimOp >> rType [
	^RTypeParser mkTy: self rTypeSrc
]

{ #category : #selfification }
ΛPrimOp >> rTypeSrc [
	^self class rTypeSrc
]
