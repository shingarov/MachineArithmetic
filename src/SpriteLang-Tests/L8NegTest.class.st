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

{ #category : #tests }
L8NegTest >> test_sum_3_eq_6 [
	self processString: '
[--check-termination]
⟦reflect sum : n:int => int / [n]⟧
let rec sum = (n) => {
  let base = n <= 0;
  if (base) {
    0
  } else {
    let n1 = n - 1;
    let t1 = sum(n1);
    n + t1
  }
};

⟦val sum_3_eq_6 : int => int[v| (sum value: 2) === 6]⟧
let sum_3_eq_6 = (n) => {0};
'
]

{ #category : #tests }
L8NegTest >> test_sum_Gauss [
self skip: 'Issue #265'.
	self processString: '
[--check-termination]
⟦reflect sum : n:int => int / [n]⟧
let rec sum = (n) => {
  let base = n <= 0;
  if (base) {
    10
  } else {
    let n1 = n - 1;
    let t1 = sum(n1);
    n + t1
  }
};

⟦val thm_sum : n:int[v| 0 <= v] => int[w| 2 * (sum value: n) === (n+1 * n)] / [n]⟧
let rec thm_sum = (n) => {
  let base = n <= 0;
  if (base) {
    0
  } else {
    let n1 = n - 1;
    thm_sum(n1)
  }
};
'
]
