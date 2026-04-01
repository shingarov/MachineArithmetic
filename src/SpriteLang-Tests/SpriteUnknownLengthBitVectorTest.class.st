Class {
	#name : #SpriteUnknownLengthBitVectorTest,
	#superclass : #SpriteLangTest,
	#category : #'SpriteLang-Tests-Simple'
}

{ #category : #tests }
SpriteUnknownLengthBitVectorTest >> test_AndZeroSmashesAnything_01 [
	self proveSafe: '
⟦val main : BitVec(SizeXX) => BitVec(Size32)[v|v === (0///32)]⟧
let main = (x) => {
  let zero = toBitVector(0);
  bvand(zero, x)
};
'
]

{ #category : #tests }
SpriteUnknownLengthBitVectorTest >> test_AndZeroSmashesAnything_02 [
	self proveSafe: '
⟦val main : BitVec(Size32) => BitVec(SizeXX)[v|v === (0///32)]⟧
let main = (x) => {
  let zero = toBitVector(0);
  bvand(zero, x)
};
'
]

{ #category : #tests }
SpriteUnknownLengthBitVectorTest >> test_Concat_01 [
	self proveSafe: '
⟦val main : BitVec(Size16)[v|v === (16r1234///16)] => BitVec(Size8)[v|v === (16r56///8)] => BitVec(Size24)[v|v === (16r123456///24)]⟧
let main = (x, y) => {
  let res = concat(x, y);
  res
};
'
]

{ #category : #tests }
SpriteUnknownLengthBitVectorTest >> test_Repeat_01 [
	self proveSafe: '
⟦val main : BitVec(Size8)[v|v === (16rAB///8)] => BitVec(Size32)[v|v === (16rABABABAB///32)]⟧
let main = (x) => {
  repeat(4, x)
};
'
]

{ #category : #tests }
SpriteUnknownLengthBitVectorTest >> test_Repeat_02 [
	self proveSafe: '
⟦val fourTimes : BitVec(SizeXX)[?] => BitVec(SizeXX)[v|v === (16rABABABAB///32)]⟧
let fourTimes = (x) => {
  repeat(4, x)
};

⟦val main : BitVec(Size8)[v|v === (16rAB///8)] => BitVec(Size32)[v|v === (16rABABABAB///32)]⟧
let main = (x) => {
  fourTimes(x)
};
'
]

{ #category : #tests }
SpriteUnknownLengthBitVectorTest >> test_SignExtend_01 [
	self proveSafe: '
⟦val main : BitVec(Size8)[v|v === (16rAB///8)] => BitVec(Size9)[v|v === (16r1AB///9)]⟧
let main = (x) => {
  sign_extend(1, x)
};
'
]

{ #category : #tests }
SpriteUnknownLengthBitVectorTest >> test_SignExtend_02 [
	self proveSafe: '
⟦val addOneBit : BitVec(SizeXX)[?] => BitVec(SizeXX)[v|v === (16r1AB///9)]⟧
let addOneBit = (x) => {
  sign_extend(1, x)
};

⟦val main : BitVec(Size8)[v|v === (16rAB///8)] => BitVec(Size9)[v|v === (16r1AB///9)]⟧
let main = (x) => {
  addOneBit(x)
};
'
]

{ #category : #tests }
SpriteUnknownLengthBitVectorTest >> test_ZeroExtend [
	self proveSafe: '
⟦val main : BitVec(Size8)[v|v === (16rAB///8)] => BitVec(Size9)[v|v === (16rAB///9)]⟧
let main = (x) => {
  zero_extend(1, x)
};
'
]
