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

⟦val thm_sum : n:int[v| 0 <= v] => int[w| 1 halt. 2 * (sum value: n) === (n+1 * n)] / [n]⟧
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
L8PosTest >> test_sum_Gauss_01 [
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

⟦val thm_sum : n:int[v| 0 <= v] => int[w| 2 toInt * (sum value: n) === (n+1 * n)] / [n]⟧
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
L8PosTest >> test_sum_Gauss_02 [
	self processString: '
[--check-termination]
⟦reflect sum : n:bv32 => bv32 / [n toInt: true]⟧
let rec sum = (n) => {
	let base = bvle32(n,bv32(0));
	if (base) {
    bv32(0)
  } else {
    let n1 = bvsub32(n,bv32(1));
    let t1 = sum(n1);
    bvadd32(n1,t1)
	}
};

⟦val thm_sum : n:bv32[v| (v >= 0) & (v <= 5) ] => bv32[w| (2 toBitVector:32) * (sum value: n) === (n+1 * n)] / [n toInt: true]⟧
let rec thm_sum = (n) => {
  let base = bvle32(n,bv32(0));
  if (base) {
    bv32(0)
  } else {
    let n1 = bvsub32(n,bv32(1));
    thm_sum(n1)
  }
};
'.





'
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
L8PosTest >> test_sum_Gauss_02_bv8 [
	self processString: '
[--check-termination]
⟦reflect sum : n:bv8 => bv8 / [n toInt: true]⟧
let rec sum = (n) => {
	let base = bvle8(n,bv8(0));
	if (base) {
    bv8(0)
  } else {
    let n1 = bvsub8(n,bv8(1));
    let t1 = sum(n1);
    bvadd8(n1,t1)
	}
};

⟦val thm_sum : n:bv8[v| (v >= 0) & (v <= 5) ] => bv8[w| (2 toBitVector:8) * (sum value: n) === (n+1 * n)] / [n toInt: true]⟧
let rec thm_sum = (n) => {
  let base = bvle8(n,bv8(0));
  if (base) {
    bv8(0)
  } else {
    let n1 = bvsub8(n,bv8(1));
    thm_sum(n1)
  }
};
'.





'
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
