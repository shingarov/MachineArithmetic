Class {
	#name : #L3NegTest,
	#superclass : #SpriteLangNegTest,
	#category : #'SpriteLang-Tests-Complete'
}

{ #category : #tests }
L3NegTest >> test_3 [
	self processString: '
⟦val assertAllowable : int[v|(v===1)|(v===2)] => int⟧
let assertAllowable = (v) => { 0 };

⟦val f : int => int[?]⟧
let f = (x) => {
  42
};

⟦val main : int => int⟧
let main = (a) => {
  let z = f(a);
  assertAllowable(z)
};
'
]

{ #category : #tests }
L3NegTest >> test_4_squareIsNonnegative [
	self processString: '
⟦val assert : bool[b|b] => int⟧
let assert = (b) => { 0 };

⟦val square : x:int => int[?]⟧
let square = (x) => {
  x * x
};

⟦val check : int => int⟧
let check = (x) => {
  let squared = square(x);
  let isPos = squared > 0;
  assert(isPos)
};
'
]

{ #category : #tests }
L3NegTest >> test_abs01 [
	self processString: '
⟦val cassert : bool[b|b] => int⟧
let cassert = (b) => { 0 };

⟦val abs : x:int => int[?]⟧
let abs = (x) => {
  let pos = x >= 0;
  if (pos) {
    x
  } else {
    0 - x
  }
};

⟦val main : int => int⟧
let main = (y) => {
  let fails = 0 <= y;
  cassert(fails)
};
'
]

{ #category : #tests }
L3NegTest >> test_abs02 [
	self processString: '
⟦val cassert : bool[b|b] => int⟧
let cassert = (b) => {
  0
};

⟦val abs : x:int => int[?]⟧
let abs = (x) => {
  let pos = 0 <= x;
  if (pos) {
     x
  } else {
     0 - x
  }
};

⟦val incf: int => int⟧
let incf = (x) => {
  ⟦val wrap : (int => int[?]) => int[?]⟧
  let wrap = (f) => {
    let r = f(x);
    r
  };
  let res = wrap(abs);
  let ok  = 0 < res;
  cassert (ok)
};
'
]

{ #category : #tests }
L3NegTest >> test_assert00 [
	self processString: '
⟦val cassert : bool[b|b] => int⟧
let cassert = (b) => {
  0
};

⟦val main : int => int⟧
let main = (x) => {
  let x1   = x - 1;
  let cond = x < x1;
  cassert(cond)
};
'
]

{ #category : #tests }
L3NegTest >> test_rebind [
	self processString: '
⟦val cassert : bool[b|b] => int⟧
let cassert = (b) => { 0 };

⟦val check : int => int⟧
let check = (y) => {
  let y1  = y-1;
  let ok  = y <= y1;
  cassert(ok)
};
'
]

{ #category : #tests }
L3NegTest >> test_rebind_simplify [
	self processString: '
⟦val cassert : bool[b|b] => int⟧
let cassert = (b) => { 0 };

⟦val check : int => int⟧
let check = (y) => {
  let ok  = y < 1;
  cassert(ok)
};
'
]

{ #category : #tests }
L3NegTest >> test_sum01 [
	self processString: '
⟦val cassert : bool[b|b] => int⟧
let cassert = (b) => { 0 };

⟦val sum : n:int => int[?]⟧
let rec sum = (n) => {
    let cond = n <= 0;
    if (cond) {
        0
    } else {
        let n1 = n-1;
        let t1 = sum(n1);
        n + t1
    }
};

⟦val check2 : int => int⟧
let check2 = (y) => {
  let y1  = y-1;
  let res = sum(y1);
  let ok  = y <= res;
  cassert(ok)
};
'
]
