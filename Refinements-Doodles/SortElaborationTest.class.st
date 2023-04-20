Class {
	#name : #SortElaborationTest,
	#superclass : #TestCaseWithZ3Context,
	#category : #'Refinements-Doodles'
}

{ #category : #tests }
SortElaborationTest >> testUnifySorts1 [
	| t1 t2 maybeTVSubst |
	t1 := Int sort.
	t2 := FVar new: 5.
	[
		maybeTVSubst := Z3Sort unify: #bogus maybeExpr: nil sort: t1 sort: t2.
		self assert: (maybeTVSubst at: 5) equals: Int sort
	] runWithIncrementingIntegers.
	
]

{ #category : #tests }
SortElaborationTest >> testUnifySorts2 [
	| t1 t2 maybeTVSubst |
	t1 := Int sort.
	t2 := 'a' toSort.
	[
		maybeTVSubst := Z3Sort unify: #bogus maybeExpr: nil sort: t1 sort: t2.
		self assert: maybeTVSubst isNil
	] runWithIncrementingIntegers.
	
]
