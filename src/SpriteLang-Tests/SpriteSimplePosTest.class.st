Class {
	#name : #SpriteSimplePosTest,
	#superclass : #SpriteLangPosTest,
	#category : #'SpriteLang-Tests-Simple'
}

{ #category : #tests }
SpriteSimplePosTest >> test_Issue397 [
	self processString: '
⟦measure len : list(''a) => int⟧

type list(''a) =
  | Nil                        => [v| v⋅len === 0 ]
  | Cons (x:''a, xs:list(''a)) => [v| v⋅len === (xs⋅len + 1) ]
  ;

⟦val check: list(''a)[v| v⋅len === 0 ] => int⟧
let check = (x) => {
	0
};
'
]

{ #category : #tests }
SpriteSimplePosTest >> test_full_closure [
	self processString: '
⟦val main: int => int[v| v === 42 ]⟧
let main = (x) => {
  let x = 42;
  ⟦val f: int => int[?]⟧
  let f = (yy) => { x };
  f(1)
};
'
]

{ #category : #tests }
SpriteSimplePosTest >> test_impossible [
	self proveSafe:  '
⟦val main: int[v|v === 0] => int⟧
let main = (x) => {
	let zero = x == 0;
	if (zero) {
    1
  } else { 
    impossible(0)
  }
};
'
]
