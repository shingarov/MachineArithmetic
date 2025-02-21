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
