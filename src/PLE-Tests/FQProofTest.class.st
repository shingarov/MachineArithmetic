Class {
	#name : #FQProofTest,
	#superclass : #FQPosTest,
	#category : #'PLE-Tests'
}

{ #category : #tests }
FQProofTest >> testPLE0 [
	self provePos: '
fixpoint "--rewrite"

constant adder: (func(0, [int; int; int]))

define adder(x : int, y : int) : int = { x + y }

expand [1 : true]

constraint:
  env []
  lhs {v : int | Bool true }
  rhs {v : int | (adder value: 5 value: 6) === 11 }
  id 1 tag []
'
]
