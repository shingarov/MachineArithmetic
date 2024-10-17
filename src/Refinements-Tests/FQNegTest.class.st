Class {
	#name : #FQNegTest,
	#superclass : #FQTest,
	#category : #'Refinements-Tests'
}

{ #category : #tests }
FQNegTest >> testConjRhs [
	self proveNeg: '
constraint:
  env []
  lhs {v:int | Bool true }
  rhs {v:int | ((0 toInt < 1) & (1 toInt < 0)) }
  id 1
  tag [1]
'
]
