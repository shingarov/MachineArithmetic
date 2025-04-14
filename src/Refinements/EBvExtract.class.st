Class {
	#name : #EBvExtract,
	#superclass : #Expr,
	#instVars : [
		'bitvector',
		'm',
		'n'
	],
	#category : #'Refinements-Core'
}

{ #category : #'instance creation' }
EBvExtract class >> bitvector: x m: m n: n [
	^self basicNew
		bitvector: x;
		m: m;
		n: n;
		yourself
]

{ #category : #visiting }
EBvExtract >> accept: aVisitor [ 
	^self class
		bitvector: (bitvector accept: aVisitor)
		m: m
		n: n
]

{ #category : #accessing }
EBvExtract >> bitvector [
	^ bitvector
]

{ #category : #accessing }
EBvExtract >> bitvector: anObject [
	bitvector := anObject
]

{ #category : #elaboration }
EBvExtract >> checkBvExtractTy_in: anEnv t: _ [
	^FApp
		s: (FTC new: FTyconBitVec new)
		t: (FTC new: (FTyconBitVecSize length: m asInteger - n asInteger + 1))
]

{ #category : #'sort-checking' }
EBvExtract >> checkExpr: f [
	^f checkBvExtract: bitvector m: m n: n
]

{ #category : #elaboration }
EBvExtract >> elab: f [
	| e′_s e′ s s′ |
	e′_s := bitvector elab: f. e′ := e′_s first. s := e′_s second.
	s′ := self checkBvExtractTy_in: f t: s.
	^{
		EBvExtract
			bitvector: (ECst e: e′ sort: s)
			m: m
			n: n.
		s′
	}
]

{ #category : #elaboration }
EBvExtract >> elabApplyStep: γ [ 
	^EBvExtract
		bitvector: (bitvector elabApply: γ)
		m: m
		n: n
]

{ #category : #accessing }
EBvExtract >> m [
	^ m
]

{ #category : #accessing }
EBvExtract >> m: anObject [
	m := anObject
]

{ #category : #visiting }
EBvExtract >> mapExprOnExpr_case: f [
	^self shouldBeImplemented
]

{ #category : #accessing }
EBvExtract >> n [
	^ n
]

{ #category : #accessing }
EBvExtract >> n: anObject [
	n := anObject
]

{ #category : #'SMT interface' }
EBvExtract >> smt2: γ [
	^(bitvector smt2: γ) copyFrom: m asInteger to: n asInteger
]
