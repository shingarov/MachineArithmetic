Class {
	#name : #SpriteSetPosTest,
	#superclass : #SpriteLangPosTest,
	#category : #'SpriteLang-Tests-Simple'
}

{ #category : #tests }
SpriteSetPosTest >> test_Cup_10 [
	self processString: '
⟦val check : int => bool[v|v]⟧
let check = (x) => {
  let ten = Set_sng(10);
  let twenty = Set_sng(20);
  let both = Set_cup(ten, twenty);
  let t = Set_mem(10, both);
  t
};
'
]

{ #category : #tests }
SpriteSetPosTest >> test_Cup_20 [
	self processString: '
⟦val check : int => bool[v|v]⟧
let check = (x) => {
  let ten = Set_sng(10);
  let twenty = Set_sng(20);
  let both = Set_cup(ten, twenty);
  let t = Set_mem(20, both);
  t
};
'
]

{ #category : #tests }
SpriteSetPosTest >> test_EmptySetHasNoElements_00 [
	self processString: '
⟦val check : x:int => xs:Set_Set(int)[v| v === (Set_empty∘0)] => int[v| (Set_mem value: x value: xs) not ]⟧
let check = (x, xs) => {
  0
};
'
]

{ #category : #tests }
SpriteSetPosTest >> test_EmptySetHasNoElements_01 [
	self processString: '
⟦val not : x:bool => bool[v|x <=> v not]⟧
let not = (x) => { if (x) {false} else {true} };

⟦val check : x:int => xs:Set_Set(int)[v| v === (Set_empty∘0)] => bool[v|v]⟧
let check = (x, xs) => {
  let t = Set_mem(x, xs);
  not(t)
};
'
]

{ #category : #tests }
SpriteSetPosTest >> test_EmptySetHasNoElements_02 [
	self processString: '
⟦val not : x:bool => bool[v|x <=> v not]⟧
let not = (x) => { if (x) {false} else {true} };

⟦val check : x:int => bool[v|v]⟧
let check = (x) => {
  let xs = Set_empty(0);
  let t = Set_mem(x, xs);
  not(t)
};
'
]

{ #category : #tests }
SpriteSetPosTest >> test_PolySingleton [
	self processString: '
⟦val singleton : ''a => Set_Set(''a)⟧
let singleton = (x) => {
  let xs = Set_sng(x);
  xs
};

⟦val check : int => Set_Set(int)⟧
let check = (x) => {
  let s = singleton(42);
  s
};
'
]

{ #category : #tests }
SpriteSetPosTest >> test_PolySingletonOrEmpty [
	" 43 ∈ { 42 } "
	self processString: '
[--check-termination]

⟦val singleton : ''a => Set_Set(''a)⟧
let singleton = (x) => {
  let xs = Set_sng(x);
  xs
};
⟦val singletonOrEmpty : ''a => Set_Set(''a)⟧
let singletonOrEmpty = (x) => {
  let single = 2 > 1;
  if (single) {
    singleton(x)
  } else { 
    Set_empty(0)
  }
};
'
]

{ #category : #tests }
SpriteSetPosTest >> test_PolySingletonOrEmptyPLE [
	" 43 ∈ { 42 } "
	self processString: '
[--check-termination]
⟦reflect singleton : ''a => Set_Set(''a) / [0 toInt]⟧
let rec singleton = (x) => {
  let xs = Set_sng(x);
  xs
};
⟦reflect singletonOrEmpty : ''a => Set_Set(''a) / [0 toInt]⟧
let rec singletonOrEmpty = (x) => {
  let single = 2 > 1;
  if (single) {
    singleton(x)
  } else { 
    Set_empty(0)
  }
};
⟦val check : int => Set_Set(int)[xs|Set_mem value: 42 value: xs]⟧
let check = (x) => {
  let s = singletonOrEmpty(42);
  s
};
'
]

{ #category : #tests }
SpriteSetPosTest >> test_PolySingletonPLE [
	" 43 ∈ { 42 } "
	self processString: '
[--check-termination]

⟦reflect singleton : ''a => Set_Set(''a) / [0 toInt]⟧
let rec singleton = (x) => {
  let xs = Set_sng(x);
  xs
};

⟦val check : int => Set_Set(int)[xs|Set_mem value: 42 value: xs]⟧
let check = (x) => {
  let s = singleton(42);
  s
};
'
]

{ #category : #tests }
SpriteSetPosTest >> test_Singleton [
	self processString: '
⟦val check : int => bool[v|v]⟧
let check = (x) => {
  let xs = Set_sng(42);
  let t = Set_mem(42, xs);
  t
};
'
]

{ #category : #tests }
SpriteSetPosTest >> test_Singleton_HM_1 [
	self processString: '
⟦val main : int => Set_Set(int)⟧
let main = (x) => {
  Set_sng(x)
};
'
]

{ #category : #tests }
SpriteSetPosTest >> test_Singleton_HM_1dep1 [
	self processString: '
⟦val main : a:int => Set_Set(int[v|v===a])⟧
let main = (x) => {
  Set_sng(x)
};
'
]

{ #category : #tests }
SpriteSetPosTest >> test_Singleton_HM_1dep2 [
	self processString: '
⟦val main : a:int => Set_Set(int)[v|Set_mem value: a value: v]⟧
let main = (x) => {
  Set_sng(x)
};
'
]

{ #category : #tests }
SpriteSetPosTest >> test_Singleton_HM_2 [
	self processString: '
⟦val main : ''a => Set_Set(''a)⟧
let main = (x) => {
  Set_sng(x)
};
'
]
