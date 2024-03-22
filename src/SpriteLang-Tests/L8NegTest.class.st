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

{ #category : #tests }
L8NegTest >> test_IncInc [
	self processString: '
[--check-termination]

⟦reflect inc : int => int⟧
let inc = (a) => {
  let t = a - 1;
  t
};

⟦reflect inc2 : int => int⟧
let inc2 = (x) => {
  let y = inc(x);
  let z = inc(y);
  z
};

⟦val main : int => int[v | v===3]⟧
let main = (arg) => {
  let three = inc2(1);
  three
};
'
]
