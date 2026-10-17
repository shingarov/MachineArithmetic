Class {
	#name : #L7PosTest,
	#superclass : #SpriteLangPosTest,
	#category : #'SpriteLang-Tests-Complete'
}

{ #category : #tests }
L7PosTest >> test_ack [
	self processString: '
[--check-termination]
⟦val ack : m:int[v|0 <= v] => n:int[v|0 <= v] => int[v|0 <= v] / [m], [n]⟧
let rec ack = (m, n) => {
  let condm = m == 0;
  let condn = n == 0;
  if (condm) {
    n + 1
  } else {
    let m1 = m - 1;
    if (condn) {
      ack (m1, 1)
    } else {
      let n1 = n - 1;
      let r  = ack(m, n1);
      ack (m1, r)
    }
  }
};
'
]

{ #category : #tests }
L7PosTest >> test_append [
self processString: '
[--check-termination]

⟦measure len : list(''a) => int⟧

type list(''a)[v| len∘v >= 0] =
  | Nil                        => [v| len∘v === 0]
  | Cons (x:''a, xs:list(''a)) => [v| len∘v === (len∘xs + 1)]
  ;

⟦val append : zs:list(''a) => list(''a) => list(''a) / [len∘zs]⟧
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
L7PosTest >> test_braid [
self processString: '
[--check-termination]

⟦measure len : list(''a) => int⟧

type list(''a)[v| len∘v >= 0] =
  | Nil                        => [v| len∘v === 0]
  | Cons (w:''a, ws:list(''a)) => [v| len∘v === (len∘ws + 1)]
  ;

⟦val braid : xs:list(''a) => ys:list(''a) => list(''a) / [len∘xs + (len∘ys)]⟧
let rec braid = (xs, ys) => {
  switch (xs) {
  | Nil => ys
  | Cons (x, zs) => {
      let tl = braid(ys, zs);
      Cons(x, tl)
    }
  }
};
'
]

{ #category : #tests }
L7PosTest >> test_braidBAD [
self processString: '
[--check-termination]

⟦measure len : list(''a) => int⟧

type list(''a)[v| len∘v >= 0] =
  | Nil                        => [v| len∘v === 0]
  | Cons (x:''a, xs:list(''a)) => [v| len∘v === (len∘xs + 1)]
  ;

⟦val braid : xs:list(''a) => ys:list(''a) => list(''a) / [len∘xs + (len∘ys)]⟧
let rec braid = (xs, ys) => {
  switch (xs) {
  | Nil => ys
  | Cons (x, zs) => {
      let tl = braid(ys, zs);
      Cons(x, tl)
    }
  }
};
'
]

{ #category : #tests }
L7PosTest >> test_listSet [
self processString: '
[--check-termination]

⟦measure len : list(''a) => int⟧
⟦measure elts : list(''a) => Set_Set(''a)⟧

type list(''a)[v| len∘v >= 0] =
  | Nil                        => [v| v === Nil & (len∘v === 0 toInt) & (elts∘v === (Set_empty∘0))]
  | Cons (w:''a, ws:list(''a)) => [v| v === (Cons value: w value: ws) & (len∘ws + 1 === (len∘v)) & (elts∘v === (Set_add value: elts∘ws value: w))]
  ;

⟦val app : xs:list(''a) => ys:list(''a) => list(''a)[v|elts∘v === (Set_cup value: elts∘xs value: elts∘ys)]  / [len∘xs]⟧
let rec app = (xs, ys) => {
  switch (xs) {
  | Nil => ys
  | Cons (h, t) => {
      let rest = app(t, ys);
      Cons(h, rest)
    }
  }
};
'
]

{ #category : #tests }
L7PosTest >> test_listSetBAD [
self processString: '
[--check-termination]

⟦measure len : list(''a) => int⟧
⟦measure elts : list(''a) => Set_Set(''a)⟧

type list(''a)[v| len∘v >= 0] =
  | Nil                        => [v| v === Nil & (len∘v === 0 toInt) & (elts∘v === (Set_empty∘0))]
  | Cons (x:''a, xs:list(''a)) => [v| v === (Cons value: x value: xs) & (len∘xs + 1 === (len∘v)) & (elts∘v === (Set_add value: elts∘xs value: x))]
  ;

⟦val app : xs:list(''a) => ys:list(''a) => list(''a)[v|elts∘v === (Set_cup value: elts∘xs value: elts∘ys)]  / [len∘xs]⟧
let rec app = (xs, ys) => {
  switch (xs) {
  | Nil => ys
  | Cons (h, t) => {
      let rest = app(t, ys);
      Cons(h, rest)
    }
  }
};
'
]

{ #category : #tests }
L7PosTest >> test_range [
self processString: '
[--check-termination]

⟦measure len : list(''a) => int⟧

type list(''a)[v| len∘v >= 0] =
  | Nil                        => [v| len∘v === 0]
  | Cons (w:''a, ws:list(''a)) => [v| len∘v === (len∘ws + 1)]
  ;

⟦val range : a:int => b:int => list(int) / [j-i]⟧
let rec range = (i, j) => {
  let cond = i < j;
  if (cond) {
    let i1 = i + 1;
    let tl = range(i1, j);
    Cons(i, tl)
  } else {
    Nil
  }
};
'
]

{ #category : #tests }
L7PosTest >> test_rangeBAD [
self processString: '
[--check-termination]

⟦measure len : list(''a) => int⟧

type list(''a)[v| len∘v >= 0] =
  | Nil                        => [v| len∘v === 0]
  | Cons (x:''a, xs:list(''a)) => [v| len∘v === (len∘xs + 1)]
  ;

⟦val range : i:int => j:int => list(int) / [j-i]⟧
let rec range = (i, j) => {
  let cond = i < j;
  if (cond) {
    let i1 = i + 1;
    let tl = range(i1, j);
    Cons(i, tl)
  } else {
    Nil
  }
};
'
]

{ #category : #tests }
L7PosTest >> test_sum [
	self processString: '
[--check-termination]
⟦val sum : n:int => int[v|0 <= v] / [n]⟧
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
'
]

{ #category : #tests }
L7PosTest >> test_sumAcc [
	self processString: '
[--check-termination]
⟦val sumAcc : total:int => n:int => int / [n]⟧
let rec sumAcc = (total, n) => {
  let cond = n <= 0;
  if (cond) {
    total
  } else {
    let n1 = n - 1;
    let tot1 = total + n;
    sumAcc(tot1, n1)
  }
};
'
]

{ #category : #tests }
L7PosTest >> test_sumNat [
	self processString: '
[--check-termination]
⟦val sum : n:int[v|0 <= v] => int[v|0 <= v] / [n]⟧
let rec sum = (n) => {
    let cond = n == 0;
    if (cond) {
        0
    } else {
        let n1 = n-1;
        let t1 = sum(n1);
        n + t1
    }
};
'
]

{ #category : #tests }
L7PosTest >> test_sumNatBV [
	self processString: '
[--check-termination]
⟦val sum : n:BitVec(Size8) => BitVec(Size8) / [n]⟧
let rec sum = (n) => {
    let zero = toBitVector(0);
    let one  = toBitVector(1);
    let cond = n == zero;
    if (cond) {
        zero
    } else {
        let n1 = bvsub(n,one);
        let t1 = sum(n1);
        bvadd(n,t1)
    }
};
'
]
