Class {
	#name : #FQPosTest,
	#superclass : #FQTest,
	#category : #'Refinements-Tests'
}

{ #category : #tests }
FQPosTest >> testConjRhs [
	self provePos: '
constraint:
  env []
  lhs {v:int | Bool true }
  rhs {v:int | ((0 toInt < 1) & (1 toInt > 0)) }
  id 1
  tag [1]
'
]
