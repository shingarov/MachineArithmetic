Class {
	#name : #L8PosTest,
	#superclass : #SpriteLangPosTest,
	#category : #'SpriteLang-Tests'
}

{ #category : #'tests-safety' }
L8PosTest >> test_append [
	self processString: '
⟦ measure len : list(''a) => int ⟧

type list(''a) [v|len(v) >= 0] =
  | Nil                      => [v| v = Nil && len v = 0]
  | Cons (x:''a, xs:list(''a)) => [v| v = Cons(x, xs) && len v = 1 + len(xs)]
  ;

⟦ reflect app : xs:list(''a) => list(''a) => list(''a) / len(xs) ⟧
let rec app = (xs, ys) => {
  switch (xs) {
  | Nil        => ys
  | Cons(h, t) => let rest = app(t, ys);
                  Cons(h, rest)
  }
};

⟦ val app_12_34 : int => int[v|app(Cons(1, Cons(2, Nil)), Cons(3, Cons(4, Nil))) = Cons(1, Cons(2, Cons(3, Cons(4, Nil))))] ⟧
let app_12_34 = (x) => {
  0
};

⟦ val app_assoc : xs:list(''a) => ys:list(''a) => zs:list(''a) =>
                     int[v|app(app(xs, ys), zs) = app(xs, app(ys, zs))] / len(xs)
 ⟧
let rec app_assoc = (xs, ys, zs) => {
  switch (xs) {
  | Nil          => 0
  | Cons(x, xs'') => app_assoc(xs'', ys, zs)
  }
};
'
]

{ #category : #'tests-safety' }
L8PosTest >> test_listSet [
	self processString: '
⟦ measure len : list(''a) => int ⟧
type list(''a) [v|len(v) >= 0] = 
  | Nil                      => [v| v = Nil && len(v) = 0]  
  | Cons (x:''a, xs:list(''a)) => [v| v = Cons(x, xs) && len (v) = 1 + len(xs)]
  ; 

⟦ reflect app : xs:list(''a) => list(''a) => list(''a) / len(xs) ⟧
let rec app = (xs, ys) => { 
  switch (xs) { 
  | Nil        => ys 
  | Cons(h, t) => let rest = app(t, ys);
                  Cons(h, rest) 
  } 
};

⟦ reflect rev : xs:list(''a) => list(''a) / len(xs) ⟧
let rec rev = (xs) => { 
  switch (xs) { 
  | Nil        => Nil
  | Cons(h, t) => let rest = rev(t);
                  let n0   = Nil;
                  let hl   = Cons(h, n0);
                  app(rest, hl) 
  } 
};

⟦ reflect elts : l:list(''a) => Set_Set(''a) / len(l) ⟧
let rec elts = (l) => { 
  switch (l) { 
  | Nil        => Set_empty(0)
  | Cons(h, t) => let rest = elts(t); 
                  Set_add(rest, h)
  } 
};

⟦ val app_elts : xs:list(''a) => ys:list(''a) => 
                     int[v|elts(app(xs, ys)) = Set_cup(elts(xs), elts(ys))] / len(xs) ⟧
let rec app_elts = (xs, ys) => { 
  switch (xs) { 
  | Nil          => 0 
  | Cons(x, xs'') => app_elts(xs'', ys)
  } 
};

⟦ val rev_elts : xs:list(''a) => int[v|elts(rev(xs)) = elts(xs)] / len(xs) ⟧
let rec rev_elts = (xs) => { 
  switch (xs) { 
  | Nil        => 0 
  | Cons(h, t) => let rest = rev(t);
                  let n0   = Nil;
                  let hl   = Cons(h, n0);
                  let pf1  = rev_elts(t); 
                  let pf2  = app_elts(rest, hl);
                  0
  }
};
'
]

{ #category : #'tests-safety' }
L8PosTest >> test_poly [
	self processString: '
⟦reflect cheq : ''a => ''a => bool / 0⟧
let rec cheq = (x, y) => {
  x == y
};

⟦val test_int : int => int[v| cheq(2, 2) ]⟧
let test_int = (x) => {
  0
};

⟦val test_bool : int => int[v| cheq(true, true) ]⟧
let test_bool = (x) => {
  0
};
'
]

{ #category : #'tests-safety' }
L8PosTest >> test_sum [
	self processString: '
⟦reflect sum : n:int => int / n⟧
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

⟦val sum_3_eq_6 : int => int[v| sum(3) = 6]⟧
let sum_3_eq_6 = (x) => {
  0
};

⟦val thm_sum : n:int[v| 0 <= v] => int[v| 2 * sum(n) = n * (n+1)] / n⟧
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
