Class {
	#name : #FQTheoryApplicationTest,
	#superclass : #FQTest,
	#category : #'Refinements-Tests'
}

{ #category : #tests }
FQTheoryApplicationTest >> test_bvConst [
	self provePos: '
bind 0  x : {v : (BitVec Size32) | v === (16r12345678 /// 32)}

constraint:
  env [0]
  lhs {v : Int | Bool true }
  rhs {v : Int | ((bv value: 32) value: 16r12345678) === x }
  id 4 tag []
'
]

{ #category : #tests }
FQTheoryApplicationTest >> test_bvand [
	self provePos: '
bind 4 x : {v : (BitVec Size60) | v === (16r00000000000000f /// 60)}
bind 5 y : {v : (BitVec Size60) | v === (16r0000000000000f0 /// 60)}
bind 6 z : {v : (BitVec Size60) | v === (16r000000000000000 /// 60)}

constraint:
  env [4;5;6]
  lhs {v : (BitVec Size60) | v === (bvand value: x value: y) }
  rhs {v : (BitVec Size60) | v === z }
  id 1 tag []
'
]

{ #category : #tests }
FQTheoryApplicationTest >> test_concat [
	self provePos: '
bind 0  x : {v : (BitVec Size16) | v === (16r1234 /// 16)}
bind 1  y : {v : (BitVec Size16) | v === (16r5678 /// 16)}
bind 2  z : {v : (BitVec Size32) | v === (16r12345678 /// 32)}

constraint:
  env [0;1;2]
  lhs {v : (BitVec Size32) | v === z }
  rhs {v : (BitVec Size32) | v === (concat value: x value: y) }
  id 4 tag []
'
]

{ #category : #tests }
FQTheoryApplicationTest >> test_extract [
	self provePos: '
bind 0  x : {v : (BitVec Size4) | v === (2r1000 /// 4)}
bind 10 z : {v : (BitVec Size2) | v === (2r10 /// 2)}

constraint:
  env [0;10]
  lhs {v : (BitVec Size4) | v === x }
  rhs {v : (BitVec Size4) | ((extract value: 3) value: 2 value: v) === z }
  id 4 tag []
'
]

{ #category : #tests }
FQTheoryApplicationTest >> test_repeat [
	self provePos: '
bind 1 x : {v : (BitVec Size16) | v === (16r1234 /// 16)}
bind 2 z : {v : (BitVec Size32) | v === (16r12341234 /// 32)}

constraint:
  env [1;2]
  lhs {v : (BitVec Size32) | v === (repeat value: 2 toInt value: x) }
  rhs {v : (BitVec Size32) | v === z }
  id 1 tag []
'
]

{ #category : #tests }
FQTheoryApplicationTest >> test_repeat2 [
	self provePos: '
bind 1 x : {v : (BitVec Size16) | v === (16r1234 /// 16)}
bind 2 z : {v : (BitVec Size32) | v === (16r12341234 /// 32)}

constraint:
  env [1;2]
  lhs {v : (BitVec SizeXX) | v === (repeat value: 2 toInt value: x) }
  rhs {v : (BitVec Size32) | v === z }
  id 1 tag []
'
]

{ #category : #tests }
FQTheoryApplicationTest >> test_repeat3 [
	self provePos: '
bind 1 x : {v : (BitVec SizeXX) | v === (16r1234 /// 16)}
bind 2 z : {v : (BitVec Size32) | v === (16r12341234 /// 32)}

constraint:
  env [1;2]
  lhs {v : (BitVec Size32) | v === (repeat value: 2 toInt value: x) }
  rhs {v : (BitVec Size32) | v === z }
  id 1 tag []
'
]

{ #category : #tests }
FQTheoryApplicationTest >> test_repeat4 [
	self provePos: '
bind 1 x : {v : (BitVec Size16) | v === (16r1234 /// 16)}
bind 2 z : {v : (BitVec Size32) | v === (16r12341234 /// 32)}

constraint:
  env [1;2]
  lhs {v : (BitVec Size32) | v === (repeat value: 2 value: x) }
  rhs {v : (BitVec Size32) | v === z }
  id 1 tag []
'
]

{ #category : #tests }
FQTheoryApplicationTest >> test_sign_extend [
	self provePos: '
bind 0 x : {v : (BitVec Size4) | v === (2r1000 /// 4)}
bind 4 z : {v : (BitVec Size6) | v === (2r111000 /// 6)}

constraint:
  env [0;4]
  lhs {v : (BitVec Size4) | v === x }
  rhs {v : (BitVec Size6) | (sign_extend value: 2 value: v) === z }
  id 1 tag []
'
]

{ #category : #tests }
FQTheoryApplicationTest >> test_symConstant [
	self provePos: '
bind 0  x : {v : int | v === (symConstant ∘ ''a'' toZ3String)}

constraint:
  env [0]
  lhs {v : Int | v === x }
  rhs {v : Int | v === ''a'' toInt }
  id 1 tag []
'
]

{ #category : #tests }
FQTheoryApplicationTest >> test_zero_extend [
	self provePos: '
bind 0 x : {v : (BitVec Size4) | v === (2r1000 /// 4)}
bind 4 z : {v : (BitVec Size6) | v === (2r001000 /// 6)}

constraint:
  env [0;4]
  lhs {v : (BitVec Size4) | v === x }
  rhs {v : (BitVec Size6) | (zero_extend value: 2 value: v) === z }
  id 1 tag []
'
]
