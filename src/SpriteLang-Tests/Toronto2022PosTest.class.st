Class {
	#name : #Toronto2022PosTest,
	#superclass : #SpriteLangPosTest,
	#category : #'SpriteLang-Tests-Simple'
}

{ #category : #tests }
Toronto2022PosTest >> bc: s0 [
	^s0 + 1
	
	"
	
	| s0 |
	s0 := 's0' toInt.
	(CSSPosTest new bc: s0) 
	
	
	"

]

{ #category : #tests }
Toronto2022PosTest >> testPlusOne [
	self processString: '
/*@ val bytecodePlusOne: x:int => int[v|v === (Toronto2022PosTest new bc: x)] */
let bytecodePlusOne = (x) => {
    x + 1
};

let bar = bytecodePlusOne(10);
'
]
