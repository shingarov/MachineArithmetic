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
SpriteBitVectorTest >> test_Create [
	self proveSafe: '
⟦val int8 : BitVec(Size8)[v|v === (127///8)]⟧
let int8 = toBitVector(127);
'
]

{ #category : #tests }
SpriteBitVectorTest >> test_IAdd [
	self proveUnsafe: '
⟦val iadd : BitVec(Size32) => BitVec(Size32) => BitVec(Size32)⟧
let iadd = (c1,c2) => {
		bvadd(c1,c2)
};	
		
⟦val check01 : bool[b|b]⟧
let check01 = {
				let two = toBitVector(2);
				let got = iadd(two, two);
				let exp = toBitVector(4);
				got == exp
};
'
]

{ #category : #tests }
SpriteBitVectorTest >> test_IAdd_Reflect [
	self proveSafe: '
⟦reflect iadd : BitVec(Size32) => BitVec(Size32) => BitVec(Size32) / [0 toInt]⟧
let iadd = (c1,c2) => {
		bvadd(c1,c2)
};	
		
⟦val check01 : bool[b|b]⟧
let check01 = {
				let two = toBitVector(2);
				let got = iadd(two, two);
				let exp = toBitVector(4);
				got == exp
};
'
]

{ #category : #tests }
SpriteBitVectorTest >> test_IAdd_Reflect_02 [
	self proveSafe: '
⟦reflect iadd : BitVec(Size32) => BitVec(Size32) => BitVec(Size32) / [0]⟧
let iadd = (c1,c2) => {
		bvadd(c1,c2)
};	
		
⟦val check02 : BitVec(Size32) => BitVec(Size32) => bool[b|b] ⟧
let check02 = (x , y) => { 
				let got = iadd(x, y);
				let exp = bvadd(x,y);
				got == exp
};
'
]

{ #category : #tests }
SpriteBitVectorTest >> test_IAdd_neg [
	self proveUnsafe: '
⟦val iadd : BitVec(Size32) => BitVec(Size32) => BitVec(Size32)⟧
let iadd = (c1,c2) => {
		bvadd(c1,c2)
};	
		
⟦val check01 : bool[b|b]⟧
let check01 = {
				let two = toBitVector(2);
				let got = iadd(two, two);
				let exp = toBitVector(4);
				got == exp
};
'
]

{ #category : #tests }
SpriteBitVectorTest >> test_IAdd_neg_02 [
	self proveUnsafe: '
⟦val iadd : x:BitVec(Size32) => y:BitVec(Size32) => BitVec(Size32)⟧
let iadd = (c1,c2) => {
		bvadd(c1,c2)
};	
		
⟦val check02 : BitVec(Size32) => BitVec(Size32) => bool[b|b] ⟧
let check02 = (x , y) => { 
				let got = iadd(x, y);
				let exp = bvadd(x,y);
				got == exp
};
'
]

{ #category : #tests }
SpriteBitVectorTest >> test_IAdd_pos [
	self proveSafe: '
⟦val iadd : x:BitVec(Size32) => y:BitVec(Size32) => BitVec(Size32)[v | v === (bvadd value: x value: y)]⟧
let iadd = (c1,c2) => {
		bvadd(c1,c2)
};	
		
⟦val check01 : bool[b|b]⟧
let check01 = {
				let two = toBitVector(2);
				let got = iadd(two, two);
				let exp = toBitVector(4);
				got == exp
};
'
]

{ #category : #tests }
SpriteBitVectorTest >> test_IAdd_pos_02 [
	self proveSafe: '
⟦val iadd : x:BitVec(Size32) => y:BitVec(Size32) => BitVec(Size32)[v | v === (bvadd value: x value: y)]⟧
let iadd = (c1,c2) => {
		bvadd(c1,c2)
};	
		
⟦val check02 : BitVec(Size32) => BitVec(Size32) => bool[b|b] ⟧
let check02 = (x , y) => { 
				let got = iadd(x, y);
				let exp = bvadd(x,y);
				got == exp
};
'
]

{ #category : #tests }
SpriteBitVectorTest >> test_IAdd_rec [
	self proveSafe: '
[--check-termination]

⟦val iadd : x:BitVec(Size32) => y:BitVec(Size32) => BitVec(Size32)[v | v === (bvadd value: x value: y)] / [0 toInt]⟧
let rec iadd = (c1,c2) => {
		bvadd(c1,c2)
};	
		
⟦val check01 : bool[b|b]⟧
let check01 = {
				let two = toBitVector(2);
				let got = iadd(two, two);
				let exp = toBitVector(4);
				got == exp
};
'
]
