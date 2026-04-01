Class {
	#name : #SpriteBitVectorTest,
	#superclass : #SpriteLangTest,
	#category : #'SpriteLang-Tests-Simple'
}

{ #category : #tests }
SpriteBitVectorTest >> test_Add_01 [
	self proveSafe: '
⟦val main : int => BitVec(Size8)[v|v === (127///8)]⟧
let main = (x) => {
  let a = toBitVector(126);
  let b = toBitVector(1);
  bvadd(a, b)
};
'
]

{ #category : #tests }
SpriteBitVectorTest >> test_Add_02 [
	self should: [
		self proveSafe: '
⟦val main : BitVec(Size8) => BitVec(Size9) => int⟧
let main = (x, y) => {
  let ignored = bvadd(x, y);
  0
};
'
	] raise: Error
]

{ #category : #tests }
SpriteBitVectorTest >> test_Add_03 [
	self proveSafe: '
⟦val main : int => BitVec(Size8)[v|v === (127///8)]⟧
let main = (x) => {
  bv(8, 127)
};
'
]

{ #category : #tests }
SpriteBitVectorTest >> test_Add_03_neg [
	self should: [
		self proveSafe: '
⟦val main : int => BitVec(Size8)[v|v === (127///8)]⟧
let main = (x) => {
  bv(32, 127)
};
'
	] raise: Error
]

{ #category : #tests }
SpriteBitVectorTest >> test_Add_03_neg′ [
	self proveUnsafe: '
⟦val main : int => BitVec(Size8)[v|v === (128///8)]⟧
let main = (x) => {
  bv(8, 127)
};
'
]

{ #category : #tests }
SpriteBitVectorTest >> test_AndZeroSmashesAnything_01 [
	self proveSafe: '
⟦val main : BitVec(Size32) => BitVec(Size32) => BitVec(Size32)⟧
let main = (x, y) => {
  let result = bvand(x, y);
  result
};
'
]

{ #category : #tests }
SpriteBitVectorTest >> test_AndZeroSmashesAnything_02 [
	self proveSafe: '
⟦val main : BitVec(Size32) => BitVec(Size32)[v|v === (0///32)] => BitVec(Size32)[v|v === (0///32)]⟧
let main = (x, y) => {
  let result = bvand(x, y);
  result
};
'
]

{ #category : #tests }
SpriteBitVectorTest >> test_AndZeroSmashesAnything_03 [
	self proveSafe: '
⟦val main : BitVec(Size32) => BitVec(Size32)[v|v === (0///32)]⟧
let main = (x) => {
  let zero = toBitVector(0);
  let result = bvand(x, zero);
  result
};
'
]

{ #category : #tests }
SpriteBitVectorTest >> test_AndZeroSmashesAnything_04 [
	self proveSafe: '
⟦val main : BitVec(Size32) => BitVec(Size32)[v|v === (0///32)]⟧
let main = (x) => {
  let zero = toBitVector(0);
  let result = bvand(zero, x);
  result
};
'
]

{ #category : #tests }
SpriteBitVectorTest >> test_Bvashr [
	"
		bvashr(10001000, 2) =
		       11100010
	"
	self proveSafe: '
⟦val main : BitVec(SizeXX)[v|v === (136///8)] => BitVec(SizeXX)[v|v === (226///8)]⟧
let main = (x) => {
  let shamt = toBitVector(2);
  bvashr(x, shamt)
};
'
]

{ #category : #tests }
SpriteBitVectorTest >> test_Bvlshr [
	"
		bvashr(10001000, 2) =
		       00100010
	"
	self proveSafe: '
⟦val main : BitVec(SizeXX)[v|v === (136///8)] => BitVec(SizeXX)[v|v === (34///8)]⟧
let main = (x) => {
  let shamt = toBitVector(2);
  bvlshr(x, shamt)
};
'
]

{ #category : #tests }
SpriteBitVectorTest >> test_Bvneg [
	self proveSafe: '
⟦val main : BitVec(Size8) => BitVec(Size8)[v|v === (16rFF///8)]⟧
let main = (arg) => {
  let x = bv(8, 1);
  bvneg(x)
};
'
]

{ #category : #tests }
SpriteBitVectorTest >> test_Bvnot [
	self proveSafe: '
⟦val main : BitVec(Size8) => BitVec(Size8)[v|v === (16rF0///8)]⟧
let main = (arg) => {
  let x = bv(8, 15);
  bvnot(x)
};
'
]

{ #category : #tests }
SpriteBitVectorTest >> test_Create [
	self proveSafe: '
⟦val int8 : BitVec(Size8)[v|v === (127///8)]⟧
let int8 = toBitVector(127);
'
]

{ #category : #tests }
SpriteBitVectorTest >> test_RotateLeft [
	"
		16r12345678 bitRotateLeft: 4  ->
		16r23456781
	"
	self proveSafe: '
⟦val main : BitVec(Size32)[v|v === (16r12345678///32)] => BitVec(Size32)[v|v === (16r23456781///32)]⟧
let main = (x) => {
  rotate_left(4, x)
};
'
]

{ #category : #tests }
SpriteBitVectorTest >> test_RotateRight [
	"
		16r12345678 bitRotateLeft: 4  ->
		16r812345678
	"
	self proveSafe: '
⟦val main : BitVec(Size32)[v|v === (16r12345678///32)] => BitVec(Size32)[v|v === (16r81234567///32)]⟧
let main = (x) => {
  rotate_right(4, x)
};
'
]

{ #category : #tests }
SpriteBitVectorTest >> test_ShiftLeft_01 [
	"
		00000001 bitShiftLeft: 2  ->
		00000100
	"
	self proveSafe: '
⟦val main : BitVec(Size8) => BitVec(Size8)[v|v === (4///8)]⟧
let main = (x) => {
  let one   = toBitVector(1);
  let shamt = toBitVector(2);
  let result = bvshl(one, shamt);
  result
};
'
]

{ #category : #tests }
SpriteBitVectorTest >> test_ShiftLeft_02 [
	"Z3 bvshl does not extend: whatever hangs and falls, is lost.
		00000001 bitShiftLeft: 10  ->
		00000000
	"
	self proveSafe: '
⟦val main : BitVec(Size8) => BitVec(Size8)[v|v === (0///8)]⟧
let main = (x) => {
  let one   = toBitVector(1);
  let shamt = toBitVector(10);
  let result = bvshl(one, shamt);
  result
};
'
]
