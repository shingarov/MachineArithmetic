Class {
	#name : #L8PosTest,
	#superclass : #SpriteLangPosTest,
	#category : #'SpriteLang-Tests-Complete'
}

{ #category : #tests }
L8PosTest >> test_42 [
	self skip:'See #test_42b'.
	self processString: '
[--check-termination]
⟦reflect fortyTwo : int => int / [0]⟧
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

{ #category : #tests }
L8PosTest >> test_42b [
	self processString: '
[--check-termination]

⟦val zero : int[v | v===0]⟧
let zero = 0;

⟦reflect fortyTwo : int => int / [zero]⟧
let rec fortyTwo = (x) => {
  42
};

⟦val main : int => int[v | v===42]⟧
let main = (a) => {
  let z = fortyTwo(a);
  z
};
'
]

{ #category : #tests }
L8PosTest >> test_IncInc [
	self processString: '
[--check-termination]
⟦val zero : int[v|v === 0]⟧
let zero = 0;

⟦reflect inc : int => int / [zero]⟧
let rec inc = (x) => {
  let y = x + 1;
  y
};

⟦reflect inc2 : int => int / [zero]⟧
let rec inc2 = (x) => {
  let y = inc(x);
  let z = inc(y);
  z
};

⟦val main : int => int[v | v===3]⟧
let main = (a) => {
  let three = inc2(1);
  three
};
'
]

{ #category : #tests }
L8PosTest >> test_PleInc [
	self processString: '
[--check-termination]
⟦val zero : int[v|v === 0]⟧
let zero = 0;

⟦reflect inc : int => int / [zero]⟧
let rec inc = (x) => {
  let y = x + 1;
  y
};

⟦val main : int => int[v | v===2]⟧
let main = (a) => {
  let two = inc(1);
  two
};
'
]

{ #category : #tests }
L8PosTest >> test_adder [
	self processString: '
[--check-termination]
⟦val zero : int[v|v === 0]⟧
let zero = 0;

⟦reflect adder : int => int => int / [zero]⟧
let rec adder = (x, y) => {
  let z = x + y;
  z
};

⟦val main : int => int[v | v===11]⟧
let main = (a) => {
  let eleven = adder(5, 6);
  eleven
};
'
]

{ #category : #'tests-safety' }
L8PosTest >> test_poly [
	self processString: '
[--check-termination]
⟦val zero : int[v|v === 0]⟧
let zero = 0;

⟦reflect maxInt : x:int => y:int => int / [zero]⟧ 
let maxInt = (x, y) => { 
  let b = x < y;
  if (b){
    y 
  } else { 
    x 
  } 
};

⟦val test1 : a:int[v|0 < v] => b:int[v|0 < v] => int[v|0 < v]⟧ 
let test1 = (a, b) => { 
  maxInt(a, b)
};

⟦val test2 : a:int[v|v < 0] => b:int[v|v < 0] => int[v|v < 0]⟧ 
let test2 = (a, b) => { 
  maxInt(a, b)
};
'
]

{ #category : #tests }
L8PosTest >> test_sum100 [
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

⟦val sum_100_eq_5050 : int => int[v| (sum value: 100) === 5050]⟧
let sum_100_eq_5050 = (n) => {0};
'
]

{ #category : #tests }
L8PosTest >> test_sumGauss [
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

⟦val thm_sum : m:int[v| 0 <= v] => int[w| 2 * (sum value: m) === (m+1 * m)] / [n]⟧
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
