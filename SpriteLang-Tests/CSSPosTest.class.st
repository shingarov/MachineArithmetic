Class {
	#name : #CSSPosTest,
	#superclass : #SpriteLangPosTest,
	#category : #'SpriteLang-Tests-Toronto2022'
}

{ #category : #tests }
CSSPosTest >> bc: s0 [
	^s0 + 1
	
	"
	
	| s0 |
	s0 := 's0' toInt.
	(CSSPosTest new bc: s0) 
	
	
	"

]

{ #category : #tests }
CSSPosTest >> testPlusOne [
	self processString: '
⟦val bytecodePlusOne: x:int => int[v|v === (CSSPosTest new bc: x)]⟧
let bytecodePlusOne = (x) => {
    x + 1
};

let bar = bytecodePlusOne(10);
'
]
