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
