Class {
	#name : #SpritePUnknownTest,
	#superclass : #SpriteLangTest,
	#category : #'SpriteLang-Tests-Simple'
}

{ #category : #tests }
SpritePUnknownTest >> test_constrained00 [
	self proveSafe: '
⟦val main: int => int[v|v === 42]⟧
let main = (arg) => {
  ⟦val zz39: int[v|v === 42]⟧
  let zz39 = 42;
  zz39
};
'
]

{ #category : #tests }
SpritePUnknownTest >> test_constrained01 [
	self proveSafe: '
type point =
  | P (x:int, y:int)
  ;

⟦val check : m:int => int⟧
let check = (m) => {
    ⟦val zz39: P⟧
    let zz39 = □;
    switch (zz39){
      | P(px, py) => px
    }
};
'
]

{ #category : #tests }
SpritePUnknownTest >> test_unconstrained00 [
	self proveUnsafe: '
⟦val main: int => int[v|v === 42]⟧
let main = (arg) => {
  ⟦val zz39: int⟧
  let zz39 = 42;
  zz39
};
'
]

{ #category : #tests }
SpritePUnknownTest >> test_unconstrained01 [
	self proveUnsafe: '
⟦val main: int => int[v|v === 42]⟧
let main = (arg) => {
  ⟦val zz39: int⟧
  let zz39 = □;
  zz39
};
'
]

{ #category : #tests }
SpritePUnknownTest >> test_unconstrained02 [
	self proveUnsafe: '
⟦val main: int => BitVec(Size32)[v|v === (42///32)]⟧
let main = (arg) => {
  ⟦val zz39: BitVec(Size32)⟧
  let zz39 = toBitVector(42);
  zz39
};
'
]

{ #category : #tests }
SpritePUnknownTest >> test_unconstrained03 [
	self proveUnsafe: '
⟦val main: int => BitVec(Size32)[v|v === (42///32)]⟧
let main = (arg) => {
  ⟦val zz39: BitVec(Size32)⟧
  let zz39 = □;
  zz39
};
'
]
