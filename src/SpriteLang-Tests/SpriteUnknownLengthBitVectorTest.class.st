Class {
	#name : #SpriteUnknownLengthBitVectorTest,
	#superclass : #SpriteLangTest,
	#category : #'SpriteLang-Tests-Simple'
}

{ #category : #'tests - binary logic' }
SpriteUnknownLengthBitVectorTest >> test_AndZeroSmashesAnything_01 [
	self proveSafe: '
⟦val main : BitVec(SizeXX) => BitVec(Size32)[v|v === (0///32)]⟧
let main = (x) => {
  let zero = toBitVector(0);
  bvand(zero, x)
};
'
]

{ #category : #'tests - binary logic' }
SpriteUnknownLengthBitVectorTest >> test_AndZeroSmashesAnything_02 [
	self proveSafe: '
⟦val main : BitVec(Size32) => BitVec(SizeXX)[v|v === (0///32)]⟧
let main = (x) => {
  let zero = toBitVector(0);
  bvand(zero, x)
};
'
]

{ #category : #'tests - size changes' }
SpriteUnknownLengthBitVectorTest >> test_Concat_01 [
	self proveSafe: '
⟦val main : BitVec(Size16)[v|v === (16r1234///16)] => BitVec(Size8)[v|v === (16r56///8)] => BitVec(Size24)[v|v === (16r123456///24)]⟧
let main = (x, y) => {
  let res = concat(x, y);
  res
};
'
]

{ #category : #'tests - size changes' }
SpriteUnknownLengthBitVectorTest >> test_Concat_02 [
	self proveSafe: '
⟦val main : BitVec(SizeXX)[v|v === (16r1234///16)] => BitVec(Size8)[v|v === (16r56///8)] => BitVec(Size24)[v|v === (16r123456///24)]⟧
let main = (x, y) => {
  let res = concat(x, y);
  res
};
'
]

{ #category : #'tests - size changes' }
SpriteUnknownLengthBitVectorTest >> test_Extract_01 [
	self proveSafe: '
⟦val main : BitVec(Size32)[v|v === (16rAABBCCDD///32)] => BitVec(Size8)[v|v === (16rCC///8)]⟧
let main = (x) => {
  extract(15, 8, x)
};
'
]

{ #category : #'tests - size changes' }
SpriteUnknownLengthBitVectorTest >> test_Extract_02 [
	self proveSafe: '
⟦val lsb : BitVec(SizeXX)[?] => BitVec(SizeXX)[v|v === (16r1///1)]⟧
let lsb = (x) => {
  extract(0, 0, x)
};
	
⟦val main : BitVec(Size32)[v|v === (16rAABBCCDD///32)] => BitVec(Size1)[v|v === (16r1///1)]⟧
let main = (x) => {
  lsb(x)
};
'
]

{ #category : #'tests - size changes' }
SpriteUnknownLengthBitVectorTest >> test_Extract_03 [
	self proveSafe: '
⟦val main : BitVec(Size32)[v|v === (16r12345678///32)] => BitVec(Size4)[v|v === (16r7///4)]⟧
let main = (x) => {
  let y = extract(7, 0, x);
  let z = extract(7, 4, y);
  z
};
'
]

{ #category : #'tests - size changes' }
SpriteUnknownLengthBitVectorTest >> test_Extract_04 [
	self proveSafe: '
⟦val main : BitVec(Size32)[v|v === (16r12345678///32)] => BitVec(SizeXX)[v|(v repeat: 2) === (16r77///8)]⟧
let main = (x) => {
  let y = extract(7, 0, x);
  let z = extract(7, 4, y);
  z
};
'
]

{ #category : #'tests - arithmetic' }
SpriteUnknownLengthBitVectorTest >> test_MulZeroSmashesAnything_01 [
	self proveSafe: '
⟦val main : BitVec(SizeXX) => BitVec(Size32)[v|v === (0///32)]⟧
let main = (x) => {
  let zero = toBitVector(0);
  bvmul(zero, x)
};
'
]

{ #category : #'tests - arithmetic' }
SpriteUnknownLengthBitVectorTest >> test_MulZeroSmashesAnything_02 [
	self proveSafe: '
⟦val main : BitVec(Size32) => BitVec(SizeXX)[v|v === (0///32)]⟧
let main = (x) => {
  let zero = toBitVector(0);
  bvmul(zero, x)
};
'
]

{ #category : #'tests - unary logic' }
SpriteUnknownLengthBitVectorTest >> test_Not_01 [
	self proveSafe: '
⟦val main : BitVec(Size8)[v|v === (16r0F///8)] => BitVec(Size8)[v|v === (16rF0///8)]⟧
let main = (x) => {
  bvnot(x)
};
'
]

{ #category : #'tests - unary logic' }
SpriteUnknownLengthBitVectorTest >> test_Not_02 [
	self proveSafe: '
⟦val main : BitVec(Size32) => bool[v|v]⟧
let main = (x) => {
  let notX = bvnot(x);
  let xor = bvxor(x, notX);
  let ones = toBitVector(4294967295);
  let ok = xor == ones;
  ok
};
'
]

{ #category : #'tests - unary logic' }
SpriteUnknownLengthBitVectorTest >> test_Not_03 [
	self proveSafe: '
⟦val main : BitVec(SizeXX) => bool[v|v]⟧
let main = (x) => {
  let notX = bvnot(x);
  let xor = bvxor(x, notX);
  let ones = bv(32, 4294967295);
  let ok = xor == ones;
  ok
};
'
]

{ #category : #'tests - size changes' }
SpriteUnknownLengthBitVectorTest >> test_Repeat_01 [
	self proveSafe: '
⟦val main : BitVec(Size8)[v|v === (16rAB///8)] => BitVec(Size32)[v|v === (16rABABABAB///32)]⟧
let main = (x) => {
  repeat(4, x)
};
'
]

{ #category : #'tests - size changes' }
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

{ #category : #'tests - size changes' }
SpriteUnknownLengthBitVectorTest >> test_Repeat_03 [
	self proveSafe: '
⟦val main : BitVec(Size8)[v|v === (16rAB///8)] => BitVec(Size32)[v|v === (16rABABABAB///32)]⟧
let main = (x) => {
  let y = repeat(2, x);
  let z = repeat(2, y);
  z
};
'
]

{ #category : #'tests - size changes' }
SpriteUnknownLengthBitVectorTest >> test_Repeat_03x [
	self proveSafe: '
⟦val main : BitVec(SizeXX)[v|v === (16rAB///8)] => BitVec(Size32)[v|v === (16rABABABAB///32)]⟧
let main = (x) => {
  let y = repeat(2, x);
  let z = repeat(2, y);
  z
};
'
]

{ #category : #'tests - size changes' }
SpriteUnknownLengthBitVectorTest >> test_Repeat_04 [
	self proveSafe: '
⟦val main : int[v|v === 16rAB] => BitVec(Size32)[v|v === (16rABABABAB///32)]⟧
let main = (i) => {
  let x = toBitVector(i);
  let y = repeat(2, x);
  let z = repeat(2, y);
  z
};
'
]

{ #category : #'tests - size changes' }
SpriteUnknownLengthBitVectorTest >> test_Repeat_05 [
	self proveSafe: '
⟦val main : int[v|v === 16rAB] => Set_Set(BitVec(Size32)[v|v === (16rABABABAB///32)])⟧
let main = (i) => {
  let x = toBitVector(i);
  let y = repeat(2, x);
  let z = repeat(2, y);
  Set_sng(z)
};
'
]

{ #category : #'tests - size changes' }
SpriteUnknownLengthBitVectorTest >> test_Repeat_06n [
	self proveSafe: '
⟦val main : BitVec(Size8)[v|v === (16rFF///8)] => Set_Set(int[v|v === -1])⟧
let main = (x) => {
  let y = repeat(2, x);
  let z = repeat(2, y);
  let v = bvSignedValue(z);
  Set_sng(v)
};
'
]

{ #category : #'tests - size changes' }
SpriteUnknownLengthBitVectorTest >> test_Repeat_06p [
	self proveSafe: '
⟦val main : BitVec(Size8)[v|v === (16r12///8)] => Set_Set(int[v|v === 16r12121212])⟧
let main = (x) => {
  let y = repeat(2, x);
  let z = repeat(2, y);
  let v = bvSignedValue(z);
  Set_sng(v)
};
'
]

{ #category : #'tests - size changes' }
SpriteUnknownLengthBitVectorTest >> test_Repeat_07 [
	self proveSafe: '
⟦val main : x:BitVec(SizeXX) => BitVec(Size32)[v|v === (repeat value: 4 value: x)]⟧
let main = (x) => {
  repeat(4, x)
};
'
]

{ #category : #'tests - shifts' }
SpriteUnknownLengthBitVectorTest >> test_Rot_01 [
	self proveSafe: '
⟦val main : BitVec(Size8)[v|v === (16r01///8)] => BitVec(Size8)[v|v === (16r10///8)]⟧
let main = (x) => {
  rotate_left(4, x)
};
'
]

{ #category : #'tests - shifts' }
SpriteUnknownLengthBitVectorTest >> test_Shl_01 [
	self proveSafe: '
⟦val main : BitVec(Size32)[v|v === (16r0F///32)] => BitVec(SizeXX)[v|bvSignedValue∘v === 16rF0]⟧
let main = (x) => {
  let shamt = toBitVector(4);
  bvshl(x, shamt)
};
'
]

{ #category : #'tests - size changes' }
SpriteUnknownLengthBitVectorTest >> test_SignExtend_01 [
	self proveSafe: '
⟦val main : BitVec(Size8)[v|v === (16rAB///8)] => BitVec(Size9)[v|v === (16r1AB///9)]⟧
let main = (x) => {
  sign_extend(1, x)
};
'
]

{ #category : #'tests - size changes' }
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

{ #category : #'tests - size changes' }
SpriteUnknownLengthBitVectorTest >> test_SignExtend_03 [
	self proveSafe: '
⟦val main : BitVec(Size8)[v|v === (16rAB///8)] => BitVec(Size17)[v|v === (16r1FFAB///17)]⟧
let main = (x) => {
  let y = sign_extend(8, x);
  let z = sign_extend(1, y);
  z
};
'
]

{ #category : #'tests - size changes' }
SpriteUnknownLengthBitVectorTest >> test_SignExtend_03xx [
	self proveSafe: '
⟦val main : BitVec(SizeXX)[v|v === (16rAB///8)] => BitVec(Size17)[v|v === (16r1FFAB///17)]⟧
let main = (x) => {
  let y = sign_extend(8, x);
  let z = sign_extend(1, y);
  z
};
'
]

{ #category : #'tests - size changes' }
SpriteUnknownLengthBitVectorTest >> test_SignExtend_04 [
	self proveSafe: '
⟦val main : int[v|v === 16rAB] => BitVec(Size17)[v|v === (16r1FFAB///17)]⟧
let main = (i) => {
  let x = toBitVector(i);
  let y = sign_extend(8, x);
  let z = sign_extend(1, y);
  z
};
'
]

{ #category : #'tests - integer interpretation' }
SpriteUnknownLengthBitVectorTest >> test_SignedValue_01 [
	self proveSafe: '
⟦val main : BitVec(Size16)[v|v === (42///16)] => int[v|v === 42]⟧
let main = (x) => {
  bvSignedValue(x)
};
'
]

{ #category : #'tests - integer interpretation' }
SpriteUnknownLengthBitVectorTest >> test_SignedValue_02 [
	self proveSafe: '
⟦val main : BitVec(Size16)[v|bvSignedValue∘v === 42] => int[v|v === 42]⟧
let main = (x) => {
  bvSignedValue(x)
};
'
]

{ #category : #'tests - comparisons' }
SpriteUnknownLengthBitVectorTest >> test_SquareNotAlwaysNonneg_01 [
	self proveUnsafe: '
⟦val main : BitVec(SizeXX) => BitVec(Size32)[v|bvsge value: v value: 0///32]⟧
let main = (x) => {
  let xSquared = bvmul(x, x);
  xSquared
};
'
]

{ #category : #'tests - comparisons' }
SpriteUnknownLengthBitVectorTest >> test_SquareNotAlwaysNonneg_02 [
	self proveUnsafe: '
⟦val main : BitVec(Size32) => bool[v|v]⟧
let main = (x) => {
  let xSquared = bvmul(x, x);
  let zero = toBitVector(0);
  let ok = bvsge(xSquared, zero);
  ok
};
'
]

{ #category : #'tests - comparisons' }
SpriteUnknownLengthBitVectorTest >> test_SquareNotAlwaysNonneg_03 [
	self proveUnsafe: '
⟦val main : BitVec(SizeXX) => bool[v|v]⟧
let main = (x) => {
  let xSquared = bvmul(x, x);
  let zero = bv(32, 0);
  let ok = bvsge(xSquared, zero);
  ok
};
'
]

{ #category : #'tests - integer interpretation' }
SpriteUnknownLengthBitVectorTest >> test_ToBitVector_01 [
	self proveSafe: '
⟦val main : int[v|v === 42] => BitVec(Size32)[v|v === (42///32)]⟧
let main = (x) => {
  toBitVector(x)
};
'
]

{ #category : #'tests - size changes' }
SpriteUnknownLengthBitVectorTest >> test_ZeroExtend_01 [
	self proveSafe: '
⟦val main : BitVec(Size8)[v|v === (16rAB///8)] => BitVec(Size9)[v|v === (16rAB///9)]⟧
let main = (x) => {
  zero_extend(1, x)
};
'
]

{ #category : #'tests - size changes' }
SpriteUnknownLengthBitVectorTest >> test_ZeroExtend_02 [
	self proveSafe: '
⟦val main : int[v|v === 16rAB] => BitVec(Size9)[v|v === (16rAB///9)]⟧
let main = (x) => {
  let y = toBitVector(x);
  zero_extend(1, y)
};
'
]
