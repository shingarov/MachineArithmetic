Class {
	#name : #L6PosTest,
	#superclass : #SpriteLangPosTest,
	#category : #'SpriteLang-Tests-Complete'
}

{ #category : #'tests-safety' }
L6PosTest >> test_apply00 [
	self processString: '
type list(''a) =
  | Nil
  | Cons(''a, list(''a))
  ;

⟦val foldRight : (''a => ''b => ''b) => ''b => list(''a) => ''b⟧
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
L6PosTest >> test_maxint [
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

⟦val test1 : a:int[v|0 < v] => b:int[v|0 < v] => int[v|0 < v]⟧ 
let test1 = (a, b) => { 
  maxInt(a, b)
};

⟦val test2 : a:int[v|v < 0] => b:int[v|v < 0] => int[v|v < 0]⟧ 
let test2 = (a, b) => { 
  maxInt(a, b)
};
'
]

{ #category : #'tests-safety' }
L6PosTest >> test_maxpoly [
	self processString: '
⟦val silly : ∀ (p : ''a => bool). x:''a[v|p value: v] => ''a[v|p value: v]⟧
let silly = (x) => {
  x
};

⟦val test1 : a:int[v|0 < v] => int[v|0 < v]⟧
let test1 = (apple) => {
  silly(apple)
};
'
]
