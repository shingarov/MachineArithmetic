Class {
	#name : #FQPosBitVecTest,
	#superclass : #FQPosTest,
	#category : #'Refinements-Tests'
}

{ #category : #tests }
FQPosBitVecTest >> test0_bitOr [
	self provePos: '
bind 0 x : {v : (BitVec Size32) | v === (16r0000000f /// 32)}
bind 1 y : {v : (BitVec Size32) | v === (16r000000f0 /// 32)}
bind 2 z : {v : (BitVec Size32) | v === (16r000000ff /// 32)}

constraint:
  env [0;1;2]
  lhs {v : (BitVec Size32) | v === (x bitOr: y) }
  rhs {v : (BitVec Size32) | v === z }
  id 0 tag []
'
]

{ #category : #tests }
FQPosBitVecTest >> test1_bitAnd [
	self provePos: '
bind 4 x : {v : (BitVec Size60) | v === (16r00000000000000f /// 60)}
bind 5 y : {v : (BitVec Size60) | v === (16r0000000000000f0 /// 60)}
bind 6 z : {v : (BitVec Size60) | v === (16r000000000000000 /// 60)}

constraint:
  env [4;5;6]
  lhs {v : (BitVec Size60) | v === (x bitAnd: y) }
  rhs {v : (BitVec Size60) | v === z }
  id 1 tag []
'
]

{ #category : #tests }
FQPosBitVecTest >> test2_bitXnor [
	self provePos: '
bind 7 x : {v : (BitVec Size4) | v === (16r5 /// 4)}
bind 8 y : {v : (BitVec Size4) | v === (16rb /// 4)}
bind 9 z : {v : (BitVec Size4) | v === (16r1 /// 4)}

constraint:
  env [7;8;9]
  lhs {v : (BitVec Size4) | v === (x bitXnor: y) }
  rhs {v : (BitVec Size4) | v === z }
  id 2 tag []
'
]

{ #category : #tests }
FQPosBitVecTest >> test3_bitInvert [
	self provePos: '
bind 10 x : {v : (BitVec Size4) | v === (16r4 /// 4)}
bind 11 y : {v : (BitVec Size4) | v === (16rb /// 4)}

constraint:
  env [10;11]
  lhs {v : (BitVec Size4) | v === x bitInvert }
  rhs {v : (BitVec Size4) | v === y & (y ~== x negated) }
  id 3 tag []
'
]

{ #category : #tests }
FQPosBitVecTest >> test4_negated [
	self provePos: '
bind 12 x : {v : (BitVec Size4) | v === (16r4 /// 4)}
bind 13 y : {v : (BitVec Size4) | v === (16rc /// 4)}

constraint:
  env [12;13]
  lhs {v : (BitVec Size4) | v === x negated }
  rhs {v : (BitVec Size4) | v === y & (y ~== x bitInvert) }
  id 4 tag []
'
]

{ #category : #tests }
FQPosBitVecTest >> test5_and_commutes [
	self provePos: '
bind 14 x : {v : (BitVec Size4) | Bool true}
bind 15 y : {v : (BitVec Size4) | Bool true}

constraint:
  env [14;15]
  lhs {v : (BitVec Size4) | v === (x bitAnd: y) }
  rhs {v : (BitVec Size4) | v === (y bitAnd: x) }
  id 5 tag []
'
]

{ #category : #tests }
FQPosBitVecTest >> test6_bitShiftRight [
	self provePos: '
bind 16 x : {v : (BitVec Size4) | v === (2r1010 /// 4)}
bind 17 y : {v : (BitVec Size4) | v === (16r1 /// 4)}
bind 18 z : {v : (BitVec Size4) | v === (2r0101 /// 4)}

constraint:
  env [16;17;18]
  lhs {v : (BitVec Size4) | v === (x bitShiftRight: y) }
  rhs {v : (BitVec Size4) | v === z }
  id 6 tag []
'
]

{ #category : #tests }
FQPosBitVecTest >> test7_ult [
	self provePos: '
bind 16 x : {v : (BitVec Size4) | v === (2r1010 /// 4)}
bind 18 z : {v : (BitVec Size4) | v === (2r0101 /// 4)}

constraint:
  env [16;18]
  lhs {v : (BitVec Size4) | v === z }
  rhs {v : (BitVec Size4) | v === z & (z <+ x) }
  id 7 tag []
'
]

{ #category : #tests }
FQPosBitVecTest >> test8_concat [
	self provePos: '
bind 16 x : {v : (BitVec Size4) | v === (2r1010 /// 4)}
bind 17 y : {v : (BitVec Size4) | v === (2r0001 /// 4)}
bind 19 z : {v : (BitVec Size8) | v === (2r10100001 /// 8)}

constraint:
  env [16;17;19]
  lhs {v : (BitVec Size8) | v === (x, y) }
  rhs {v : (BitVec Size8) | v === z }
  id 8 tag []
'
]

{ #category : #tests }
FQPosBitVecTest >> test9_bvcomp [
	self skip: 'Issue #462'
]
