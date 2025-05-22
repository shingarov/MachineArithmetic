Class {
	#name : #SpriteDataPosTest,
	#superclass : #SpriteLangPosTest,
	#category : #'SpriteLang-Tests-Simple'
}

{ #category : #tests }
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

{ #category : #tests }
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
