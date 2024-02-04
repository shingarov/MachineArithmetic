Class {
	#name : #L6NegTest,
	#superclass : #SpriteLangNegTest,
	#category : #'SpriteLang-Tests-Complete'
}

{ #category : #'tests-safety' }
L6NegTest >> test_compose00 [
	" inc(inc(x)) ≠ x+3 "
	self processString: '
⟦val compose : ∀ (p : ''b => ''c => bool).
               ∀ (q : ''a => ''b => bool).
               ∀ (r : ''a => ''c => bool).
                 (x:''a => w:''b[v|q value: x value: v] => z:''c[v|p value: w value: v] => bool[v|r value: x value: z])
              => (y:''b => ''c[v|p value: y value: v])
              => (z:''a => ''b[v|q value: z value: v])
              =>  x:''a
              => ''c[v | r value: x value: v ]⟧
let compose = (cha, f, g, x) => {
  let t1 = g(x);
  let t2 = f(t1);
  let t3 = cha(x, t1, t2);
  t2
};

⟦val incr : n:int => int[v | v === (n + 1)]⟧
let incr = (n) => {
  n + 1
};

⟦val cha0 : x:int => y:int[?] => z:int[?] => bool[?]⟧
let cha0 = (x, y, z) => { true };

⟦val add2 : n:int => int[a | a === (n + 3)]⟧
let add2 = compose(cha0, incr, incr);
'
]

{ #category : #'tests-safety' }
L6NegTest >> test_deptup00 [
	self processString: '
type pair(''a, ''b)(p : ''a => ''b => bool) =
  | MkPair(x:''a, y:''b[v|p value: x value: v])
  ;

⟦val check2 : x:int => pair(int, int)((x1:int, x2:int) => [x1 > x2])⟧
let check2 = (x) => {
  let y = x + 1;
  MkPair(x, y)
};
'
]

{ #category : #'tests-safety' }
L6NegTest >> test_isort02 [
	self processString: '
type list(''a)(p : ''a => ''a => bool) =
  | Nil
  | Cons(x:''a, list(''a[v|p value: x value: v])((x1:''a, x2:''a) => [p value: x1 value: x2]))
  ;

⟦val insert : x:''a => ys:list(''a)((u1:''a, u2:''a) => [u1 <= u2]) => list(''a)((u1:''a, u2:''a) => [u1 <= u2])⟧
let rec insert = (x, ys) => {
  switch (ys) {
    | Nil           => let t = Nil;
                       Cons(x, t)
    | Cons(y0, ys1) => let cmp = y0 <= x;
                        if (cmp){
                          let tl = Cons(y0, ys1);
                          Cons(x, tl)
                        } else {
                          let tl = insert(x, ys1);
                          Cons(y0, tl)
                        }
  }
};

⟦val isort : list(''a)((u1:''a, u2:''a) => [Bool true]) => list(''a)((u1:''a, u2:''a) => [u1 <= u2])⟧
let rec isort = (xs) => {
  switch (xs){
    | Nil         => Nil
    | Cons (h, t) => let ot = isort(t);
                     insert(h, ot)
  }
};
'
]

{ #category : #'tests-safety' }
L6NegTest >> test_maxint1 [
	self processString: '
⟦val maxInt : ∀ (p : int => bool). x:int[v|p value: v] => y:int[v|p value: v] => int[v|p value: v]⟧ 
let maxInt = (x, y) => { 
  let b = x < y;
  if (b){
    y 
  } else { 
    x 
  } 
};

⟦val test1 : a:int[v|0 < v] => b:int[v|0 <= v] => int[v|0 < v]⟧ 
let test1 = (a, b) => { 
  maxInt(a, b)
};
'
]

{ #category : #'tests-safety' }
L6NegTest >> test_maxint2 [
	self processString: '
⟦val maxInt : ∀ (p : int => bool). x:int[v|p value: v] => y:int[v|p value: v] => int[v|p value: v]⟧ 
let maxInt = (x, y) => { 
  let b = x < y;
  if (b){
    y 
  } else { 
    x 
  } 
};

⟦val test2 : a:int[v|v < 0] => b:int[v|v <= 0] => int[v|v < 0]⟧ 
let test2 = (a, b) => { 
  maxInt(a, b)
};
'
]

{ #category : #'tests-safety' }
L6NegTest >> test_maxlist [
	self processString: '
type list(''a) =
  | Nil
  | Cons(''a, list(''a))
  ;

⟦val fold_right : (''a => ''b => ''b) => ''b => list(''a) => ''b⟧
let rec fold_right = (f, b, xs) => {
  switch (xs) {
    | Nil        => b
    | Cons(h, t) => let res = fold_right(f, b, t);
                    f(h, res)
  }
};

⟦val maxInt : ∀ (p : int => bool). x:int[v|p value: v] => y:int[v|p value: v] => int⟧
let maxInt = (x, y) => {
  let b = x < y;
  if (b){
    y
  } else {
    x
  }
};

⟦val maxInts : ∀ (quxx : int => bool). list(int[v|quxx value: v]) => int[v|quxx value: v]⟧
let maxInts = (xs) => {
  switch (xs) {
    | Cons(h, t) => let maxIntInst = maxInt;
                    fold_right(maxIntInst, h, t)
    | Nil        => diverge(0)
  }
};

⟦val maxPoss : list(int[v|0 <= v]) => int[v|0<v]⟧
let maxPoss = (xs) => {
  maxInts(xs)
};

⟦val maxNegs : list(int[v|v<=0]) => int[v|v<=0]⟧
let maxNegs = (xs) => {
  maxInts(xs)
};
'
]

{ #category : #'tests-safety' }
L6NegTest >> test_maxlist00_1 [
	self processString: '
type list(''a) =
  | Nil
  | Cons(''a, list(''a))
  ;

⟦val maxInt : ∀ (p : int => bool). x:int[v|p value: v] => y:int[v|p value: v] => int[v|p value: v]⟧
let maxInt = (x, y) => {
  let b = x < y;
  if (b){
    y
  } else {
    x
  }
};

⟦val maxInts : int => list(int) => int⟧
let rec maxInts = (cur, xs) => {
  switch (xs) {
    | Cons(h, t) => let newCur = maxInt(cur, h);
                    maxInts(newCur, t)
    | Nil        => (cur)
  }
};

⟦val maxPoss : list(int[v|0 <= v]) => int[v|0<=v]⟧
let maxPoss = (xs) => {
  maxInts(0, xs)
};
'
]

{ #category : #'tests-safety' }
L6NegTest >> test_maxlist00_2 [
	self processString: '
type list(''a) =
  | Nil
  | Cons(''a, list(''a))
  ;

⟦val maxInt : ∀ (p : int => bool). x:int[v|p value: v] => y:int[v|p value: v] => int[v|p value: v]⟧
let maxInt = (x, y) => {
  let b = x < y;
  if (b){
    y
  } else {
    x
  }
};

⟦val maxInts : int => list(int) => int⟧
let rec maxInts = (cur, xs) => {
  switch (xs) {
    | Cons(h, t) => let newCur = maxInt(cur, h);
                    maxInts(newCur, t)
    | Nil        => (cur)
  }
};

⟦val maxNegs : list(int[v|0 <= v]) => int[v|v<=0]⟧
let maxNegs = (xs) => {
  maxInts(0, xs)
};
'
]

{ #category : #'tests-safety' }
L6NegTest >> test_maxlist01 [
	self processString: '
⟦qualif Geq(v:int, n:int): (n <= v)⟧
⟦qualif AbsPred(v:int, f:int => bool):  (f value: v)⟧

type list(''a) =
  | Nil
  | Cons(''a, list(''a))
  ;

⟦val fold_right : (''a => ''b => ''b) => ''b => list(''a) => ''b⟧
let rec fold_right = (f, b, xs) => {
  switch (xs) {
    | Nil        => b
    | Cons(h, t) => let res = fold_right(f, b, t);
                    f(h, res)
  }
};

⟦val maxInt : ∀ (p : int => bool). x:int[v|p value: v] => y:int[v|p value: v] => int⟧
let maxInt = (x, y) => {
  let b = x < y;
  if (b){
    y
  } else {
    x
  }
};

⟦val maxInts : ∀ (quxx : int => bool). list(int[v|quxx value: v]) => int[v|quxx value: v]⟧
let maxInts = (xs) => {
  switch (xs) {
    | Cons(h, t) => let maxIntInst = maxInt;
                    fold_right(maxIntInst, h, t)
    | Nil        => diverge(0)
  }
};

⟦val maxPoss : list(int[v|0 <= v]) => int[v|0<=v]⟧
let maxPoss = (xs) => {
  maxInts(xs)
};

⟦val maxNegs : list(int[v|v<=0]) => int[v|v<=0]⟧
let maxNegs = (xs) => {
  maxInts(xs)
};
'
]
