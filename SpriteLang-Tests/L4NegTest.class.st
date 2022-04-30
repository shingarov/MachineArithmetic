Class {
	#name : #L4NegTest,
	#superclass : #SpriteLangNegTest,
	#category : #'SpriteLang-Tests'
}

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
