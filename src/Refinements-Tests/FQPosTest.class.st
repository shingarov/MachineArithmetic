Class {
	#name : #FQPosTest,
	#superclass : #FQTest,
	#category : #'Refinements-Tests'
}

{ #category : #tests }
FQPosTest >> testConjRhs [
self skip.
	self provePos: '
constraint:
  env []
  lhs {v:int | true }
  rhs {v:int | ((0 < 1) & (1 > 0)) }
  id 1
  tag [1]
'
]
