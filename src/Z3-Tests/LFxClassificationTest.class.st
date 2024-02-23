Class {
	#name : #LFxClassificationTest,
	#superclass : #TestCase,
	#category : #'Z3-Tests'
}

{ #category : #tests }
LFxClassificationTest >> testIsEBin [
	| x y |
	x := 'x' toInt.
	y := 'y' toInt.

	self assert: (x+y)  isEBin.
	self assert: (x-y)  isEBin.
	self assert: (x*y)  isEBin.
	self assert: (x/y)  isEBin.
	self assert: (x\\y) isEBin.
	
	self deny:   'x' toInt  isEBin.
	self deny:   'A' toBool isEBin.
	self deny:   Bool false isEBin.

]

{ #category : #tests }
LFxClassificationTest >> testIsECon [
	self assert:  1  toInt  isECon.
	self assert: (42 toBitVector: 32) isECon.
	self deny:   'x' toInt  isECon.
	self deny:   'A' toBool isECon.
	self assert: Bool true  isECon.
	self assert: Bool false isECon.

]

{ #category : #tests }
LFxClassificationTest >> testIsEIte [
	self assert: ('b' toBool ifThen: 1 toInt else: 2 toInt) isEIte
]

{ #category : #tests }
LFxClassificationTest >> testIsEVar [
	self assert: 'x' toInt isEVar.
	self deny:    1  toInt isEVar.
]

{ #category : #tests }
LFxClassificationTest >> testIsPAExist [
	self assert: (  'a' toInt < 0 exists: 'x' toInt  )  isPExist.
	self deny:   (  'a' toInt < 0                    )  isPExist.
	self deny:   (  'a' toInt < 0 forall: 'x' toInt  )  isPExist.
]

{ #category : #tests }
LFxClassificationTest >> testIsPAll [
	self assert: (  'a' toInt < 0 forall: 'x' toInt  )  isPAll.
	self deny:   (  'a' toInt < 0                    )  isPAll.
	self deny:   (  'a' toInt < 0 exists: 'x' toInt  )  isPAll.
]

{ #category : #tests }
LFxClassificationTest >> testIsPAnd [
	self assert: ('x' toInt < 0 & Bool true) isPAnd
]

{ #category : #tests }
LFxClassificationTest >> testIsPAtom [
	self assert: ('x' toInt < 0) isPAtom
]

{ #category : #tests }
LFxClassificationTest >> testIsPIff [
	self assert: ('A' toBool iff: 'B' toBool) isPIff.
	self deny:   ('x' toInt  ===  'y' toInt)  isPIff
]

{ #category : #tests }
LFxClassificationTest >> testIsPImp [
	self assert: ('A' toBool ==> 'B' toBool) isPImp
]

{ #category : #tests }
LFxClassificationTest >> testIsPNot [
	self assert: ('x' toInt < 0) not isPNot
]
