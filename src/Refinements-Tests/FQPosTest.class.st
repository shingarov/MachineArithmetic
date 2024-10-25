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

{ #category : #tests }
FQPosTest >> testEqConstr0 [
	self provePos: '
bind 0 a : {v: int | Bool true }
bind 1 x : {v: int | Bool true }
bind 2 y : {v: `a | Bool true }

constraint:
  env [0; 1; 2]
  lhs {v:int | x === y }
  rhs {v:int | y === x }
  id 1
  tag [1]
'
]
