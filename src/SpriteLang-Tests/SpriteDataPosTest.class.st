Class {
	#name : #SpriteDataPosTest,
	#superclass : #SpriteLangPosTest,
	#category : #'SpriteLang-Tests-Simple'
}

{ #category : #'tests-logic' }
SpriteDataPosTest >> test_A_is_A [
	self processString: '
type a_or_b =
  | A (b:bool) => [v|v === (A value: b)]
  | B (i:int) => [v|v === (B value: i)]
  ;

⟦val is_a : a_or_b => bool[b|b]⟧
let is_a = (x) => {
  let a = A(false);
  switch(a){
    | A(i) => true
    | B(j) => false
  }
};
'
]

{ #category : #'tests-bv' }
SpriteDataPosTest >> test_MaybeBV_01 [
	self processString: '
type maybe(''a) =
  | Nothing        => [v| v === Nothing ]
  | Just (z:''a)   => [v| v === (Just∘z) ]
  ;

⟦val justBvX : x:int => maybe(BitVec(Size32)[v|toBitVector∘x === v])⟧
let justBvX = (x) => {
  let b = toBitVector(x);
  Just(b)
};
'
]

{ #category : #'tests-bv' }
SpriteDataPosTest >> test_MaybeBV_02 [
	self processString: '
type maybe(''a) =
  | Nothing        => [v| v === Nothing ]
  | Just (z:''a)   => [v| v === (Just∘z) ]
  ;

⟦val main : int => BitVec(Size32)[v|toBitVector∘x === v]⟧
let main = (x) => {
  let b = toBitVector(x);
  let jbvx = Just(b);
  switch(jbvx){
    | Nothing => impossible(0)
    | Just(z) => z
  }
};
'
]

{ #category : #'tests-logic' }
SpriteDataPosTest >> test_VoidIsTerminal [
	self processString: '
type void =
  | Nil
  ;

⟦val cassert : bool[b|b] => int⟧
let cassert = (b) => { 0 };

⟦val main : void => void => int⟧
let main = (x, y) => {
  let ok = x == y;
  cassert(ok)
};
'
]
