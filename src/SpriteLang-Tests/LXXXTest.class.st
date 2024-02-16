Class {
	#name : #LXXXTest,
	#superclass : #SpriteLangPosTest,
	#category : #'SpriteLang-Tests-Complete'
}

{ #category : #'tests-safety' }
LXXXTest >> test_muple01 [
	self processString: '
type coord =
  | CCCC (x:int)
  ;

⟦val cassert : bool[b|b] => int ⟧
let cassert = (b) => {
  0
};

⟦val eat : coord => int ⟧
let eat = (cc) => {
  1
};

⟦val check : m:int => int ⟧
let check = (m) => {
    let z = 1;
    let p = CCCC(z);
    let i = eat(p);
    let ok = i < 0;
    cassert(ok)
};
'
]

{ #category : #'tests-safety' }
LXXXTest >> test_nil02 [
	self processString: '
type list(''a) =
  | Nil
  ;

⟦val singleton : ''a => list(''a)⟧
let singleton = (x) => {
  let t = Nil;
  t
};
'
]

{ #category : #'tests-safety' }
LXXXTest >> test_nilInt [
	self processString: '
type list =
  | Nil
  | Cons (int, list)
  ;

⟦val mknil : int => list⟧
let mknil = (x) => {
  let t = Nil;
  t
};
'
]

{ #category : #'tests-safety' }
LXXXTest >> test_nilXXX [
	self processString: '
type list(''a, ''b) =
  | Nil
  ;

⟦val singleton : ''a => ''b => list(''a, ''b)⟧
let singleton = (x, y) => {
  let t = Nil;
  t
};
'
]
