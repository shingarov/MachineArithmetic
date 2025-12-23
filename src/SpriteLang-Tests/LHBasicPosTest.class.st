Class {
	#name : #LHBasicPosTest,
	#superclass : #SpriteLangPosTest,
	#category : #'SpriteLang-Tests-LHProper'
}

{ #category : #tests }
LHBasicPosTest >> test_List00 [
	self processString: '
type list(''a) =
  | Emp
  ;

⟦val foo : list(''a) => int[v|20 <= v]⟧
let foo = (x) => {
  switch (x) {
    | Emp => 100
  }
};
'
]

{ #category : #tests }
LHBasicPosTest >> test_Poly00 [
	self processString: '
⟦val zoo : x:''a => ''a[v|v===x]⟧
let zoo = (x) => { x };
'
]
