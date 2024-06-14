Class {
	#name : #L4PosTest,
	#superclass : #SpriteLangPosTest,
	#category : #'SpriteLang-Tests-Complete'
}

{ #category : #'tests-safety' }
L4PosTest >> test_choose00 [
	self processString: '
/*@ val choose : ''a => ''b => ''a */
let choose = (x, y) => { x };

/*@ val check : int[v|0<=v] => int[v|0<=v] => int[v|0<=v] */
let check = (a, b) => {
  let aP  = a + 1;
  let aM  = a - 1;
  let res = choose(aP, aM);
  res
};
'
]

{ #category : #'tests-safety' }
L4PosTest >> test_choose01 [
	self processString: '
/*@ val choose : ''a => ''b => ''b */
let choose = (x, y) => { y };

/*@ val check : int[v|0<=v] => int[v|0<=v] => int[v|0<=v] */
let check = (a, b) => {
  let aM  = a - 1;
  let res = choose(aM, a);
  res
};
'
]

{ #category : #'tests-safety' }
L4PosTest >> test_foldn00 [
	self processString: '
/*@ qualif Pos(w:int): (0 <= w) */

/*@ val foldn : (''a => int[v|0<=v] => ''a) => ''a => i:int[v|0 <= v] => n:int[v|i<=v] => ''a */
let rec foldn = (f, acc, i, n) => {
  let leq = i < n;
  if (leq) {
    let ip   = i + 1;
    let accp = f(acc, i);
    foldn(f, accp, ip, n)
  } else {
    acc
  }
};

/*@ val add : x:int => y:int => int[v|v === (x + y)] */
let add = (x, y) => {
  x + y
};

/*@ val main : m:int[v|0<=v] => int[v|0<=v] */
let main = (m) => {
  foldn(add, 0, 0, m)
};
'
]

{ #category : #'tests-safety' }
L4PosTest >> test_foldn01 [
	self processString: '
/*@ qualif Pos(v:int):        (0 <= v) */
/*@ qualif Geq(v:int, n:int): (n <= v) */

/*@ val foldn : (''a => int[?] => ''a) => ''a => i:int[?] => n:int[?] => ''a */
let rec foldn = (f, acc, i, n) => {
  let leq = i < n;
  if (leq) {
    let ip = i + 1;
    let accp = f(acc, i);
    foldn(f, accp, ip, n)
  } else {
    acc
  }
};

/*@ val add : x:int => y:int => int[v|v === (x + y)] */
let add = (x, y) => {
  x + y
};

/*@ val main : m:int[v|0<=v] => int[v|0<=v] */
let main = (m) => {
  foldn(add, 0, 0, m)
};
'
]

{ #category : #'tests-safety' }
L4PosTest >> test_id00 [
	self processString: '
/*@ val id : ''a => ''a */
let id = (x) => { x };

/*@ val check1 : x:int[v|0<=v] => int[v|0<=v] */
let check1 = (y) => {
  let res  = id(y);
  res
};
'
]
