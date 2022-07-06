Class {
	#name : #L4NegTest,
	#superclass : #SpriteLangNegTest,
	#category : #'SpriteLang-Tests'
}

{ #category : #tests }
L4NegTest >> test_choose00 [
	self processString: '
⟦val choose : ''a => ''b => ''a⟧
let choose = (x, y) => { x };

⟦val check : int[v|0<=v] => int[v|0<=v] => int[v|0<=v]⟧
let check = (a, b) => {
  let aM  = a - 1;
  let res = choose(aM, a);
  res
};
'
]

{ #category : #tests }
L4NegTest >> test_choose01 [
	self processString: '
⟦val choose : ''a => ''b => ''b⟧
let choose = (x, y) => { y };

⟦val check : int[v|0<=v] => int[v|0<=v] => int[v|0<=v]⟧
let check = (a, b) => {
  let aM  = a - 1;
  let res = choose(a, aM);
  res
};
'
]

{ #category : #tests }
L4NegTest >> test_foldn00 [
	self processString: '


⟦val foldn : (''a => int => ''a) => ''a => int => int => ''a⟧
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

⟦val add : x:int => y:int => int[v|v === (x + y)]⟧
let add = (x, y) => {
  x + y
};

⟦val main : m:int[v|0<=v] => int[v|0<=v]⟧
let main = (m) => {
  foldn(add, 0, 0, m)
};
'
]

{ #category : #tests }
L4NegTest >> test_foldn01 [
	self processString: '



⟦val foldn : (''a => int[?] => ''a) => ''a => i:int[?] => n:int[?] => ''a⟧
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

⟦val add : x:int => y:int => int[v|v === (x + y)]⟧
let add = (x, y) => {
  x + y
};

⟦val main : m:int[v|0<=v] => int[v|0<=v]⟧
let main = (m) => {
  foldn(add, 0, 0, m)
};
'
]

{ #category : #tests }
L4NegTest >> test_id00 [
	self processString: '
⟦val id : ''a => ''a⟧
let id = (x) => { x };

⟦val check1 : x:int[v|0<=v] => int[v|0<=v]⟧
let check1 = (y) => {
  let y1  = y - 1;
  let res = id(y1);
  res
};
'
]
