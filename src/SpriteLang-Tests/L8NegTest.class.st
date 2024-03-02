Class {
	#name : #L8NegTest,
	#superclass : #SpriteLangNegTest,
	#category : #'SpriteLang-Tests-Complete'
}

{ #category : #tests }
L8NegTest >> test_42b_chain_longer [
	"Demonstrate a simple chain of reflects."
	self processString: '
[--check-termination]

⟦reflect fortyTwo : int => int⟧
let fortyTwo = (x) => {
  42
};

⟦reflect fortyTwoX : int => int⟧
let fortyTwoX = (y) => {
  let yy = fortyTwo(y);
  yy + 1
};

⟦reflect fortyTwoXX : int => int⟧
let fortyTwoXX = (z) => {
  let zz = fortyTwoX(z);
  zz + 1
};

⟦val main : int => int[v | v===42]⟧
let main = (a) => {
  let z = fortyTwoXX(a);
  z
};
'
]
