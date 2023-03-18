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

{ #category : #selfifization }
ΛPrimOp >> binOpTy [
	^((RTypeParser new productionAt: #rtype) parse: self class rTypeSrc) generalize rebind
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
	^(RTypeParser new productionAt: #rtype) parse: self rTypeSrc
]
