Class {
	#name : #FQNegTest,
	#superclass : #FQTest,
	#category : #'Refinements-Tests'
}

{ #category : #tests }
FQNegTest >> testConjRhs [
self skip.
	self proveNeg: '
constraint:
  env []
  lhs {v:int | true }
  rhs {v:int | ((0 = 1) & (1 = 0)) }
  id 1
  tag [1]
'
]
