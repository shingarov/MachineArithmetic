Class {
	#name : #LHBasicNegTest,
	#superclass : #SpriteLangNegTest,
	#category : #'SpriteLang-Tests-LHProper'
}

{ #category : #tests }
LHBasicNegTest >> test_Poly00 [
	self processString: '
⟦val zoo : x:''a => ''a[v|v~==x]⟧
let zoo = (x) => { x };
'
]
