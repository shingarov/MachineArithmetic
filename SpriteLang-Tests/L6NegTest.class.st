Class {
	#name : #L6NegTest,
	#superclass : #SpriteLangNegTest,
	#category : #'SpriteLang-Tests-Complete'
}

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
