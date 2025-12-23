Class {
	#name : #LHBasicPosTest,
	#superclass : #SpriteLangPosTest,
	#category : #'SpriteLang-Tests-LHProper'
}

{ #category : #tests }
LHBasicPosTest >> test_Poly00 [
	self processString: '
⟦val zoo : x:''a => ''a[v|v===x]⟧
let zoo = (x) => { x };
'
]
