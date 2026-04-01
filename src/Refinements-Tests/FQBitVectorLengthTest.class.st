Class {
	#name : #FQBitVectorLengthTest,
	#superclass : #FQTest,
	#category : #'Refinements-Tests'
}

{ #category : #tests }
FQBitVectorLengthTest >> test_32rotateIsNot33 [
	self should: [self provePos: '
bind 0 x : {v : (BitVec SizeXX) | v === (16r12345678 /// 32)}
bind 1 y : {v : (BitVec Size33) | v === (x bitRotateLeft: 4)}
bind 2 z : {v : (BitVec Size33) | v === (16r23456781 /// 33)}

constraint:
  env [0;1;2]
  lhs {v : (BitVec Size33) | v === y }
  rhs {v : (BitVec Size33) | v === z }
  id 1 tag []
'] raise: Incompatible
]

{ #category : #tests }
FQBitVectorLengthTest >> test_4repeat2isNot9 [
	self should: [self provePos: '
bind 0 x : {v : (BitVec Size4) | v === (2r1000 /// 4)}
bind 1 y : {v : (BitVec Size9) | v === (x repeat: 2)}
bind 2 z : {v : (BitVec Size9) | v === (2r10001000 /// 9)}

constraint:
  env [0;1;2]
  lhs {v : (BitVec Size9) | v === y }
  rhs {v : (BitVec Size9) | v === z }
  id 1 tag []
'] raise: Incompatible
]

{ #category : #tests }
FQBitVectorLengthTest >> test_inferRepeatArgLength [
	self provePos: '
bind 0 x : {v : (BitVec SizeXX) | v === (2r1000 /// 4)}
bind 1 y : {v : (BitVec Size8) | v === (x repeat: 2)}
bind 2 z : {v : (BitVec Size8) | v === (2r10001000 /// 8)}

constraint:
  env [0;1;2]
  lhs {v : (BitVec Size8) | v === y }
  rhs {v : (BitVec Size8) | v === z }
  id 1 tag []
'
]

{ #category : #tests }
FQBitVectorLengthTest >> test_inferRepeatResultLength [
	self provePos: '
bind 0 x : {v : (BitVec Size4) | v === (2r1000 /// 4)}
bind 1 y : {v : (BitVec SizeXX) | v === (x repeat: 2)}
bind 2 z : {v : (BitVec Size8) | v === (2r10001000 /// 8)}

constraint:
  env [0;1;2]
  lhs {v : (BitVec Size8) | v === y }
  rhs {v : (BitVec Size8) | v === z }
  id 1 tag []
'
]

{ #category : #tests }
FQBitVectorLengthTest >> test_inferRotateArgLength [
	self provePos: '
bind 0 x : {v : (BitVec SizeXX) | v === (16r12345678 /// 32)}
bind 1 y : {v : (BitVec Size32) | v === (x bitRotateLeft: 4)}
bind 2 z : {v : (BitVec Size32) | v === (16r23456781 /// 32)}

constraint:
  env [0;1;2]
  lhs {v : (BitVec Size32) | v === y }
  rhs {v : (BitVec Size32) | v === z }
  id 1 tag []
'
]

{ #category : #tests }
FQBitVectorLengthTest >> test_inferRotateResultLength [
	self provePos: '
bind 0 x : {v : (BitVec Size32) | v === (16r12345678 /// 32)}
bind 1 y : {v : (BitVec SizeXX) | v === (x bitRotateLeft: 4)}
bind 2 z : {v : (BitVec Size32) | v === (16r23456781 /// 32)}

constraint:
  env [0;1;2]
  lhs {v : (BitVec Size32) | v === y }
  rhs {v : (BitVec Size32) | v === z }
  id 1 tag []
'
]

{ #category : #tests }
FQBitVectorLengthTest >> test_int2bv2repeat [
	self provePos: '
bind 1 x : {v : (BitVec SizeXX) | v === (toBitVector ∘ 16rABCD toInt)}
bind 2 z : {v : (BitVec Size64) | v === (16r0000ABCD0000ABCD /// 64)}

constraint:
  env [1;2]
  lhs {v : (BitVec SizeXX) | v === (x repeat: 2) }
  rhs {v : (BitVec Size64) | v === z }
  id 1 tag []
'
]

{ #category : #tests }
FQBitVectorLengthTest >> test_intConst2bv [
	self provePos: '
bind 1 x : {v : (BitVec Size32) | v === (toBitVector ∘ 42 toInt)}
bind 2 z : {v : (BitVec Size32)  | v === (42 /// 32)}

constraint:
  env [1;2]
  lhs {v : (BitVec Size32) | v === x }
  rhs {v : (BitVec Size32) | v === z }
  id 1 tag []
'
]

{ #category : #tests }
FQBitVectorLengthTest >> test_noUnify4repeat2and9 [
	self should: [self provePos: '
bind 0 x : {v : (BitVec Size4) | v === (2r1000 /// 4)}
bind 1 y : {v : (BitVec SizeXX) | v === (x repeat: 2)}
bind 2 z : {v : (BitVec SizeXX) | v === (2r10001000 /// 9)}

constraint:
  env [0;1;2]
  lhs {v : (BitVec Size9) | v === y }
  rhs {v : (BitVec Size9) | v === z }
  id 1 tag []
'
] raise: Incompatible
]
