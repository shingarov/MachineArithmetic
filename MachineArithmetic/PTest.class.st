Class {
	#name : #PTest,
	#superclass : #TestCase,
	#category : #'MachineArithmetic-Tests'
}

{ #category : #tests }
PTest >> testAssign [
	| var |
	var := P evalAndAssign: '1+1'.
	self assert: var value equals: 2

]

{ #category : #tests }
PTest >> testConnectivity [
	self assert: (P send: '1') isString
]

{ #category : #tests }
PTest >> testDictionary [
	| answer |
	answer := (P eval: '{"a": 1, "b": 2}').
	self assert: answer isDictionary.
	self assert: (answer at: 'a') equals: 1.
	self assert: (answer at: 'b') equals: 2.
	self assert: (answer size) equals: 2

	
]

{ #category : #tests }
PTest >> testRawExec [
	| var |
	var := P env: 'testRawExec123'.
	P rawExec: var, ' = 123'.
	"Actually, the raw exec ends here.
	Everything below, is higher level"
	self assert: (P eval: var) equals: 123
]

{ #category : #tests }
PTest >> testReadVarValue [
	| var name ref |
	var := ExternalID new.
	name := var name.
	ref := P env: name.
	P rawExec: ref, ' = 123'.
	self assert: var value equals: 123

]

{ #category : #tests }
PTest >> testSendJsonToP [
	| dict var answer |
	dict := Dictionary new 
		at: 'b' put: 52.4;
		at: 's' put: 40;
		at: 'm' put: 33.5;
		yourself.
	var := P sendAndAssignObject: dict.
	answer := P fetchVar: var.
	self assert: answer equals: dict
	
]

{ #category : #tests }
PTest >> testSendList [
	| x y list answer |
	x := IntValue value: 1234 length: 32.
	y := IntValue value: 5678 length: 32.
	list := Array with: x with: y.
	answer := P sendAndAssignList: list.
	self assert: (P compute: answer ref, '[0]') equals: x.
	self assert: (P compute: answer ref, '[1]') equals: y.
]
