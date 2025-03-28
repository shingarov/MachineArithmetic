Class {
	#name : #EBvExtend,
	#superclass : #Expr,
	#instVars : [
		'bitvector',
		'i',
		'isSigned'
	],
	#category : #'Refinements-Core'
}

{ #category : #'instance creation' }
EBvExtend class >> bitvector: x i: i signed: aBool [
	^self basicNew
		bitvector: x;
		i: i;
		isSigned: aBool;
		yourself
]

{ #category : #visiting }
EBvExtend >> accept: aVisitor [ 
	^self class
		bitvector: (bitvector accept: aVisitor)
		i: i
		signed: isSigned
]

{ #category : #accessing }
EBvExtend >> bitvector [
	^ bitvector
]

{ #category : #accessing }
EBvExtend >> bitvector: anObject [
	bitvector := anObject
]

{ #category : #elaboration }
EBvExtend >> checkBvExtendTy_in: anEnv t: aSort [
	| length |
	length := aSort length.
	^FApp
		s: (FTC new: FTyconBitVec new)
		t: (FTC new: (FTyconBitVecSize length: length+i))
]

{ #category : #'sort-checking' }
EBvExtend >> checkExpr: f [
	^f checkBvExtend: bitvector i: i signed: isSigned
]

{ #category : #elaboration }
EBvExtend >> elab: f [
"
elab f@(_, g) e@(EBin o e1 e2)
"
	| e′_s e′ s s′ |
	e′_s := bitvector elab: f. e′ := e′_s first. s := e′_s second.
	s′ := self checkBvExtendTy_in: f t: s.
	^{
		EBvExtend
			bitvector: (ECst e: e′ sort: s)
			i: i
			signed: isSigned.
		s′
	}
]

{ #category : #elaboration }
EBvExtend >> elabApplyStep: γ [ 
	^EBvExtend
		bitvector: (bitvector elabApply: γ)
		i: i
		signed: isSigned
]

{ #category : #accessing }
EBvExtend >> i [
	^ i
]

{ #category : #accessing }
EBvExtend >> i: anObject [
	i := anObject
]

{ #category : #accessing }
EBvExtend >> isSigned [
	^ isSigned
]

{ #category : #accessing }
EBvExtend >> isSigned: anObject [
	isSigned := anObject
]

{ #category : #visiting }
EBvExtend >> mapExprOnExpr_case: f [
	^self shouldBeImplemented
]

{ #category : #'SMT interface' }
EBvExtend >> smt2: γ [
	| z3bitvector |
	z3bitvector := bitvector smt2: γ.
	^isSigned
		ifTrue: [ z3bitvector signExtend: i ]
		ifFalse: [ z3bitvector zeroExtend: i ]
]
