Class {
	#name : #FQPosTest,
	#superclass : #FQTest,
	#category : #'Refinements-Tests'
}

{ #category : #tests }
FQPosTest >> testConjRhs [
	self provePos: 'constraint:
  env []
  lhs {v:int | true }
  rhs {v:int | (0 < 1) && (1 > 0) }
  id 1
  tag [1]'
]

{ #category : #tests }
FQPosTest >> testConjRhs1 [
	self provePos: 'constraint:
  env []
  id 1
  {v:int | (0 < 1) && (1 > 0) }
  tag [1]'
]

{ #category : #tests }
FQPosTest >> testFixpoint [
	self skip.
	self provePos: 'fixpoint "--eliminate=horn"'
]
