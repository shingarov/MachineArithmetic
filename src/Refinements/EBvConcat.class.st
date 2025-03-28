Class {
	#name : #EBvConcat,
	#superclass : #Expr,
	#instVars : [
		'lhs',
		'rhs'
	],
	#category : #'Refinements-Core'
}

{ #category : #'instance creation' }
EBvConcat class >> lhs: l rhs: r [
	^self basicNew
		lhs: l;
		rhs: r;
		yourself
]

{ #category : #visiting }
EBvConcat >> accept: aVisitor [ 
	^EBvConcat
		lhs: (lhs accept: aVisitor)
		rhs: (rhs accept: aVisitor)
]

{ #category : #elaboration }
EBvConcat >> checkBvConcatTy_in: anEnv t₁: leftSort t₂: rightSort [
	^FApp
		s: (FTC new: FTyconBitVec new)
		t: (FTC new: (FTyconBitVecSize length: leftSort length + rightSort length))
]

{ #category : #'sort-checking' }
EBvConcat >> checkExpr: f [
	^f checkBvConcat: lhs rhs: rhs
]

{ #category : #elaboration }
EBvConcat >> elab: f [
	| e₁′_s₁ e₁′ s₁ e₂′_s₂ e₂′ s₂ s |
	e₁′_s₁ := lhs  elab: f.  e₁′ := e₁′_s₁ first. s₁ := e₁′_s₁ second.
	e₂′_s₂ := rhs elab: f.  e₂′ := e₂′_s₂ first. s₂ := e₂′_s₂ second.
	s := self checkBvConcatTy_in: f env t₁: s₁ t₂: s₂.
	^{
		EBvConcat
			lhs:  (ECst e: e₁′ sort: s₁)
			rhs: (ECst e: e₂′ sort: s₂).
		s
	}
]

{ #category : #elaboration }
EBvConcat >> elabApplyStep: γ [ 
	^EBvConcat
		lhs: (lhs elabApply: γ)
		rhs: (rhs elabApply: γ)
]

{ #category : #accessing }
EBvConcat >> lhs [
	^ lhs
]

{ #category : #accessing }
EBvConcat >> lhs: anObject [
	lhs := anObject
]

{ #category : #visiting }
EBvConcat >> mapExprOnExpr_case: f [
	^self shouldBeImplemented
]

{ #category : #accessing }
EBvConcat >> rhs [
	^ rhs
]

{ #category : #accessing }
EBvConcat >> rhs: anObject [
	rhs := anObject
]

{ #category : #'SMT interface' }
EBvConcat >> smt2: γ [
	^(lhs smt2: γ), (rhs smt2: γ)
]
