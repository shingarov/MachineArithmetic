Class {
	#name : #ReflectPLENegTest,
	#superclass : #SpriteLangNegTest,
	#category : #'SpriteLang-Tests-Simple'
}

{ #category : #tests }
ReflectPLENegTest >> test_42 [
	self processString: '
[--check-termination]
⟦reflect fortyTwo : int => int / [0 toInt]⟧
let rec fortyTwo = (x) => {
  43
};

⟦val main : int => int[v | v===42]⟧
let main = (a) => {
  let z = fortyTwo(a);
  z
};
'
]
