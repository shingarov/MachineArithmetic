Class {
	#name : #SpriteANFTest,
	#superclass : #SpriteLangTest,
	#category : #'Metalanguage-Tests'
}

{ #category : #running }
SpriteANFTest >> parserClass [
	^ΛοParser
]

{ #category : #tests }
SpriteANFTest >> test_ANF_01 [
	self proveSafe: '
⟦val f : x:int => int[v|v === (x+1)]⟧
let f = (x) => {
  x + 1
};

⟦val g : x:int => int[v|v === (x+1)]⟧
let g = (x) => {
  x + 1
};

⟦val main : x:int => int[v|v === (x+2)]⟧
let main = (x) => {
  let result = f(g(x));
  result
};
'
]

{ #category : #tests }
SpriteANFTest >> test_ANF_02 [
	self proveSafe: '
⟦val f : x:int => int[v|v === (x+1)]⟧
let f = (x) => {
  x + 1
};

⟦val g : x:int => int[v|v === (x+x)]⟧
let g = (x) => {
  x + x
};

⟦val main : x:int => int[v|v === (x*2+3)]⟧
let main = (x) => {
  let result = f(g(f(x)));
  result
};
'
]
