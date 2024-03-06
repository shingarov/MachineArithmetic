Class {
	#name : #ReflectFailingTest,
	#superclass : #SpriteLangTest,
	#category : #'SpriteLang-Tests-Simple'
}

{ #category : #tests }
ReflectFailingTest >> test_42_chain3 [
"Chain inline with PLE; opposite from chain2"
	self proveSafe: '
[--check-termination]

⟦reflect fortyTwo : int => int / [0 toInt]⟧
let rec fortyTwo = (x) => {
  42
};

⟦reflect fortyTwoX : int => int⟧
let fortyTwoX = (x) => {
  fortyTwo(x)
};

⟦val main : int => int[v | v===42]⟧
let main = (a) => {
  let z = fortyTwoX(a);
  z
};
'
]
