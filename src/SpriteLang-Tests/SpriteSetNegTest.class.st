Class {
	#name : #SpriteSetNegTest,
	#superclass : #SpriteLangNegTest,
	#category : #'SpriteLang-Tests-Simple'
}

{ #category : #tests }
SpriteSetNegTest >> test_Cap_10 [
	self processString: '
⟦val check : int => bool[v|v]⟧
let check = (x) => {
  let ten = Set_sng(10);
  let twenty = Set_sng(20);
  let intersection = Set_cap(ten, twenty);
  let t = Set_mem(10, intersection);
  t
};
'
]

{ #category : #tests }
SpriteSetNegTest >> test_Cup [
	self processString: '
⟦val check : int => bool[v|v]⟧
let check = (x) => {
  let ten = Set_sng(10);
  let twenty = Set_sng(20);
  let both = Set_cup(ten, twenty);
  let t = Set_mem(42, both);
  t
};
'
]

{ #category : #tests }
SpriteSetNegTest >> test_EmptySetHasNoElements [
	self processString: '
⟦val check : x:int => xs:Set_Set(int)[v| v === (Set_empty∘0)] => int[v| Set_mem value: x value: xs ]⟧
let check = (x, xs) => {
  0
};
'
]

{ #category : #tests }
SpriteSetNegTest >> test_PolySingletonPLE [
	" 43 ∉ { 42 } "
	self processString: '
[--check-termination]

⟦reflect singleton : ''a => Set_Set(''a) / [0 toInt]⟧
let rec singleton = (x) => {
  let xs = Set_sng(x);
  xs
};

⟦val check : int => Set_Set(int)[xs|Set_mem value: 43 value: xs]⟧
let check = (x) => {
  let s = singleton(42);
  s
};
'
]

{ #category : #tests }
SpriteSetNegTest >> test_Singleton [
	self processString: '
⟦val check : int => bool[v|v]⟧
let check = (x) => {
  let xs = Set_sng(42);
  let t = Set_mem(43, xs);
  t
};
'
]
