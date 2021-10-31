Class {
	#name : #ColjectIntoTest,
	#superclass : #TestCase,
	#category : #'MachineArithmetic-Tests-Extensions'
}

{ #category : #tests }
ColjectIntoTest >> testColjectInto1 [
	| coll result |
	coll := 1 to: 10.
	result := coll colject: 0 into: [ :a :b | a+b -> a ].
	self assert: result key equals: 55.
	self assert: result value equals: #(0 1 3 6 10 15 21 28 36 45)
]

{ #category : #tests }
ColjectIntoTest >> testColjectInto2 [
	| coll result |
	coll := 1 to: 5.
	result := coll colject: '0' into: [ :a :b | a, b printString -> a ].
	self assert: result key equals: '012345'.
	self assert: result value equals: #('0' '01' '012' '0123' '01234')
]
