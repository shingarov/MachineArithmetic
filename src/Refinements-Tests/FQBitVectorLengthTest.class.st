Class {
	#name : #FQBitVectorLengthTest,
	#superclass : #FQTest,
	#category : #'Refinements-Tests'
}

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
	[ self provePos: '
bind 0 x : {v : (BitVec SizeXX) | v === (2r1000 /// 4)}
bind 1 y : {v : (BitVec Size8) | v === (x repeat: 2)}
bind 2 z : {v : (BitVec Size8) | v === (2r10001000 /// 8)}

constraint:
  env [0;1;2]
  lhs {v : (BitVec Size8) | v === y }
  rhs {v : (BitVec Size8) | v === z }
  id 1 tag []
' ] runReader: #bvLengthInference initialState: BvLengthInference new
]

{ #category : #tests }
FQBitVectorLengthTest >> test_inferRepeatResultLength [
	[ self provePos: '
bind 0 x : {v : (BitVec Size4) | v === (2r1000 /// 4)}
bind 1 y : {v : (BitVec SizeXX) | v === (x repeat: 2)}
bind 2 z : {v : (BitVec Size8) | v === (2r10001000 /// 8)}

constraint:
  env [0;1;2]
  lhs {v : (BitVec Size8) | v === y }
  rhs {v : (BitVec Size8) | v === z }
  id 1 tag []
' ] runReader: #bvLengthInference initialState: BvLengthInference new
]

{ #category : #tests }
FQBitVectorLengthTest >> test_noUnify4repeat2and9 [
	self should: [[self provePos: '
bind 0 x : {v : (BitVec Size4) | v === (2r1000 /// 4)}
bind 1 y : {v : (BitVec SizeXX) | v === (x repeat: 2)}
bind 2 z : {v : (BitVec SizeXX) | v === (2r10001000 /// 9)}

constraint:
  env [0;1;2]
  lhs {v : (BitVec Size9) | v === y }
  rhs {v : (BitVec Size9) | v === z }
  id 1 tag []
']  runReader: #bvLengthInference initialState: BvLengthInference new ]
raise: Incompatible
]
