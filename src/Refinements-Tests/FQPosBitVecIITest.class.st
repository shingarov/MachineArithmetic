Class {
	#name : #FQPosBitVecIITest,
	#superclass : #FQPosTest,
	#category : #'Refinements-Tests'
}

{ #category : #tests }
FQPosBitVecIITest >> test0_rotate_right [
	self provePos: '
bind 0 x : {v : (BitVec Size4) | v === (2r1000 /// 4)}
bind 1 y : {v : (BitVec Size4) | v === (x bitRotateRight: 7)}
bind 2 z : {v : (BitVec Size4) | v === (2r0001 /// 4)}

constraint:
  env [0;1;2]
  lhs {v : (BitVec Size4) | v === y }
  rhs {v : (BitVec Size4) | v === z }
  id 0 tag []
'
]

{ #category : #tests }
FQPosBitVecIITest >> test1_zero_extend [
	self provePos: '
bind 0 x : {v : (BitVec Size4) | v === (2r1000 /// 4)}
bind 3 y : {v : (BitVec Size6) | v === (x zeroExtend: 2)}
bind 4 z : {v : (BitVec Size6) | v === (2r001000 /// 6)}

constraint:
  env [0;3;4]
  lhs {v : (BitVec Size6) | v === y }
  rhs {v : (BitVec Size6) | v === z }
  id 1 tag []
'
]

{ #category : #tests }
FQPosBitVecIITest >> test2_sign_extend [
	self provePos: '
bind 0 x : {v : (BitVec Size4) | v === (2r1000 /// 4)}
bind 5 y : {v : (BitVec Size6) | v === (x signExtend: 2)}
bind 6 z : {v : (BitVec Size6) | v === (2r111000 /// 6)}

constraint:
  env [0;5;6]
  lhs {v : (BitVec Size6) | v === y }
  rhs {v : (BitVec Size6) | v === z }
  id 2 tag []
'
]

{ #category : #tests }
FQPosBitVecIITest >> test3_repeat [
	self provePos: '
bind 0 x : {v : (BitVec Size4) | v === (2r1000 /// 4)}
bind 7 y : {v : (BitVec Size8) | v === (x repeat: 2)}
bind 8 z : {v : (BitVec Size8) | v === (2r10001000 /// 8)}


constraint:
  env [0;7;8]
  lhs {v : (BitVec Size8) | v === y }
  rhs {v : (BitVec Size8) | v === z }
  id 3 tag []
'
]

{ #category : #tests }
FQPosBitVecIITest >> test4_extract [
	self provePos: '
bind 0  x : {v : (BitVec Size4) | v === (2r1000 /// 4)}
bind 9  y : {v : (BitVec Size2) | v === (x copyFrom: 3 to: 2)}
bind 10 z : {v : (BitVec Size2) | v === (2r10 /// 2)}

constraint:
  env [0;9;10]
  lhs {v : (BitVec Size2) | v === y }
  rhs {v : (BitVec Size2) | v === z }
  id 4 tag []
'
]
