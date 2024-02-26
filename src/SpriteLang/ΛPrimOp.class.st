Class {
	#name : #'ΛPrimOp',
	#superclass : #Object,
	#category : #SpriteLang
}

{ #category : #syntax }
ΛPrimOp class >> concreteParser [
	^self operator asParser ==> [ :_x | self new ]
]

{ #category : #syntax }
ΛPrimOp class >> operator [
	self subclassResponsibility
]

{ #category : #syntax }
ΛPrimOp class >> parser [
	^PPChoiceParser withAll: ((self subclasses
		asSortedCollection: [ :a :b | a operator size > b operator size ])
			collect: [ :eachKeyword | eachKeyword concreteParser ])
]

{ #category : #selfification }
ΛPrimOp class >> rTypeSrc [
	self subclassResponsibility 
]

{ #category : #'reflect - embedding' }
ΛPrimOp class >> smalltalkSelector [
	^self subclassResponsibility
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
