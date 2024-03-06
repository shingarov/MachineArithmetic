Class {
	#name : #ReflectInlineNegTest,
	#superclass : #SpriteLangNegTest,
	#category : #'SpriteLang-Tests-Simple'
}

{ #category : #tests }
ReflectInlineNegTest >> test_42 [
	self processString: '
[--check-termination]

⟦reflect fortyTwo : int => int⟧
let fortyTwo = (x) => {
  43
};

⟦val main : int => int[v | v===42]⟧
let main = (a) => {
  let z = fortyTwo(a);
  z
};
'
]
