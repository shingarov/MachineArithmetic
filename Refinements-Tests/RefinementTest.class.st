Class {
	#name : #RefinementTest,
	#superclass : #TestCaseWithZ3Context,
	#category : #'Refinements-Tests'
}

{ #category : #tests }
RefinementTest >> test1 [
	| positiveInt predicateOverA solver a |
	positiveInt := Int sort | [ :x | x>0 ].
	predicateOverA := positiveInt toPredicateOver: 'a'.
	"predicateOverA is now the Bool expression a>0"
	self assert: predicateOverA sort equals: Bool sort.
	self assert: predicateOverA isBool.
	
	solver := Z3Solver new.
	solver assert: predicateOverA.
	self assert: solver check.
	a := solver getModel constantsASTs at: 'a'.
	self assert: a>0
]
