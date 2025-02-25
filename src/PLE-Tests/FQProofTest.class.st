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

{ #category : #tests }
FQProofTest >> testPLE1 [
self skip: 'Issue #439'.
	self provePos: '
fixpoint "--rewrite"

constant foo: (func(1, [@(0)  ; int]))
constant bar: (func(0, [Bob   ; int]))

define foo(x : alpha) : int = { bar (coerce (alpha ~ Bob) x) }
define bar(y : Bob)   : int = { 22 }

expand [1 : True]

bind 0 z : {v: beta | true }

constraint:
  env [0]
  lhs {v : int | true }
  rhs {v : int | (foo z) = 22 }
  id 1 tag []
'
]
