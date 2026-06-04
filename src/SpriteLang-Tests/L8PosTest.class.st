Class {
	#name : #L8PosTest,
	#superclass : #SpriteLangPosTest,
	#category : #'SpriteLang-Tests-Complete'
}

{ #category : #tests }
L8PosTest >> test_adttup00 [
self proveSafe: '

type pair(''a, ''b) =
  | MkPair(x:''a, y:''b) => [v|v === (MkPair value: x value: y)]
  ;

⟦val myTuple: junk:int => pair(int, int)[v| v === (MkPair value: 5 value: -5)] ⟧
let myTuple = (junk) => {
  let x0 = 5;
  let y0 = 0-5;
  MkPair(x0, y0)
};

'
]

{ #category : #tests }
L8PosTest >> test_append [
	self skip "cf. #tcInvs"
]

{ #category : #tests }
L8PosTest >> test_listSet [
	self skip
]

{ #category : #tests }
L8PosTest >> test_point [
	"Not part of upstream RJ's tests.
	 Cf. commit ab9bf21 in our fork."
	self proveSafe: '
type point =
  | P (x:int, y:int) => [v|v === (P value: x value: y)]
  ;

⟦val cassert : bool[b|b] => int⟧
let cassert = (b) => { 0 };

⟦val check : m:int => int ⟧
let check = (m) => {
    let p = P(42, 43);
    switch (p){
      | P(px, py) => let ok = px == 42;
                     cassert(ok)
    }
};
'
]

{ #category : #tests }
L8PosTest >> test_poly [
	self processString: '
[--check-termination]
⟦reflect cheq : ''a => ''a => bool / [0 toInt]⟧
let rec cheq = (x, y) => {
  x == y
};

⟦val test_int : int => int[v| cheq value: 2 value:2 ]⟧
let test_int = (x) => {
  0
};

⟦val test_bool : int => int[v| cheq value: Bool true value: Bool true ]⟧
let test_bool = (x) => {
  0
};
'
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

{ #category : #tests }
L8PosTest >> test_sum_Gauss′ [
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
