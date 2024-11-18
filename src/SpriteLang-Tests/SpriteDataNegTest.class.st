Class {
	#name : #SpriteDataNegTest,
	#superclass : #SpriteLangNegTest,
	#category : #'SpriteLang-Tests-Simple'
}

{ #category : #tests }
SpriteDataNegTest >> test_TwoIsNotTerminal [
	self processString: '
type two =
  | A
  | B
  ;

⟦val cassert : bool[b|b] => int⟧
let cassert = (b) => { 0 };

⟦val main : two => two => int⟧
let main = (x, y) => {
  let ok = x == y;
  cassert(ok)
};
'
]
