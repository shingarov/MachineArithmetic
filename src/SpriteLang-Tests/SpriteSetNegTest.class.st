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
