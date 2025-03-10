Class {
	#name : #EBvRepeat,
	#superclass : #Expr,
	#instVars : [
		'bitvector',
		'times'
	],
	#category : #'Refinements-Core'
}

{ #category : #'instance creation' }
EBvRepeat class >> bitvector: x times: n [
	^self basicNew
		bitvector: x;
		times: n;
		yourself
]

{ #category : #visiting }
EBvRepeat >> accept: aVisitor [ 
	^self class
		bitvector: (bitvector accept: aVisitor)
		times: times
]

{ #category : #accessing }
EBvRepeat >> bitvector [
	^ bitvector
]

{ #category : #accessing }
EBvRepeat >> bitvector: anObject [
	bitvector := anObject
]

{ #category : #elaboration }
EBvRepeat >> checkBvRepeatTy_in: anEnv t: aSort [
	| length |
	length := aSort length.
	^FApp
		s: (FTC new: FTyconBitVec new)
		t: (FTC new: (FTyconBitVecSize length: length*times))
]

{ #category : #'sort-checking' }
EBvRepeat >> checkExpr: f [
	^f checkBvRepeat: bitvector times: times
]

{ #category : #elaboration }
EBvRepeat >> elab: f [
"
elab f@(_, g) e@(EBin o e1 e2)
"
	| e′_s e′ s s′ |
	e′_s := bitvector elab: f. e′ := e′_s first. s := e′_s second.
	s′ := self checkBvRepeatTy_in: f t: s.
	^{
		EBvRepeat
			bitvector: (ECst e: e′ sort: s)
			times: times.
		s′
	}
]

{ #category : #elaboration }
EBvRepeat >> elabApplyStep: γ [ 
	^EBvRepeat
		bitvector: (bitvector elabApply: γ)
		times: times
]

{ #category : #'SMT interface' }
EBvRepeat >> smt2: γ [
	^(bitvector smt2: γ) repeat: times
]

{ #category : #accessing }
EBvRepeat >> times [
	^ times
]

{ #category : #accessing }
EBvRepeat >> times: anObject [
	times := anObject
]
