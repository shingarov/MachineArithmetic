Class {
	#name : #L8PosTest,
	#superclass : #SpriteLangPosTest,
	#category : #'SpriteLang-Tests-Complete'
}

{ #category : #tests }
L8PosTest >> test_append [
	self skip
]

{ #category : #tests }
L8PosTest >> test_listSet [
	self skip
]

{ #category : #tests }
L8PosTest >> test_poly [
	self skip
]

{ #category : #tests }
L8PosTest >> test_sum [
"In upstream, 'sum' is combination of Gauss and sum(3)=6"
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

⟦val sum_3_eq_6 : int => int[v| (sum value: 3) === 6]⟧
let sum_3_eq_6 = (n) => {0};

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

{ #category : #tests }
L8PosTest >> test_sum_3_eq_6 [
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

⟦val sum_3_eq_6 : int => int[v| (sum value: 3) === 6]⟧
let sum_3_eq_6 = (n) => {0};
'
]

{ #category : #tests }
L8PosTest >> test_sum_Gauss [
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
