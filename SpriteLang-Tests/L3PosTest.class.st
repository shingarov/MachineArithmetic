Class {
	#name : #L3PosTest,
	#superclass : #SpriteLangPosTest,
	#category : #'SpriteLang-Tests'
}

{ #category : #'tests-safety' }
L3PosTest >> test_abs01 [
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
  let ya  = abs(y);
  let ok  = 0 <= ya;
  cassert(ok)
};
'
]

{ #category : #'tests-safety' }
L3PosTest >> test_abs02 [
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

⟦val incf: int => int⟧
let incf = (z) => {
  ⟦val wrap : (int => int[?]) => int[?]⟧
  let wrap = (f) => {
    let r = f(z);
    r + 1
  };
  let res = wrap(abs);
  let ok  = 0 <= res;
  cassert (ok)
};
'
]

{ #category : #'tests-safety' }
L3PosTest >> test_abs02debug [
	self processString: '
⟦val cassert : bool[b|b] => int⟧
let cassert = (b) => { 0 };

⟦val abs : x:int => int[v1|v1>=0]⟧
let abs = (x) => { 10 };

⟦val incf: int => int⟧
let incf = (z) => {
  ⟦val wrap : (y:int => int[?]) => int[v2|v2>=0]⟧
  let wrap = (f) => {
    let r = f(z);
    r
  };
  wrap(abs)
};
'
]

{ #category : #'tests-simple' }
L3PosTest >> test_absVC [
	self processString: '
⟦val cassert : bool[b|b] => int⟧
let cassert = (b) => { 0 };

⟦val abs : x:int => int[v|0<=v]⟧
let abs = (x) => {
  let pos = x >= 0;
  if (pos) {
    x
  } else {
    0 - x
  }
};

let main = (y) => {
  let ya  = abs(y);
  let ok  = 0 <= ya;
  cassert(ok)
};
'
]

{ #category : #'tests-safety' }
L3PosTest >> test_assert00 [
	self processString: '
⟦val cassert : bool[b|b] => int⟧
let cassert = (b) => {
  0
};

⟦val main : int => int⟧
let main = (x) => {
  let x1 = x + 1;
  let cond = x < x1;
  cassert(cond)
};
'
]

{ #category : #'tests-safety' }
L3PosTest >> test_sum01 [
	self processString: '
⟦qualif Pos(v:int):        (0 <= v)⟧
⟦qualif Geq(v:int, n:int): (n <= v)⟧


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

⟦val check1 : int => int⟧
let check1 = (y) => {
  let res  = sum(y);
  let ok   = 0 <= res;
  cassert(ok)
};

⟦val check2 : int => int⟧
let check2 = (y) => {
  let res = sum(y);
  let ok  = y <= res;
  cassert(ok)
};
'
]
