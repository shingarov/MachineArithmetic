Class {
	#name : #L5PosTest,
	#superclass : #SpriteLangPosTest,
	#category : #'SpriteLang-Tests-Complete'
}

{ #category : #'tests-simple' }
L5PosTest >> test_SplitToOr00 [
	"A split in the structure, leads to an or in the logic.
	
	Suppose we have a duopod ISA with two instructions,
	A and B, encoded as 0 and 1.
	Then any instruction's encoding is 0 or 1."

	self processString: '
⟦measure encoding: instruction => int⟧

type instruction =
  | A => [v| v ∘ encoding === 0 ]
  | B => [v| v ∘ encoding === 1 ]
  ;

⟦val cassert : bool[b|b] => int⟧
let cassert = (b) => {
  0
};

⟦val encode : insn:instruction => int[?]⟧
let encode = (insn) => {
  switch (insn) {
    | A => 0
    | B => 1
  }
};

⟦val main: insn:instruction => int⟧
let main = (insn) => {
  let e = encode(insn);
  let isZero = e == 0;
  let isOne  = e == 1;
  let good = isZero || isOne;
  cassert(good)
};
'
]

{ #category : #'tests-simple' }
L5PosTest >> test_SplitToOr01 [
	"A split in the structure, leads to an or in the logic.
	
	Suppose we have a duopod ISA with two instructions,
	A and B, encoded as 0 and 1.
	Then any instruction's encoding is 0 or 1."

	self processString: '
⟦measure encoding : instruction => int⟧

type instruction =
  | A => [v| v ∘ encoding === 0 ]
  | B => [v| v ∘ encoding === 1 ]
  ;

⟦val encode: insn:instruction=>int[v | insn ∘ encoding === v ]⟧
let encode = (insn) => {
  switch (insn) {
    | A => 0
    | B => 1
  }
};
'
]

{ #category : #'tests-safety' }
L5PosTest >> test_append00 [
	self processString: '
⟦measure len : list(''a) => int⟧

type list(''a) =
  | Nil => [v| v∘len === 0 ]
  | Cons (x:''a, xs:list(''a)) => [v| v∘len === (xs∘len + 1) ]
  ;

⟦val append : xs:list(''a) => ys:list(''a) => list(''a)[v| v∘len === ((xs∘len) + (ys∘len)) ]⟧
let rec append = (xs, ys) => {
  switch (xs) {
    | Nil        => ys
    | Cons(h, t) => let rest = append(t, ys);
                    Cons(h, rest)
  }
};
'
]

{ #category : #'tests-simple' }
L5PosTest >> test_appendInt [
	self processString: '
⟦measure len : list(''a) => int⟧

type list(''a) =
  | Nil => [v| v∘len === 0 ]
  | Cons (x:''a, xs:list(''a)) => [v| v∘len === (xs∘len + 1) ]
  ;
⟦val append : xs:list(int) => ys:list(int) => list(int)[v| v∘len === ((xs∘len) + (ys∘len)) ]⟧
let rec append = (xs, ys) => {
  switch (xs) {
    | Nil        => ys
    | Cons(h, t) => let rest = append(t, ys);
                    Cons(h, rest)
  }
};
'
]

{ #category : #'tests-safety' }
L5PosTest >> test_cons00 [
	self processString: '
⟦measure len : list(''a) => int⟧

type list(''a) =
  | Nil                      => [v| v∘len === 0 ]
  | Cons (x:''a, xs:list(''a)) => [v| v∘len === (xs∘len + 1) ]
  ;

⟦val singleton : ''a => list(''a)[v| v∘len === 1 ]⟧
let singleton = (x) => {
  let t = Nil;
  Cons(x, t)
};
'
]

{ #category : #'tests-safety' }
L5PosTest >> test_foldRight00 [
	self processString: '
type list(''a) =
  | Nil
  | Cons (''a, list(''a))
  ;

⟦val foldRight : (''alice => ''bob => ''bob) => ''bob => list(''alice) => ''bob⟧
let rec foldRight = (f, b, xs) => {
  switch (xs) {
    | Nil        => b
    | Cons(h, t) => let res = foldRight(f, b, t);
                    f(h, res)
  }
};
'
]

{ #category : #'tests-safety' }
L5PosTest >> test_head00 [
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

⟦val check : x:int[v|0 <= v] => int[v|0 <= v]⟧
let check = (z) => {
  let l = singleton(z);
  head(l)
};
'
]

{ #category : #'tests-safety' }
L5PosTest >> test_head01 [
	self processString: '
⟦measure len : list(''a) => int⟧

type list(''a) =
  | Nil                        => [v| v∘len === 0 ]
  | Cons (x:''a, xs:list(''a)) => [v| v∘len === (xs∘len + 1) ]
  ;

⟦val head : list(''a)[v|v∘len > 0] => ''a⟧
let head = (xs) => {
  switch(xs){
    | Cons(h, t) => h
    | Nil        => impossible(0)
  }
};

⟦val singleton : ''a => list(''a)[v|v∘len === 1]⟧
let singleton = (x) => {
  let t = Nil;
  Cons(x, t)
};

⟦val check : x:int => int⟧
let check = (z) => {
  let l = singleton(z);
  head(l)
};
'
]

{ #category : #'tests-safety' }
L5PosTest >> test_isort00 [
	self processString: '
⟦measure len : list(''a) => int⟧

type list(''a) =
  | Nil                        => [v| v∘len === 0 ]
  | Cons (x:''a, xs:list(''a)) => [v| v∘len === (xs∘len + 1) ]
  ;


⟦val insert : x:''a => ys:list(''a) => list(''a)[v| v∘len === (ys∘len + 1) ]⟧
let rec insert = (x, ys) => {
  switch (ys) {
    | Nil           => let t = Nil;
                       Cons(x, t)
    | Cons(y0, ys1) => let cmp = x <= y0;
                       if (cmp){
                          let tl = Cons(y0, ys1);
                          Cons(x, tl)
                        } else {
                          let tl = insert(x, ys1);
                          Cons(y0, tl)
                        }
  }
};

⟦val isort : xs:list(''a) => list(''a)[v| v∘len === (xs∘len) ]⟧
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
L5PosTest >> test_isort01 [
	self processString: '
type list(''a) =
  | Nil
  | Cons(''a, list(''a))
  ;

type olist(''a) =
  | ONil
  | OCons (x:''a, xs:olist(''a[v| x <= v]))
  ;

⟦val insert : x:''a => ys:olist(''a) => olist(''a)⟧
let rec insert = (x, ys) => {
  switch (ys) {
    | ONil           => let t = ONil;
                        OCons(x, t)
    | OCons(y0, ys1) => let cmp = x <= y0;
                        if (cmp){
                          let tl = OCons(y0, ys1);
                          OCons(x, tl)
                        } else {
                          let tl = insert(x, ys1);
                          OCons(y0, tl)
                        }
  }
};

⟦val isort : list(''a) => olist(''a)⟧
let rec isort = (xs) => {
  switch (xs){
    | Nil         => ONil
    | Cons (h, t) => let ot = isort(t);
                     insert(h, ot)
  }
};
'
]

{ #category : #'tests-safety' }
L5PosTest >> test_listSet [
	self processString: '
⟦measure elts : list(''a) => Set_Set(''a)⟧

type list(''a) =
  | Nil                      => [v| (elts value: v) isEmptySet]
  | Cons (x:''a, xs:list(''a)) => [v| (elts value: v) === ((elts value: xs) add: x)]
  ;


⟦val app : xs:list(''a) => ys:list(''a) => list(''a)[v|(elts value: v) === ((elts value: xs) ∪ (elts value: ys))]⟧
let rec app = (xs, ys) => {
  switch (xs) {
    | Nil        => ys
    | Cons(h, t) => let rest = app(t,ys);
                    Cons(h, rest)
  }
};
'
]

{ #category : #'tests-safety' }
L5PosTest >> test_nil00 [
	self processString: '
⟦measure len : list(''a) => int⟧

type list(''a) =
  | Nil                        => [v| v∘len === 0 ]
  | Cons (x:''a, xs:list(''a)) => [v| v∘len === (xs∘len + 1) ]
  ;

⟦val singleton : ''a => list(''a)[v| v∘len === 0 ]⟧
let singleton = (x) => {
  let t = Nil;
  t
};
'
]

{ #category : #'tests-safety' }
L5PosTest >> test_nil0000 [
	self processString: '
type list(''a) =
  | Nil
  | Cons (x:''a, xs:list(''a))
  ;

⟦val singleton : ''a => list(''a)⟧
let singleton = (x) => {
  let t = Nil;
  t
};
'
]

{ #category : #'tests-safety' }
L5PosTest >> test_nil01 [
	self processString: '
⟦measure len : list(''a) => int⟧

type list(''a) =
  | Nil                        => [v| v∘len === 0 ]
  | Cons (x:''a, xs:list(''a)) => [v| v∘len === (xs∘len + 1) ]
  ;

⟦val singleton : ''a => list(''a)⟧
let singleton = (x) => {
  let t = Nil;
  t
};
'
]

{ #category : #'tests-safety' }
L5PosTest >> test_olist00 [
	self processString: '
type olist(''a) =
  | ONil
  | OCons (x:''a, xs:olist(''a[v| x < v]))
  ;

⟦val bar : apple:int => horse: olist(int[v| apple < v ]) => olist(int)⟧
let bar = (apple, horse) => {
  OCons(apple, horse)
};
'
]

{ #category : #'tests-safety' }
L5PosTest >> test_olist01 [
	self processString: '
type olist(''a) =
  | ONil
  | OCons (x:''a, xs:olist(''a[v| x < v]))
  ;

⟦val foo : n:int => olist(int)⟧
let foo = (n) => {
  let n0 = n;
  let n1 = n0 + 1;
  let l2 = ONil;
  let l1 = OCons(n1, l2);
  let l0 = OCons(n0, l1);
  l0
};
'
]

{ #category : #'tests-safety' }
L5PosTest >> test_olist02 [
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
    OCons(lo, tl)
  } else {
    ONil
  }
};
'
]

{ #category : #'tests-safety' }
L5PosTest >> test_single00 [
	self processString: '
type list(''a) =
  | Nil
  | Cons(''a, list(''a))
  ;

⟦val singleton : int[v|0 <= v]  => list(int[v|0 <= v])⟧
let singleton = (x) => {
  let t = Nil;
  Cons(x, t)
};
'
]

{ #category : #'tests-safety' }
L5PosTest >> test_tail01 [
	self processString: '
⟦measure len : list(''a) => int⟧

type list(''a) =
  | Nil                        => [v| v∘len === 0 ]
  | Cons (x:''a, xs:list(''a)) => [v| v∘len === (xs∘len + 1) ]
  ;

⟦val tail: zs:list(''a)[v|v∘len > 0] => list(''a)[v| v∘len === (zs∘len - 1) ]⟧
let tail = (zs) => {
  switch(zs){
    | Cons(h, t) => t
    | Nil        => impossible(0)
  }
};
'
]

{ #category : #'tests-safety' }
L5PosTest >> test_tuple00 [
	self processString: '
type coord =
  | C (x:int, y:int[v|x < v])
  ;

⟦val cassert : bool[b|b] => int ⟧
let cassert = (b) => {
  0
};

⟦val mk : n:int => coord ⟧
let mk = (n) => {
  let n1 = n + 1;
  C(n, n1)
};

⟦val check : m:int => int ⟧
let check = (m) => {
    let p = mk(m);
    switch (p){
      | C(px, py) => let ok = px < py;
                     cassert(ok)
    }
};
'
]
