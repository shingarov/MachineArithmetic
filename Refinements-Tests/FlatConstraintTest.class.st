Class {
	#name : #FlatConstraintTest,
	#superclass : #TestCaseWithZ3Context,
	#category : #'Refinements-Tests'
}

{ #category : #'tests - tauto expr' }
FlatConstraintTest >> testConjunctsOfTautoPreds [
	| p |
	p := PAnd of: { Expr PTrue . (PAtomEq x: 'a' y: 'a') }.
	self assert: p conjuncts isEmpty
]

{ #category : #'tests - tauto hpred' }
FlatConstraintTest >> testEmpty [ 
	self assert: #() flatten isEmpty
]

{ #category : #'tests - tauto hpred' }
FlatConstraintTest >> testFlattenOneRVA [
	| hpred |
	hpred := HPredAnd of: {
		HReft expr: Expr PTrue.
		HPredAnd of: #().
		RefVarApp var: 'x' args: #()
	}.
	self assert: (hpred flatten isKindOf: RefVarApp)
	
]

{ #category : #'tests - tauto hpred' }
FlatConstraintTest >> testFlattenTrivialCstr [
	| cstr |
	cstr := CstrAnd of: {
		CstrAnd of: #().
		CstrHead pred: (HReft expr: Expr PTrue)
	}.
	self assert: cstr flatten conjuncts isEmpty
	
]

{ #category : #'tests - tauto expr' }
FlatConstraintTest >> testPFalseNotTautoPred [
	self deny: Expr PFalse isTautoPred
]

{ #category : #'tests - tauto expr' }
FlatConstraintTest >> testRefaConjunctsOfTautoPreds [
	| p |
	p := PAnd of: { Expr PTrue . (PAtomEq x: 'a' y: 'a') }.
	self assert: p refaConjuncts isEmpty
]

{ #category : #'tests - tauto expr' }
FlatConstraintTest >> testTautoPredDecidable [
	| p |
	p := DecidableRefinement text: 'a < 0'.
	self deny: p isTautoPred
]

{ #category : #'tests - tauto expr' }
FlatConstraintTest >> testTautoPredEmptyPAnd [
	| p |
	p := PAnd of: #().
	self assert: p isTautoPred
]

{ #category : #'tests - tauto expr' }
FlatConstraintTest >> testTautoPredNonEmptyPAnd [
	| p |
	p := PAnd of: {DecidableRefinement text: 'a < 0'}.
	self deny: p isTautoPred
]
