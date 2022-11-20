Class {
	#name : #L5NegTest,
	#superclass : #SpriteLangNegTest,
	#category : #'SpriteLang-Tests-Complete'
}

{ #category : #tests }
L5NegTest >> test_append00 [
	self processString: '
⟦measure len : list(''a) => int⟧

type list(''a) =
  | Nil => [v| (len value: v) === 0]
  | Cons (x:''a, xs:list(''a)) => [v| (len value: v) === (1 + (len value: xs))]
  ;

⟦val append : xs:list(''a) => ys:list(''a) => list(''a)[v|(len value: v) === ((len value: xs) + (len value: ys))]⟧
let rec append = (xs, ys) => {
  switch (xs) {
    | Nil        => ys
    | Cons(h, t) => append(t, ys)
  }
};
'
]

{ #category : #tests }
L5NegTest >> test_cons00 [
	self processString: '
⟦measure len : list(''a) => int⟧

type list(''a) =
  | Nil                      => [v| (len value: v) === 0]
  | Cons (x:''a, xs:list(''a)) => [v| (len value: v) === (1 + (len value: xs))]
  ;

⟦val singleton : ''a => list(''a)[v|(len value: v) === 10]⟧
let singleton = (x) => {
  let t = Nil;
  Cons(x, t)
};
'
]

{ #category : #tests }
L5NegTest >> test_head00 [
	self processString: '
type list(''a) =
  | Nil
  | Cons (''a, list(''a))
  ;

⟦val singleton : ''a => list(''a)⟧
let singleton = (x) => {
  let t = Nil;
  Cons(x, t)
};

⟦val head : list(''a) => ''a⟧
let head = (xs) => {
  switch(xs){
    | Cons(h,t) => h
    | Nil       => diverge(0)
  }
};

⟦val check : x:int[v|0 <= v] => int[v|10 <= v]⟧
let check = (z) => {
  let l = singleton(z);
  head(l)
};
'
]

{ #category : #tests }
L5NegTest >> test_nil00 [
	self processString: '
⟦measure len : list(''a) => int⟧

type list(''a) =
  | Nil                      => [v| (len value: v) === 0]
  | Cons (x:''a, xs:list(''a)) => [v| (len value: v) === (1 + (len value: xs))]
  ;

⟦val singleton : ''a => list(''a)[v|(len value: v) === 1]⟧
let singleton = (x) => {
  let t = Nil;
  t
};
'
]

{ #category : #tests }
L5NegTest >> test_olist00 [
	self processString: '
type olist(''a) =
  | ONil
  | OCons (x:''a, xs:olist(''a[v| x < v]))
  ;

⟦val bar : apple:int => horse: olist(int) => olist(int)⟧
let bar = (apple, horse) => {
  OCons(apple, horse)
};
'
]

{ #category : #tests }
L5NegTest >> test_olist01 [
	self processString: '
type olist(''a) =
  | ONil
  | OCons (x:''a, xs:olist(''a[v| x < v]))
  ;

⟦val foo : n:int => olist(int)⟧
let foo = (n) => {
  let n0 = n + 1;
  let n1 = n;
  let l2 = ONil;
  let l1 = OCons(n1, l2);
  let l0 = OCons(n0, l1);
  l0
};
'
]

{ #category : #tests }
L5NegTest >> test_olist02 [
	self processString: '
type olist(''a) =
  | ONil
  | OCons (x:''a, xs:olist(''a[v| x < v]))
  ;

⟦val mkOList : lo:int => hi:int => olist(int[v|(lo <= v) & (v < hi)])⟧
let rec mkOList = (lo, hi) => {
  let leq = lo < hi;
  if (leq) {
    let lo1 = lo + 1;
    let tl  = mkOList(lo1, hi);
    OCons(lo1, tl)
  } else {
    ONil
  }
};
'
]
