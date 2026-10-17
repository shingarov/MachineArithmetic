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
L8PosTest >> test_append_00 [
self processString: '
[--check-termination]

⟦measure len : list(''a) => int⟧

type list(''a)[v| len∘v >= 0] =
  | Nil                        => [v| v===Nil                       & (len∘v === 0) ]
  | Cons (x:''a, xs:list(''a)) => [v| v===(Cons value: x value: xs) & (len∘v === (len∘xs + 1)) ]
  ;

⟦reflect append : zs:list(''a) => list(''a) => list(''a) / [len∘zs]⟧
let rec append = (zs, ys) => {
  switch (zs) {
  | Nil        => ys
  | Cons(h, t) => let rest = append(t, ys);
                  Cons(h, rest)
  }
};


'
]

{ #category : #tests }
L8PosTest >> test_append_1234 [
self processString: '
[--check-termination]

⟦measure len : list(''a) => int⟧

type list(''a)[v| len∘v >= 0] =
  | Nil                        => [v| v===Nil                       & (len∘v === 0) ]
  | Cons (x:''a, xs:list(''a)) => [v| v===(Cons value: x value: xs) & (len∘v === (len∘xs + 1)) ]
  ;

⟦reflect append : zs:list(''a) => list(''a) => list(''a) / [len∘zs]⟧
let rec append = (zs, ys) => {
  switch (zs) {
  | Nil        => ys
  | Cons(h, t) => let rest = append(t, ys);
                  Cons(h, rest)
  }
};

⟦val append_12_34 : int => int[v|
        (append value: (Cons value: 1 value: (Cons value: 2 value: Nil)) value: (Cons value: 3 value: (Cons value: 4 value: Nil)))
        ===
        (Cons value: 1 value: (Cons value: 2 value: (Cons value: 3 value: (Cons value: 4 value: Nil)))) ]⟧
let append_12_34 = (x) => {
  0
};
'
]

{ #category : #tests }
L8PosTest >> test_append_assoc [
self processString: '
[--check-termination]

⟦measure len : list(''a) => int⟧

type list(''a)[v| len∘v >= 0] =
  | Nil                        => [v| v===Nil                       & (len∘v === 0) ]
  | Cons (w:''a, ws:list(''a)) => [v| v===(Cons value: w value: ws) & (len∘v === (len∘ws + 1)) ]
  ;

⟦reflect append : zs:list(''a) => list(''a) => list(''a) / [len∘zs]⟧
let rec append = (zs, ys) => {
  switch (zs) {
  | Nil        => ys
  | Cons(h, t) => let rest = append(t, ys);
                  Cons(h, rest)
  }
};

⟦val append_assoc : xs:list(''a) => ys:list(''a) => zs:list(''a) =>
                     int[v| (append value: (append value: xs value: ys) value: zs)
                            ===
                            (append value: xs value: (append value: ys value: zs)) ] / [len∘xs]⟧
let rec append_assoc = (xs, ys, zs) => {
  switch (xs) {
  | Nil          => 0
  | Cons(q, qs) => append_assoc(qs, ys, zs)
  }
};
'
]

{ #category : #tests }
L8PosTest >> test_listSet [
self processString: '
[--check-termination]
⟦measure len : list(''a) => int⟧
type list(''a)[v| len∘v >= 0] =
  | Nil                        => [v| v===Nil                       & (len∘v === 0) ]
  | Cons (x:''a, xs:list(''a)) => [v| v===(Cons value: x value: xs) & (len∘v === (len∘xs + 1)) ]
  ;

⟦reflect append : zs:list(''a) => list(''a) => list(''a) / [len∘zs]⟧
let rec append = (zs, ys) => {
  switch (zs) {
  | Nil        => ys
  | Cons(h, t) => let rest = append(t, ys);
                  Cons(h, rest)
  }
};

⟦reflect rev : ws:list(''a) => list(''a) / [len∘ws]⟧
let rec rev = (ws) => {
  switch (ws) {
  | Nil        => Nil
  | Cons(h, t) => let rest = rev(t);
                  let n0   = Nil;
                  let hl   = Cons(h, n0);
                  append(rest, hl)
  }
};

⟦reflect elts : l:list(''a) => Set_Set(''a) / [len∘l]⟧
let rec elts = (l) => {
  switch (l) {
  | Nil        => Set_empty(0)
  | Cons(h, t) => let rest = elts(t);
                  Set_add(rest, h)
  }
};

⟦val append_elts : as:list(''a) => bs:list(''a) =>
                     int[v|elts∘(append value: as value: bs) === (Set_cup value: elts∘as value: elts∘bs)] / [len∘as]⟧
let rec append_elts = (as, bs) => {
  switch (bs) {
  | Nil          => 0
  | Cons(xxx, xs1) => append_elts(xs1, bs)
  }
};
'
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
